
#include "types.h"
#include "stat.h"
#include "user.h"


// our tests not  the real usertests Todo: delete!
#define PGSIZE          4096    // bytes mapped by a page

volatile int func(volatile int *tmp){
  *tmp = *tmp + 1;
  return 3;
}

void
test2(){
   printf(1,"-------------Test 2-----------\n");
   int number = 1;
   int pid = fork();
   if(pid < 0 ){
      printf(1, "error in fork!\n");
      exit();
   } else if(pid == 0){ //child
     number = 2;
     printf(1, "in child(suppose to be 2): number is %d\n", number);
     exit();
   } else{
     number = 3;
     sleep(10);
     printf(1, "in parent(suppose to be 3): number is %d\n", number);
     wait();
   }
   printf(1, "<<<< PASS Test 2 >>>>\n");
}

int
main(int argc, char *argv[])
{
  if(*argv[1]=='0' || *argv[1]=='1'){
    printf(1,"-------------Task 1 Test-----------\n");
    // sleep(100);
    char *a = (char *)sbrk(4*PGSIZE);
    printf(1,"-------------after sbrk1-----------\n");
    // sleep(100);
    volatile int *pointer;
    pointer = (int *)(a + 3*PGSIZE);
    printf(1,"---pointer = 0x%x, &pointer = 0x%x, a = 0x%x, &a = 0x%x, main = 0x%x---\n", pointer, &pointer, a, &a, main);
    printf(1, "----accessing memory----\n");// problem ------------>
    *pointer = 12;
    printf(1, "----%d----\n", *pointer);
    printf(1, "----allocating more memory----\n");
    sbrk(PGSIZE);
    printf(1, "----accessing memory----\n");
    *pointer = (*pointer) + 8;
    printf(1, "----%d----\n", *pointer);
    sbrk(14*PGSIZE);
    printf(1,"-------------after sbrk2-----------\n");
    pointer = (int *)(a + PGSIZE * 10);
    *pointer = 99;
    func(pointer);
    printf(1, "----%d----\n", *pointer);
    printf(1, "<<<<PASS Task 1 Test >>>>\n");
  }
  if(*argv[1]=='0' || *argv[1]=='2'){
    test2();
  }
  exit();
}
