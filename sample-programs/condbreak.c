// condbreak.c: program used to demonstrate conditional break points
// in gdb. A long-winded loop is featured along with a division
// function which can cause a crash. GDB makes it easy to set
// breakpoints to stop when conditions of interest arise.

#include <stdio.h>

void dodiv(int top, int bot, int *quo, int *rem){
  int q = top / bot;
  int r = top % bot;
  *quo = q;
  *rem = r;
}

int main(int argc, char *argv[]){

  for(int i=50; i>=0; i--){
    for(int j=25; j>=0; j--){
      printf("%2d div %2d is: ",i,j);
      int q,r;
      dodiv(i,j,&q,&r);
      printf("%2d remainder %2d\n",q,r);
    }
  }

  return 0;
}
