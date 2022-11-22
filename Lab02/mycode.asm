.MODEL small
.STACK
N EQU 2
M EQU 3
P EQU 2 

.DATA 
A DB 120,120,120,-120,-120,-120
B DB 120,120,120,-120,1,1
C DW 4 DUP(?)

.CODE
.STARTUP
XOR AX, AX 
XOR SI, SI
loopa:
    XOR DI, DI
    loopb: 
        
        XOR BX, BX
        XOR DX, DX
        PUSH AX
        loopcnt:
            XOR AH, AH
            MOV AL, A[SI][BX]
            IMUL B[DI][BX]
            ADD DX, AX
            
            ;CHECK OVERFLOW
            JNO endoverflow
            CMP AX, 0
            JL negval
            JMP posval
            posval:
            MOV DX, -32768
            JMP skip
            negval:
            MOV DX, 32767
            JMP skip
            
            endoverflow:
            INC BX
            CMP BX, M
            JB loopcnt
             
        skip:
        POP AX
        PUSH DI
        MOV DI, AX
        MOV C[DI], DX
        POP DI 
        ADD AX, 2 ;because each cell is 2 byte  
        ADD DI, M 
        CMP DI, M*P
        JB loopb 
  
    ADD SI, M 
    CMP SI, N*M
    JB loopa
    
.EXIT     
END
