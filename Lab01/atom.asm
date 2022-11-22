.MODEL small
.STACK
MIN EQU 2
MAX EQU 5

.DATA
lines DB 200 DUP(?)
len DB 4 DUP(?)
alpha DB 128 DUP(0); counter alphabet
charmax DW 0
half_max DB 0

.CODE
.STARTUP

part_1:
MOV DX, 0  ;first line
LEA SI, len

readline:
;computing the index of lines, saved in DI

MOV CX, MAX ; counter of maximum char
MOV AX, DX
MUL CL
MOV DI, AX    ; DI <- DX*MAX
; SOMETHING SET DX TO ZERO

MOV CX, 0
MOV AH, 1 ; readchar

readchar:
INT 21H

MOV lines[DI], AL

CMP lines[DI], 13     ; check in ENTER
JNE endcheck      ;go to next line

CMP CX, MIN  ; skip check if below MIN, else go to next line
JB readchar
JMP nextline

endcheck:
INC CX
INC DI
CMP CX, MAX  ;MAX reached
JNE readchar ; loop 20 times

nextline:
MOV [SI], CX
INC SI
INC DX

PUSH DX
MOV AH, 2 ;Line feed
MOV DL, 10
INT 21H
MOV DL, 13
INT 21H
POP DX

CMP DX, 4
JB readline

;compute occurrences

part_2:
; ALL REGISTERS AVAILABLE
MOV DX, 0  ;first line USELESS
;LEA SI, len
lineStatistics:

MOV AX,DX
MOV CX,MAX
MUL CL
MOV DI,AX

MOV CX,0
MOV BX,0 ; MaxCurr

charOccurrencies:
MOV AL, lines[DI]
MOV AH, 0
MOV SI, AX
INC alpha[SI]

CMP BL, alpha[SI]
JAE continue

MOV BL, alpha[SI]
MOV charmax, SI ; NB: charmax DW 16 bit
;JMP continue

continue:
INC CX
INC DI
LEA SI, len
ADD SI, DX
CMP CL, [SI] ; CL because [SI] is 8 bit
JB charOccurrencies

;PRINT THE MAX CHAR
PUSH DX
MOV AH, 2
MOV DX, charmax
MOV SI, charmax
INT 21H

MOV DL, 32
INT 21H
MOV DL, 32
INT 21H

MOV DL, alpha[SI]
ADD DL, 48
INT 21H
;END PRINT THE MAX CHAR

MOV DL, alpha[SI]
SHR DL, 1
MOV half_max, DL
MOV SI, 65

printAlphaHalfMax:
CMP SI,91
JB nextcheck
CMP SI, 97
JAE nextcheck
MOV SI, 97
;IF alpha[SI] >= MAX/2
nextcheck:
MOV CL, alpha[SI]
CMP CL, half_max
JB nextchar

; PRINT
MOV AH, 2
MOV DX, SI
INT 21H

MOV DL, 32
INT 21H
MOV DL, 32
INT 21H

ADD alpha[SI], 48
MOV DL, alpha[SI]
INT 21H

MOV AH, 2 ;Line feed
MOV DL, 10
INT 21H
MOV DL, 13
INT 21H

nextchar:
INC SI
CMP SI, 123
JB printAlphaHalfMax


nextline2:
MOV AH, 2 ;Line feed
MOV DL, 10
INT 21H
MOV DL, 13
INT 21H
POP DX                        ;------------------------------------------------POP DX
INC DX
CMP DX, 4
JAE part_3

MOV DI,0

alphaInitialization:
MOV alpha[DI],0
INC DI
CMP DI, 128
JB alphaInitialization
JMP lineStatistics

part_3:


.EXIT
END
