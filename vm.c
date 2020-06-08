#include "param.h"
#include "types.h"
#include "defs.h"
#include "x86.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "elf.h"
#if SELECTION!=NONE
static char buffer[PGSIZE];// for IO to Swap file
page_cow_counters_t page_cow_counters = {0};
#endif
extern char data[];  // defined by kernel.ld

pde_t *kpgdir;  // for use in scheduler()

#define null 0;
// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
  struct cpu *c;

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
  lgdt(c->gdt, sizeof(c->gdt));
}

// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
      return 0;
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
}

// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
    if(a == last)
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}

// There is one page table per process, plus one that's used when
// a CPU is not running any process (kpgdir). The kernel uses the
// current process's page table during system calls and interrupts;
// page protection bits prevent user code from using the kernel's
// mappings.
//
// setupkvm() and exec() set up every page table like this:
//
//   0..KERNBASE: user memory (text+data+stack+heap), mapped to
//                phys memory allocated by the kernel
//   KERNBASE..KERNBASE+EXTMEM: mapped to 0..EXTMEM (for I/O space)
//   KERNBASE+EXTMEM..data: mapped to EXTMEM..V2P(data)
//                for the kernel's instructions and r/o data
//   data..KERNBASE+PHYSTOP: mapped to V2P(data)..PHYSTOP,
//                                  rw data + free physical memory
//   0xfe000000..0: mapped direct (devices such as ioapic)
//
// The kernel allocates physical memory for its heap and for user memory
// between V2P(end) and the end of physical memory (PHYSTOP)
// (directly addressable from end..P2V(PHYSTOP)).

// This table defines the kernel's mappings, which are present in
// every process's page table.
static struct kmap {
  void *virt;
  uint phys_start;
  uint phys_end;
  int perm;
} kmap[] = {
 { (void*)KERNBASE, 0,             EXTMEM,    PTE_W}, // I/O space
 { (void*)KERNLINK, V2P(KERNLINK), V2P(data), 0},     // kern text+rodata
 { (void*)data,     V2P(data),     PHYSTOP,   PTE_W}, // kern data+memory
 { (void*)DEVSPACE, DEVSPACE,      0,         PTE_W}, // more devices
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
      return 0;
    }
  return pgdir;
}

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
  kpgdir = setupkvm();
  switchkvm();
}

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
  lcr3(V2P(kpgdir));   // switch to the kernel page table
}

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
    panic("switchuvm: no pgdir");

  pushcli();
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
                                sizeof(mycpu()->ts)-1, 0);
  mycpu()->gdt[SEG_TSS].s = 0;
  mycpu()->ts.ss0 = SEG_KDATA << 3;
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
}

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
}

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
  }
  return 0;
}
#if SELECTION!=NONE
void
ResetPageCounter(struct proc *p, int index){
#if SELECTION==NFUA
  p->main_mem_pages[index].counter = 0;
#elif SELECTION==LAPA
  p->main_mem_pages[index].counter = 0xFFFFFFFF;
#endif
}

int
InitPage(pde_t *pgdir, void *va, uint pa, int index){
  if(mappages(pgdir, va, PGSIZE, pa, PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, PGSIZE, PGSIZE);
      char *v = P2V(pa);
      kfree(v);
      return -1;
    }
  myproc()->main_mem_pages[index].state_used = 1;
  myproc()->main_mem_pages[index].v_addr = va;
  myproc()->main_mem_pages[index].page_dir = pgdir;
  ResetPageCounter( myproc(), index);
  #if SELECTION==SCFIFO
  QueuePage(myproc(),index);
  #endif
  //Todo: need to update lcr3?
  return 0;
}

int
NFU_AGING_Algo(struct proc *p){
  int mm_index = 0;
  int i=0;
  uint minCounter = p->main_mem_pages[mm_index].counter;
  uint maxCounter = p->main_mem_pages[mm_index].counter;//for debug only Todo: delete
  if(p->main_mem_pages[mm_index].state_used == 0){
    panic("NFU_AGING_Algo: found unused page in main_mem_pages arr");
  }
  i++;
  while(i<16){
    if(p->main_mem_pages[i].state_used == 0)
      panic("NFU_AGING_Algo: found unused page in main_mem_pages arr");
    //finidng used page in main memory
    if(p->main_mem_pages[i].counter< minCounter){
      minCounter = p->main_mem_pages[i].counter;
      mm_index = i;
    }
    if(p->main_mem_pages[i].counter> maxCounter){
      maxCounter = p->main_mem_pages[i].counter;
    }
    i++;
  }
  return mm_index;
}

uint GetSetBits(uint num){
 int counter = 0;
 for(uint i = 0; i<31; i++){
   counter += (num>>i) & 0x1;
 }
 return counter;
}


int
LAP_AGING_Algo(struct proc *p){
  int mm_index = 0;
  int i=0;
  uint minCounter_1 = p->main_mem_pages[mm_index].counter;
  uint num_of_1 = GetSetBits(p->main_mem_pages[mm_index].counter);
  if(p->main_mem_pages[mm_index].state_used == 0){
    panic("LAP_AGING_Algo: found unused page in main_mem_pages arr");
  }
  i++;
  while(i<16){
    if(p->main_mem_pages[i].state_used == 0)
      panic("LAP_AGING_Algo: found unused page in main_mem_pages arr");
    //finidng used page in main memory
    int curr_num_of_1 = GetSetBits(p->main_mem_pages[i].counter);
    if(curr_num_of_1 < num_of_1){
      minCounter_1 = p->main_mem_pages[i].counter;
      mm_index = i;
      num_of_1 = curr_num_of_1;
    }
    else if(curr_num_of_1 == num_of_1){
      if(p->main_mem_pages[i].counter < minCounter_1){
        minCounter_1 = p->main_mem_pages[i].counter;
        mm_index = i;
      }
    }
    i++;
  }
  return mm_index;
  //return 15;
}

/*
int
RemovePageFromQueue(struct proc *p, struct page *curr_page, struct page *prev_page){
  if((prev_page ==0) || prev_page->nextPage != curr_page){
      //need to find prev
      prev_page = p-> queue_head;
      while(prev_page->nextPage!=curr_page){
        prev_page = prev_page->nextPage;
        if(prev_page == p->queue_last){
          panic("somthing wring in second chance ");
        }
      }
    }
    // last page
    if(curr_page == p->queue_last){
      p->queue_last = prev_page;
    }
    p->queue_last->nextPage = p->queue_head;
    p->queue_last = prev_page;
    p->queue_head = curr_page->nextPage;
    return curr_page->index;
}*/

int
Second_chance_FIFO_Algo(struct proc *p){
  pte_t *pte;

  for (int i=0; i< p->queue_size; i++){
    int currPageIndex = DequeuePage(p);
    if(currPageIndex == -1 || currPageIndex > MAX_PSYC_PAGES)
      panic("something wrong in page queue");
    
    struct page curr_page = p->main_mem_pages[currPageIndex];
    if(curr_page.state_used == 0)
      panic("NFU_AGING_Algo: found unused page in main_mem_pages arr");

    //finidng used page in main memory
    pte = walkpgdir(p->pgdir, curr_page.v_addr, 0);
    if(!(*pte & PTE_A))
      return currPageIndex;

    QueuePage(p,currPageIndex);
  }
  return DequeuePage(p);
}


int
GetSwapPageIndex(struct proc *p){
#if SELECTION==NFUA
  return NFU_AGING_Algo(p);
#elif SELECTION==LAPA
  return LAP_AGING_Algo(p);
#elif SELECTION==SCFIFO
  // cprintf("in SCFIFO-------->\n");
  return Second_chance_FIFO_Algo(p);
#elif SELECTION==AQ
  return NFU_AGING_Algo(p);// TODO: replace
#endif
panic("GetSwapPageIndex: no selection choosen\n");
}

void
SwapOutPage(pde_t *pgdir){
  int sp_index = 0;
  int mm_index = 0;
  while(sp_index<16){
    //finidng free page in swap file memory
    if(!myproc()->swap_file_pages[sp_index].state_used){
      break;
    }
    sp_index++;
  }
  if(sp_index > 15){
    //proc has a max MAX_TOTAL_PAGES pages
    cprintf("no space in swap file\n");
    cprintf("error: process %d needs more than 32 page, exits...\n", myproc()->pid);
    exit();
  }
  //finidng used page in main memory by algo
  mm_index = GetSwapPageIndex(myproc());
 //TODO: handle case in which the swapedout page is cow
  if(mm_index <0 || mm_index>15)
    panic("swappage: somthing wrong");

  void *mm_va = myproc()->main_mem_pages[mm_index].v_addr; // TODO: here we choose page to swapout
  //uint pa = V2P(mm_va);

  // cprintf("swapout page : 0x%x\n", mm_va);
  writeToSwapFile(myproc(), mm_va, sp_index*PGSIZE, PGSIZE);
  myproc()->swap_file_pages[sp_index].state_used =1;
  myproc()->swap_file_pages[sp_index].page_dir = myproc()->main_mem_pages[mm_index].page_dir;
  myproc()->swap_file_pages[sp_index].v_addr = mm_va;

  myproc()->main_mem_pages[mm_index].state_used = 0;
  ResetPageCounter(myproc(), mm_index);
  acquire(&page_cow_counters.lock);
  // update pte flags
  pte_t *pte = walkpgdir(pgdir, mm_va, 0);
  uint pa = PTE_ADDR(*pte);
  
  if((*pte & PTE_COW) || (*pte & PTE_COW_RO)){
    if(page_cow_counters.counters[pa/PGSIZE] == 0){
      kfree(P2V(pa));
    }
    handle_cow((uint)mm_va, COW_NO_COPY);
  } else{
    kfree(P2V(pa));
  }

  *pte |= PTE_PG;
  *pte &= ~PTE_P;
  lcr3(V2P(myproc()->pgdir));
  myproc()->swaps_out_counter+=1;
  release(&page_cow_counters.lock);
}

int    
InitFreeMemPage(uint pa, void *va){
  int i =0;
  while(i<16){
    //finidng free page in main memory
    if(!myproc()->main_mem_pages[i].state_used){
      return InitPage(myproc()->pgdir, va, pa, i);
    }
    i++;
  }
  return -1;
}
#endif
// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
#if SELECTION!=NONE
    int i =0;
    // avoiding init & shell
    if(myproc()->pid > 2){
      while(i<16){
        //finidng free page in main memory
        if(!myproc()->main_mem_pages[i].state_used){
          if( InitPage(pgdir, (char*)a, V2P(mem), i) < 0){
            panic("failed to InitPage in allocuvm\n");
          }
          break;
        }
        i++;
      }
      //couldnt find a free page in main memory
      if(i>15){
        SwapOutPage(pgdir);
        uint pa = V2P(mem);
        if(pa == 0){
          cprintf("error: process %d needs more than 32 page, exits...\n", myproc()->pid);
          exit();
        }
        InitFreeMemPage(pa, (char*)a);
      }
      continue;
    }
    else{
#endif
      //init & shell act 
      if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
        cprintf("allocuvm out of memory (2)\n");
        deallocuvm(pgdir, newsz, oldsz);
        kfree(mem);
        return 0;
      }
#if SELECTION!=NONE
    }
#endif
  }
  return newsz;
#if SELECTION!=NONE
}

int
ImportFromFilePageToBuffer(void *va){
  int  i = 0;
  while((myproc()->swap_file_pages[i].v_addr != va || myproc()->swap_file_pages[i].state_used == 0) && i< 16){
    i++;
  }
  if(i>15){
    panic("wow somthing wrong happend in PGFLT");
  }
  // free a page to buffer from swap file
  readFromSwapFile(myproc(), buffer, i*PGSIZE, PGSIZE); 
  myproc()->swap_file_pages[i].state_used = 0;
  myproc()->swap_file_pages[i].v_addr = 0;
  myproc()->swap_file_pages[i].counter = 0;
  return i;
}

void             
Handle_PGFLT(uint va){
  // cprintf("<PF 0x%x>\n", va);
  void * align_va = (void *)PGROUNDDOWN(va);
  uint pa;
  int mm_index = 0;
  pde_t *pgdir = myproc()->pgdir;
  pte_t *pte = walkpgdir(pgdir, align_va, 0);
  // cprintf("in Handle_PGFLT: *pte = 0x%x\n", *pte);
  myproc()->page_fault_counter+=1;
  if(pte == 0){
    panic("in Handle_PGFLT, no page_table exits");
  } else if(!(*pte & PTE_PG)){
    panic("in Handle_PGFLT, got T_PGFLT but page isnt in the swap file"); // TODO: check this case
  }
  // free the page to buffer from swap file
  ImportFromFilePageToBuffer(align_va);

  while(mm_index<16){
    //finidng free page in main memory
    if(!myproc()->main_mem_pages[mm_index].state_used){
      pa = V2P(kalloc());
      break;
    }
    mm_index++;
  }

  if(mm_index > 15){
    // page out mm page
    SwapOutPage(myproc()->pgdir);
    char *virpa = kalloc();
    if(virpa==0){
      panic("in Handle_PGFLT, kalloc return 0");
    }
    pa = (uint)V2P(virpa);
  }
  
  if(InitFreeMemPage(pa, align_va) < 0){
    panic("in Handle_PGFLT, unexpectedly failed to find unused entry in main_mem array of the process");
  }
  
  memmove(P2V(pa), buffer, PGSIZE);
  if( (pte = walkpgdir(pgdir, align_va, 0)) == 0){
    panic("page table isnt in physical memery after Handle_PGFLT\n");
  } else if( (*pte & PTE_P) == 0){
    panic("user page isnt in physical memery after Handle_PGFLT\n");
  }
  *pte &= ~PTE_PG;
  // cprintf("finish handle page fault, pte = 0x%x\n", *pte);
#endif
}

// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
      pa = PTE_ADDR(*pte);
      if(pa == 0)
        panic("kfree");
      char *v = P2V(pa);
      #if SELECTION!=NONE
      acquire(&page_cow_counters.lock);
      if(page_cow_counters.counters[pa/PGSIZE] == 0){
      #endif
        kfree(v);
      #if SELECTION!=NONE
      } else if(page_cow_counters.counters[pa/PGSIZE] > 0){
        page_cow_counters.counters[pa/PGSIZE]--;
      } else{
        panic("page_cow counter is negative");
      }
      release(&page_cow_counters.lock);
      #endif
      *pte = 0;
#if SELECTION!=NONE
      if(myproc()->pid>2){
        int i =0;
        while(((uint)myproc()->main_mem_pages[i].v_addr != a) && i<16){
          i++;
        }
        if(i<16 && myproc()->main_mem_pages[i].page_dir == pgdir){
          myproc()->main_mem_pages[i].state_used = 0;
          myproc()->main_mem_pages[i].page_dir = 0;
          ResetPageCounter(myproc(), i);
          #if SELECTION==SCFIFO
          QueueRemovePage(myproc(), i);
          #endif
        }
      }
#endif
    }
  }
  return newsz;
}

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
}

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
  *pte &= ~PTE_U;
}

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P)) // TODO: shouldnt be good if we have swaps
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
      kfree(mem);
      goto bad;
    }
  }
  return d;

bad:
  freevm(d);
  return 0;
}
#if SELECTION!=NONE
pde_t*
copyuvm_cow(pde_t *pgdir, uint sz)
{
  pde_t *new_pgdir;
  pte_t *pte;
  uint pa, i, flags;

  if((new_pgdir = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
    acquire(&page_cow_counters.lock);
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P)){
      release(&page_cow_counters.lock);
      continue;
    }
    if(*pte & PTE_W){
      *pte |= PTE_COW;
      *pte &= ~PTE_W;
    } else{
      *pte |= PTE_COW_RO;
    }
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    page_cow_counters.counters[pa/PGSIZE]++;
    if(mappages(new_pgdir, (void*)i, PGSIZE, pa, flags) < 0) {
      release(&page_cow_counters.lock);
      goto bad;
    }
    release(&page_cow_counters.lock);
  }
  lcr3(V2P(myproc()->pgdir));
  return new_pgdir;

bad:
  freevm(new_pgdir);
  return 0;
}
#endif
//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}

// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}

//PAGEBREAK!
// Blank page.
//PAGEBREAK!
// Blank page.
//PAGEBREAK!
// Blank page.

#if SELECTION!=NONE
void
UpdatePageCounters(){
  struct proc *p = myproc();
  pte_t *pte;
  for(int i=0; i<16; i++){
    if(p->main_mem_pages[i].state_used){
      pte = walkpgdir(p->pgdir, p->main_mem_pages[i].v_addr, 0);
      if(pte==0){
        panic("panic: UpdatePageCounters");
      }
      p->main_mem_pages[i].counter >>= 1;
      if(*pte & PTE_A){
        //shift right with 1 on msb
        p->main_mem_pages[i].counter |= 1<<31;
      }
      *pte = *pte & ~PTE_A;// reset the flag
    }
  }
  lcr3(V2P(p->pgdir));
}
#endif

void
remove_cow_flags(pte_t *pte){
  if(*pte & PTE_COW_RO){
    *pte &= ~PTE_COW_RO;
  } else if(*pte & PTE_COW){
    *pte &= ~PTE_COW;
    *pte |= PTE_W;
  } else{
    panic("remove_cow_flags: no cow case\n");
  }
}
#if SELECTION!=NONE
void
handle_cow(uint va, int copy){
  char *mem = 0;
  uint pa;
  // cprintf("<COW-handle 0x%x>\n", va);
  void * align_va = (void *)PGROUNDDOWN(va);
  pde_t *pgdir = myproc()->pgdir;
  pte_t *pte = walkpgdir(pgdir, align_va, 0);
  if(pte == 0){
    panic("in handle_cow: no pte \n");
  }
  pa = PTE_ADDR(*pte);
  remove_cow_flags(pte);
  if(page_cow_counters.counters[pa/PGSIZE] > 0){
    if(copy == COW_COPY){
      if((mem = kalloc()) == 0){
        panic("in handle_cow: kalloc return 0\n");
      }
      memmove(mem, (char*)P2V(pa), PGSIZE);
      *pte = V2P(mem) | PTE_FLAGS(*pte);
    }
    page_cow_counters.counters[pa/PGSIZE]--;
  }
  lcr3(V2P(myproc()->pgdir));
}
#endif

void
QueuePage(struct proc *p, int pageIndex){
  cprintf("in QueuePage pageindex=%d, queue size=%d\n", pageIndex, p->queue_size);
  if(pageIndex >= MAX_PSYC_PAGES || pageIndex< 0 || p->queue_size==MAX_PSYC_PAGES){
    panic("somthing wrong in QueuePage");
  }
  p->page_queue[p->queue_size] = pageIndex;
  p->queue_size++;
}

int
DequeuePage(struct proc *p){
  cprintf("in DEQueuePage, queue size=%d\n", p->queue_size);

  if(p-> queue_size ==0)
    panic("cannot dequeue empty queue");
  int output = p->page_queue[0];
  for(int i = 1; i< p->queue_size; i++){ 
      p->page_queue[i-1] = p->page_queue[i];
  }
  p->page_queue[p->queue_size -1] = -1;
  p->queue_size --;
  return output;
}

int
QueueRemovePage(struct proc *p, int pageIndex){
  cprintf("in QueueRemovePage pageindex=%d, queue size=%d\n", pageIndex, p->queue_size);

  if(pageIndex >= MAX_PSYC_PAGES || pageIndex< 0){
    panic("somthing wrong in QueueRemovePage");
  }
  int foundFlag =0;
  for(int i = 0; i< p->queue_size; i++){ 
    if(p->page_queue[i]==pageIndex){
      //found the page
      foundFlag =1;
    }
    else if(foundFlag){
      p->page_queue[i-1] = p->page_queue[i];
    }
  }
  if(foundFlag){
     p->page_queue[p->queue_size -1] = -1;
     p->queue_size --;
  }
  return foundFlag;
}