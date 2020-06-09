
#include "types.h"
#include "stat.h"
#include "user.h"



#define PGSIZE 4096

void
test2(){
   printf(1,"<<< Test 2 >>>\n");
   int number_ptr = 1;
   int pid = fork();
   if(pid < 0 ){
      printf(1, "error in fork!\n");
      exit();
   } else if(pid == 0){ //child
     number_ptr = 2;
     printf(1, "in child(suppose to be 2): number_ptr is %d\n", number_ptr);
     exit();
   } else{
     number_ptr = 3;
     sleep(10);
     printf(1, "in parent(suppose to be 3): number_ptr is %d\n", number_ptr);
     wait();
   }
   printf(1,"<<< PASS Test 2 >>>\n");
}

void
test1(){
  int *number_ptr = 0;
  printf(1,"<<< Test 1 >>>\n");
  printf(1,"call sbrk(4*PGSIZE)\n");
  char *addr = sbrk(4*PGSIZE);
  printf(1,"after call sbrk(4*PGSIZE)\n");
  sleep(10);
  printf(1,"set number_ptr to sbrk ret value plus 3*PGSIZE\n");
  number_ptr = (int *)(addr + 3*PGSIZE);
  printf(1,"access *number_ptr\n");
  *number_ptr = 12;
  printf(1, "*number_ptr = %d\n", *number_ptr);
  printf(1,"call sbrk(PGSIZE)\n");
  sbrk(PGSIZE);
  printf(1,"after call sbrk(PGSIZE)\n");
  printf(1,"access *number_ptr and increment it by 20\n");
  *number_ptr = (*number_ptr) + 20;
  printf(1, "*number_ptr = %d\n", *number_ptr);
  printf(1,"call sbrk(12*PGSIZE)\n");
  sbrk(12*PGSIZE);
  printf(1,"after call sbrk(12*PGSIZE)\n");
  number_ptr = (int *)(addr + PGSIZE * 10);
  printf(1,"set number_ptr to first sbrk ret value plus 10*PGSIZE\n");
  *number_ptr = 800;
  printf(1,"access *number_ptr set it to 800\n");
  (*number_ptr)++;
  printf(1,"access *number_ptr and increment it by 1\n");
  printf(1, "*number_ptr = %d\n", *number_ptr);
  printf(1,"<<< PASS Test 1 >>>\n");
}

int
main(int argc, char *argv[])
{
  test1();
  test2();
  
  exit();
}
