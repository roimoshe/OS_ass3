#include "types.h"
#include "stat.h"
#include "user.h"

#define PGSIZE 4096

void
Test_1(){
  int *ptr_num = 0;
  printf(1,"call sbrk(4*PGSIZE)\n");
  char *addr = sbrk(4*PGSIZE);
  printf(1,"finished: sbrk(4*PGSIZE)\n");
  sleep(10);
  printf(1,"set ptr to sbrk return value plus 3*PGSIZE\n");
  ptr_num = (int *)(addr + 3*PGSIZE);
  printf(1,"using *ptr memory\n");
  *ptr_num = 12;
  printf(1, "*ptr = %d\n", *ptr_num);
  printf(1,"call sbrk(PGSIZE)\n");
  sbrk(PGSIZE);
  printf(1,"finished: sbrk(PGSIZE)\n");
  printf(1,"using *ptr memory and add 15\n");
  *ptr_num = (*ptr_num) + 15;
  printf(1, "*ptr = %d\n", *ptr_num);
  printf(1,"call sbrk(12*PGSIZE)\n");
  sbrk(12*PGSIZE);
  printf(1,"finished: sbrk(12*PGSIZE)\n");
  ptr_num = (int *)(addr + PGSIZE * 10);
  printf(1,"set ptr to first sbrk return value and add 10*PGSIZE\n");
  *ptr_num = 700;
  printf(1,"seting *ptr memory to 700\n");
  (*ptr_num)++;
  printf(1,"using *ptr memory and ++ \n");
  printf(1, "*ptr = %d\n", *ptr_num);
}

void
Test_2(){
   int num;
   int pid = fork();
   if(pid < 0 ){
      printf(1, "Fork: error \n");
      exit();
   } 
   // child
   if(pid == 0){ 
     num = 1;
     printf(1, "Child [suppose to be 1]: num is %d\n", num);
     exit();
   } 
   // parent
   else{
     num = 0;
     sleep(10);
     printf(1, "Parent [suppose to be 0]: num is %d\n", num);
     wait();
   }
}

void  
PrintPerformance(){
  #if SELECTION==NFUA
    printf(1,"--------- policy is NFUA ---------\n");;
  #elif SELECTION==LAPA
    printf(1,"--------- policy is LAPA ---------\n");
  #elif SELECTION==SCFIFO
    printf(1,"--------- policy is SCFIFO ---------\n");
  #elif SELECTION==AQ
    printf(1,"--------- policy is AQ ---------\n");
  #endif
  
  int numberOfFreePages = getNumberOfFreePages(); 
  int pageFaultCounter = get_page_fault_counter();
  int swapsOutCounter = get_swaps_out_counter();

  printf(1,"number of free pages: %d\n", numberOfFreePages);
  printf(1,"number of swaps out pages: %d\n", swapsOutCounter);
  printf(1,"number of page faults : %d\n", pageFaultCounter);
}

int
main(int argc, char *argv[])
{
  printf(1,"--------- first test ---------\n");
  Test_1();
  printf(1,"--------- PASS the first test---------\n");
  
  printf(1,"--------- second test ---------\n");
  Test_2();
  printf(1,"--------- PASS the second test ---------\n");
  
  printf(1,"--------- policy performance ---------\n");
  PrintPerformance();
  exit();
}
