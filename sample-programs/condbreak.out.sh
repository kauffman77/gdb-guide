>> gcc -g condbreak.c           # compile

>> ./a.out                      # run
50 div 25 is:  2 remainder  0
50 div 24 is:  2 remainder  2
50 div 23 is:  2 remainder  4
50 div 22 is:  2 remainder  6
50 div 21 is:  2 remainder  8
50 div 20 is:  2 remainder 10
50 div 19 is:  2 remainder 12
50 div 18 is:  2 remainder 14
50 div 17 is:  2 remainder 16
50 div 16 is:  3 remainder  2
50 div 15 is:  3 remainder  5
50 div 14 is:  3 remainder  8
50 div 13 is:  3 remainder 11
50 div 12 is:  4 remainder  2
50 div 11 is:  4 remainder  6
50 div 10 is:  5 remainder  0
50 div  9 is:  5 remainder  5
50 div  8 is:  6 remainder  2
50 div  7 is:  7 remainder  1
50 div  6 is:  8 remainder  2
50 div  5 is: 10 remainder  0
50 div  4 is: 12 remainder  2
50 div  3 is: 16 remainder  2
50 div  2 is: 25 remainder  0
50 div  1 is: 50 remainder  0   # some error occurs here, need to debug
Floating point exception (core dumped)

>> gdb a.out
GNU gdb (GDB) 16.2
Reading symbols from a.out...

(gdb) break 19                  # break at line 19 in the inner loop
Breakpoint 1 at 0x11b4: file condbreak.c, line 19.

(gdb) run
Starting program: a.out
Breakpoint 1, main (argc=1, argv=0x7fffffffdd08) at condbreak.c:19
19	      printf("%2d div %2d is: ",i,j);

(gdb) print j                   # j is 25
$1 = 25

(gdb) cont                      # continue
Continuing.
50 div 25 is:  2 remainder  0

Breakpoint 1, main (argc=1, argv=0x7fffffffdd08) at condbreak.c:19
19	      printf("%2d div %2d is: ",i,j);

(gdb) print j                   # j is 24...
$2 = 24

(gdb) cont                      # continue
Continuing.
50 div 24 is:  2 remainder  2

Breakpoint 1, main (argc=1, argv=0x7fffffffdd08) at condbreak.c:19
19	      printf("%2d div %2d is: ",i,j);

(gdb) print j                   # j is 23... this is tedious
$3 = 23

(gdb) delete 1

(gdb) break 19 if j==15         # break only when j is a value of interest like 15
Breakpoint 2 at 0x5555555551b4: file condbreak.c, line 19.

(gdb) run                       # run from the beginning
The program being debugged has been started already.
Start it from the beginning? (y or n) y
Starting program: a.out
50 div 25 is:  2 remainder  0   # no breaks at line 19 as j does not meet the condition
50 div 24 is:  2 remainder  2
50 div 23 is:  2 remainder  4
50 div 22 is:  2 remainder  6
50 div 21 is:  2 remainder  8
50 div 20 is:  2 remainder 10
50 div 19 is:  2 remainder 12
50 div 18 is:  2 remainder 14
50 div 17 is:  2 remainder 16
50 div 16 is:  3 remainder  2

Breakpoint 2, main (argc=1, argv=0x7fffffffdd08) at condbreak.c:19
19	      printf("%2d div %2d is: ",i,j);

(gdb) print j                   # j is 15 on hitting the break point
$4 = 15

(gdb) break dodiv if bot==0     # break in function dodiv only if param bot is 0
Breakpoint 3 at 0x55555555515b: file condbreak.c, line 9.

(gdb) cont
Continuing.
50 div 15 is:  3 remainder  5
50 div 14 is:  3 remainder  8
50 div 13 is:  3 remainder 11
50 div 12 is:  4 remainder  2
50 div 11 is:  4 remainder  6
50 div 10 is:  5 remainder  0
50 div  9 is:  5 remainder  5
50 div  8 is:  6 remainder  2
50 div  7 is:  7 remainder  1
50 div  6 is:  8 remainder  2
50 div  5 is: 10 remainder  0
50 div  4 is: 12 remainder  2
50 div  3 is: 16 remainder  2
50 div  2 is: 25 remainder  0
50 div  1 is: 50 remainder  0

Breakpoint 3, dodiv (top=50, bot=0, quo=0x7fffffffdbc8, rem=0x7fffffffdbcc) at condbreak.c:9
9	  int q = top / bot;

(gdb) print bot                 # bot is 0 which will cause a bug
$5 = 0
