# My homework
HW1:
Convert input string into lowercase and remove all non-alphabet characters. you can use printf() but no scanf();
ex. Tom's brother is 6 years old. -> tomsbrotheris6yearsold

HW2:
Implement a deasm program, your program should identify every data processing, LDR, SDR, and branch instructions.
ex.
PC     Condition      instruction
0      AL             ADD
4      EQ             SUB
8      GE             B              4
12     EQ             LDR
16     AL             UND
20     LT             CMP

at pc=16, doesnt belong to the instruction mentioned above so we put UND


HW3:
Write x86 assembly code to implement arithm program which compute specific arithmetic functions and display the result to the screen. Just use: Maximum, gcd, lcm.
ex. 4 5 3
Function 3: least common multiply of 4 and 5 is 20
