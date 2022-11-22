.MODEL small
.STACK
MIN EQU 2
MAX EQU 5

.DATA 
lines DB 200 DUP(?)
len DB 4 DUP(?)
alpha DB 128 DUP(0)

.CODE
.STARTUP 

part_1:          
MOV DX, 0  ;first line
LEA SI, len

readline:
MOV CX, MAX
MOV AX, DX
MUL CL
MOV DI, AX    ; SOMETHING SET DX TO ZERO

MOV CX, 0
MOV AH, 1 ; reading    

reading: 
INT 21H

MOV lines[DI], AL 

CMP CX, MIN  ; skip check if below MIN
JB endcheck 

CMP lines[DI], 13     ; check in ENTER
JE nextline      ;go to next line

endcheck:
INC DI
INC CX
CMP CX, MAX  ;MAX reached
JNE reading ; loop 20 times

nextline:
MOV [SI], CX
INC SI
INC DX   
CMP DX, 4
JB readline


part_2:
MOV DX, 0  ;first line
LEA SI, len

countline:
MOV CX, MAX
MOV AX, DX
MUL CL
MOV DI, AX    ; SOMETHING SET DX TO ZERO

MOV CX, 0

counting:
MOV SI, lines[DI]
INC alpha[SI]





;check: 
;CMP [DI], 13
;JE nextline
;
;
;MOV CL, 0FFH
;MOV DI, 0
;ciclo: CMP CL, TABLE[DI] ; compare with current minimum
;JB dopo
;MOV CL, TABLE[DI] ; store new minimum
;dopo: INC DI
;CMP DI, DIM
;JB ciclo
;output: MOV DL, CL
;MOV AH, 2
;INT 21H ; display
.EXIT
END