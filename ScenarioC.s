/* -- Alec Blyth 0814281 -- HND Software Development -- 11/03/2018 -- ScenarioC Assembly -- */ 

/* -- Data Section -- */ 

.data

.balign 4
a:       .skip 0x00100000
.balign 4

myword : .word 0x00000000
addr_of_myword : .word myword
addr_of_a : .word a

.global main
.func main

main:

LDR R5, =0x00000000 @counter
LDR R4, addr_of_a @array address
LDR R3, addr_of_alecword @num 0
SUB R6, R3, #1

writeloop:

CMP R5, #0x00040000    @compare counter to 1/4MB
BEQ writedone         @if equal leave loop
ADD R2, R4, R5, LSL #2       @move to next mem location
STR R6, [R2]            @store -1 in r2
ADD R5, R5, #1   @increment counter
B   writeloop

writedone:

LDR R5, =0x00000000              

readloop:

CMP R5, #0x00040000            
BEQ readdone
ADD R2, R4, R5, LSL #2
LDR R7, [R2]
CMP R6, R7
BNE error
ADD R5, R5, #1
B   readloop

readdone:

LDR R5, =0x00000000     

writezeroloop:
CMP R5, #0x00040000    @compare counter to 1/4MB
BEQ writezerodone         @if equal leave loop
ADD R2, R4, R5, LSL #2       @move to next mem location
STR R3, [R2]            @store 0 in r2
ADD R5, R5, #1   @increment counter
B   writezeroloop

writezerodone:

LDR R5, =0x00000000

readzeroloop:
CMP R5, #0x00040000
BEQ _exit
ADD R2, R4, R5, LSL #2
LDR R7, [R2]
CMP R3, R7
BNE error
ADD R5, R5, #1
B   readzeroloop

error:

MOV R1, #1
bx lr

_exit:

MOV R0, #0
bx lr