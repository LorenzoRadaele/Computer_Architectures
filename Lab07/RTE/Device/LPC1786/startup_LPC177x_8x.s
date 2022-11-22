;/*****************************************************************************
; * @file:    startup_LPC177x_8x.s
; * @purpose: CMSIS Cortex-M3 Core Device Startup File
; *           for the NXP LPC177x_8x Device Series 
; * @version: V1.20
; * @date:    07. October 2010
; *------- <<< Use Configuration Wizard in Context Menu >>> ------------------
; *
; * Copyright (C) 2010 ARM Limited. All rights reserved.
; * ARM Limited (ARM) is supplying this software for use with Cortex-M3
; * processor based microcontrollers.  This file can be freely distributed
; * within development tools that are supporting such ARM based processors.
; *
; * THIS SOFTWARE IS PROVIDED "AS IS".  NO WARRANTIES, WHETHER EXPRESS, IMPLIED
; * OR STATUTORY, INCLUDING, BUT NOT LIMITED TO, IMPLIED WARRANTIES OF
; * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE APPLY TO THIS SOFTWARE.
; * ARM SHALL NOT, IN ANY CIRCUMSTANCES, BE LIABLE FOR SPECIAL, INCIDENTAL, OR
; * CONSEQUENTIAL DAMAGES, FOR ANY REASON WHATSOEVER.
; *
; *****************************************************************************/


; <h> Stack Configuration
;   <o> Stack Size (in Bytes) <0x0-0xFFFFFFFF:8>
; </h>

Stack_Size      EQU     0x0006000

                AREA    STACK, NOINIT, READWRITE, ALIGN=3
Stack_Mem       SPACE   Stack_Size
__initial_sp



; <h> Heap Configuration
;   <o>  Heap Size (in Bytes) <0x0-0xFFFFFFFF:8>
; </h>

Heap_Size       EQU     0x00000400
	
                AREA    HEAP, NOINIT, READWRITE, ALIGN=3
__heap_base
Heap_Mem        SPACE   Heap_Size
__heap_limit


                PRESERVE8
                THUMB


; Vector Table Mapped to Address 0 at Reset

                AREA    RESET, DATA, READONLY
                EXPORT  __Vectors

__Vectors       DCD     __initial_sp              ; Top of Stack
                DCD     Reset_Handler             ; Reset Handler
                DCD     NMI_Handler               ; NMI Handler
                DCD     HardFault_Handler         ; Hard Fault Handler
                DCD     MemManage_Handler         ; MPU Fault Handler
                DCD     BusFault_Handler          ; Bus Fault Handler
                DCD     UsageFault_Handler        ; Usage Fault Handler
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     SVC_Handler               ; SVCall Handler
                DCD     DebugMon_Handler          ; Debug Monitor Handler
                DCD     0                         ; Reserved
                DCD     PendSV_Handler            ; PendSV Handler
                DCD     SysTick_Handler           ; SysTick Handler

                ; External Interrupts
                DCD     WDT_IRQHandler            ; 16: Watchdog Timer
                DCD     TIMER0_IRQHandler         ; 17: Timer0
                DCD     TIMER1_IRQHandler         ; 18: Timer1
                DCD     TIMER2_IRQHandler         ; 19: Timer2
                DCD     TIMER3_IRQHandler         ; 20: Timer3
                DCD     UART0_IRQHandler          ; 21: UART0
                DCD     UART1_IRQHandler          ; 22: UART1
                DCD     UART2_IRQHandler          ; 23: UART2
                DCD     UART3_IRQHandler          ; 24: UART3
                DCD     PWM1_IRQHandler           ; 25: PWM1
                DCD     I2C0_IRQHandler           ; 26: I2C0
                DCD     I2C1_IRQHandler           ; 27: I2C1
                DCD     I2C2_IRQHandler           ; 28: I2C2
                DCD     SPIFI_IRQHandler          ; 29: SPIFI
                DCD     SSP0_IRQHandler           ; 30: SSP0
                DCD     SSP1_IRQHandler           ; 31: SSP1
                DCD     PLL0_IRQHandler           ; 32: PLL0 Lock (Main PLL)
                DCD     RTC_IRQHandler            ; 33: Real Time Clock
                DCD     EINT0_IRQHandler          ; 34: External Interrupt 0
                DCD     EINT1_IRQHandler          ; 35: External Interrupt 1
                DCD     EINT2_IRQHandler          ; 36: External Interrupt 2
                DCD     EINT3_IRQHandler          ; 37: External Interrupt 3
                DCD     ADC_IRQHandler            ; 38: A/D Converter
                DCD     BOD_IRQHandler            ; 39: Brown-Out Detect
                DCD     USB_IRQHandler            ; 40: USB
                DCD     CAN_IRQHandler            ; 41: CAN
                DCD     DMA_IRQHandler            ; 42: General Purpose DMA
                DCD     I2S_IRQHandler            ; 43: I2S
                DCD     ENET_IRQHandler           ; 44: Ethernet
                DCD     MCI_IRQHandler            ; 45: SD/MMC card I/F
                DCD     MCPWM_IRQHandler          ; 46: Motor Control PWM
                DCD     QEI_IRQHandler            ; 47: Quadrature Encoder Interface
                DCD     PLL1_IRQHandler           ; 48: PLL1 Lock (USB PLL)
                DCD     USBActivity_IRQHandler    ; 49: USB Activity interrupt to wakeup
                DCD     CANActivity_IRQHandler    ; 50: CAN Activity interrupt to wakeup
                DCD     UART4_IRQHandler          ; 51: UART4
                DCD     SSP2_IRQHandler           ; 52: SSP2
                DCD     LCD_IRQHandler            ; 53: LCD
                DCD     GPIO_IRQHandler           ; 54: GPIO
                DCD     PWM0_IRQHandler           ; 55: PWM0
                DCD     EEPROM_IRQHandler         ; 56: EEPROM


                IF      :LNOT::DEF:NO_CRP
                AREA    |.ARM.__at_0x02FC|, CODE, READONLY
CRP_Key         DCD     0xFFFFFFFF
                ENDIF
					

Tower_Heigth    EQU     0x00000100

				AREA 	STACK, NOINIT, READWRITE, ALIGN=3
myStack1		SPACE 	Tower_Heigth;
_mySP1
	
				AREA 	STACK, NOINIT, READWRITE, ALIGN=3
myStack2		SPACE 	Tower_Heigth;
_mySP2
	
				AREA 	STACK, NOINIT, READWRITE, ALIGN=3
myStack3		SPACE 	Tower_Heigth;
_mySP3

                AREA    |.text|, CODE, READONLY
					
towers			DCD 9, 6, 3, 2, 1, 8, 7, 0, 5, 4, 0
towers1			DCD 8, 7, 6, 3, 2, 1, 0, 0, 0
towers2			DCD 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0, 0, 0
	
; Reset Handler

Reset_Handler   PROC
                EXPORT  Reset_Handler             [WEAK]
				
				
				LDR r2, =0xE000ED24
				LDR r1, [r2]
				ORR r1, #0x40000	; enable usage fault (bit 18)
				; ORR r1, # 0x70000 enable all (bit 18-17-16)
				STR r1, [r2]

				
				LDR r4, =0xE000ED14
				LDR r3, [r4]
				ORR r3, #0x8
				STR r3, [r4]
				LDR r1, =myVar1
				LDR r3, [r1]		;aligned access
				LDR r2, =myVar5
				LDR r4, [r2] 		;aligned access
				LDR r2, =myVar3
				LDRH r4, [r2] 		;aligned access
				LDR r2, =myVar2
				LDRB r4, [r2] 		;aligned access

				
				
				; fill first pole
				LDR r0, =towers2
				LDR r1, =_mySP1
				BL fillStack
				MOV r5, r1		; R5 is SP1
				
				; fill second pole
				LDR r1, =_mySP2
				BL fillStack
				MOV r6, r1		; R6 is SP2
				
				; fill third pole
				LDR r1, =_mySP3
				BL fillStack
				MOV r7, r1		; R7 is SP3
				
;				PUSH {r5}	; Source Pole SP
;				PUSH {r7}	; Destination Pole SP
;				PUSH {r0}	; Returned Value
;				BL move1
;				POP {r0}	; Returned Value
;				POP {r7}	; Updated Destination Pole SP
;				POP {r5}	; Updated Source Pole SP
				
				MOV r0, #12	; #Elements to move from Source to Destination 	
				PUSH {r5}	; S
				PUSH {r7}	; D
				PUSH {r6}	; A
				PUSH {r0}	; #
				BL moveN
				POP {r0}	; #Moved elements -> check if 2^n - 1
				POP {r6}
				POP {r7}
				POP {r5}
				
STOP			B	STOP
myVar1			DCB 0x11
myVar2			DCB 0x11
myVar3			DCB 0x11
myVar4			DCB 0x11
myVar5			DCB 0x11
                ENDP
;PARAMETERS:
; r0 -> address of first element to push
; r1 -> Stack pointer
; RETURN -> updated inputs

fillStack		PROC
	
				PUSH {r4, LR}
				
				EOR r4, r4			; R4 = 0
				
				LDR r2, [r0]
				CMP r2, #0
				BEQ break0
	
				STMFD r1!, {r2}	; PUSH R2
loop 			ADD r4, #4;	; R4 <-R4 + 8
					LDR r3, [r0, r4]; R3 <-R1 [R0+R4]
					
					CMP r3, #0
					BEQ break0		; if(r3 == 0) break
					CMP r3, r2
					BCS break		; if(r3 >= R2) break

					MOV r2, r3		; update R2
					STMFD r1!, {r3}	; PUSH R3
					B loop
break0			ADD r4, #4		
break			ADD r0, r0, r4
				POP {r4, PC}
				
				ENDP
					
move1			PROC
				PUSH {r0-r4, LR}
				LDR r1, [SP, #32]	; Source Pole SP
				LDR r2, [SP, #28]	; Destination Pole SP

				EOR r0, r0	; initialize R0=0 [FAILURE]
				
				; if(r2 = mySP1 || r2 = mySP2 || r2 = mySP2) -> move
				LDR r3, =_mySP1
				CMP r2, r3
				BEQ move
				LDR r3, =_mySP2
				CMP r2, r3
				BEQ move
				LDR r3, =_mySP3
				CMP r2, r3
				BEQ move
				
				; if(R3 > R4) -> skip move
				LDR r3, [r1]	; Top element of Source Stack
				LDR r4, [r2]	; Top element of Destination Stack
				CMP r3, r4		
				BCS continue
				
move			LDMFD r1!, {r3}
				STMFD r2!, {r3}
				MOV r0, #1		; R0 = 1 [SUCCESS]

continue		STR r1, [SP, #32]	; Updated Source Pole SP
				STR r2, [SP, #28]	; Updated Destination Pole SP
				STR r0, [SP, #24]	; Returned Value
				POP {r0-r4, PC}
				
				ENDP

moveN 			PROC
				PUSH {r0-r7, LR}
				
				LDR r0, [SP,#48]	; Source
				LDR r1, [SP,#44]	; Destination
				LDR r2, [SP,#40]	; Auxiliary
				LDR r3, [SP,#36]	; ToMove#
				
				EOR r4, r4			; M=0
				
				CMP r3, #1			; if (N == 1)
				BEQ singleMove
				
				; else
				PUSH {r0}	; prepare for moveN	
				PUSH {r2}
				PUSH {r1}
				SUB r3, r3, #1
				PUSH {r3}
				BL moveN	; moveN(X, Z, Y, N-1)
				POP {r6}	; b
				POP {r1}
				POP {r2}
				POP {r0}
				ADD r4, r6	; M = M + b;
				
				PUSH {r0}	; prepare for move1
				PUSH {r1}
				PUSH {r5}	; any register is fine
				BL move1	; move1(X, Y, a)
				POP {r5}	
				POP {r1}
				POP {r0}
				
				CMP r5, #0	; 
				BEQ return	; if (a == 0) return;
				
				; else
				ADD r4, r4, #1	; M = M + 1
				
				PUSH {r2}	; prepare for moveN	
				PUSH {r1}
				PUSH {r0}
				;SUB r3, r3, #1
				PUSH {r3}
				BL moveN	; moveN(Z, Y, X, N-1)
				POP {r7}	; c
				POP {r0}
				POP {r1}
				POP {r2}
				ADD r4, r7	; M = M + c;
				
				STR r0, [SP, #48]
				STR r1, [SP, #44]
				STR r2, [SP, #40]
				
				B return
				
singleMove		PUSH {r0}	; Source Pole SP
				PUSH {r1}	; Destination Pole SP
				PUSH {r5}	; Returned Value (Any register is fine)
				
				BL move1	; move1(X, Y, a)
				
				POP {r5}	
				POP {r1}
				POP {r0}
				
				ADD r4, r5	; M = M + a;
				STR r0, [SP, #48]
				STR r1, [SP, #44]
			
				
return			STR r4, [SP, #36]	; Moved# takes place of ToMove#
				POP {r0-r7, PC}
				
				ENDP


; Dummy Exception Handlers (infinite loops which can be modified)

NMI_Handler     PROC
                EXPORT  NMI_Handler               [WEAK]
                B       .
                ENDP
HardFault_Handler\
                PROC
                EXPORT  HardFault_Handler         [WEAK]
                B       .
                ENDP
MemManage_Handler\
                PROC
                EXPORT  MemManage_Handler         [WEAK]
                B       .
                ENDP
BusFault_Handler\
                PROC
                EXPORT  BusFault_Handler          [WEAK]
                B       .
                ENDP
UsageFault_Handler\
                PROC
                EXPORT  UsageFault_Handler        [WEAK]
                B       .
                ENDP
SVC_Handler     PROC
                EXPORT  SVC_Handler               [WEAK]
                B       .
                ENDP
DebugMon_Handler\
                PROC
                EXPORT  DebugMon_Handler          [WEAK]
                B       .
                ENDP
PendSV_Handler  PROC
                EXPORT  PendSV_Handler            [WEAK]
                B       .
                ENDP
SysTick_Handler PROC
                EXPORT  SysTick_Handler           [WEAK]
                B       .
                ENDP

Default_Handler PROC

                EXPORT  WDT_IRQHandler            [WEAK]
                EXPORT  TIMER0_IRQHandler         [WEAK]
                EXPORT  TIMER1_IRQHandler         [WEAK]
                EXPORT  TIMER2_IRQHandler         [WEAK]
                EXPORT  TIMER3_IRQHandler         [WEAK]
                EXPORT  UART0_IRQHandler          [WEAK]
                EXPORT  UART1_IRQHandler          [WEAK]
                EXPORT  UART2_IRQHandler          [WEAK]
                EXPORT  UART3_IRQHandler          [WEAK]
                EXPORT  PWM1_IRQHandler           [WEAK]
                EXPORT  I2C0_IRQHandler           [WEAK]
                EXPORT  I2C1_IRQHandler           [WEAK]
                EXPORT  I2C2_IRQHandler           [WEAK]
                EXPORT  SPIFI_IRQHandler          [WEAK]
                EXPORT  SSP0_IRQHandler           [WEAK]
                EXPORT  SSP1_IRQHandler           [WEAK]
                EXPORT  PLL0_IRQHandler           [WEAK]
                EXPORT  RTC_IRQHandler            [WEAK]
                EXPORT  EINT0_IRQHandler          [WEAK]
                EXPORT  EINT1_IRQHandler          [WEAK]
                EXPORT  EINT2_IRQHandler          [WEAK]
                EXPORT  EINT3_IRQHandler          [WEAK]
                EXPORT  ADC_IRQHandler            [WEAK]
                EXPORT  BOD_IRQHandler            [WEAK]
                EXPORT  USB_IRQHandler            [WEAK]
                EXPORT  CAN_IRQHandler            [WEAK]
                EXPORT  DMA_IRQHandler            [WEAK]
                EXPORT  I2S_IRQHandler            [WEAK]
                EXPORT  ENET_IRQHandler           [WEAK]
                EXPORT  MCI_IRQHandler            [WEAK]
                EXPORT  MCPWM_IRQHandler          [WEAK]
                EXPORT  QEI_IRQHandler            [WEAK]
                EXPORT  PLL1_IRQHandler           [WEAK]
                EXPORT  USBActivity_IRQHandler    [WEAK]
                EXPORT  CANActivity_IRQHandler    [WEAK]
                EXPORT  UART4_IRQHandler          [WEAK]
                EXPORT  SSP2_IRQHandler           [WEAK]
                EXPORT  LCD_IRQHandler            [WEAK]
                EXPORT  GPIO_IRQHandler           [WEAK]
                EXPORT  PWM0_IRQHandler           [WEAK]
                EXPORT  EEPROM_IRQHandler         [WEAK]

WDT_IRQHandler
TIMER0_IRQHandler
TIMER1_IRQHandler
TIMER2_IRQHandler
TIMER3_IRQHandler
UART0_IRQHandler
UART1_IRQHandler
UART2_IRQHandler
UART3_IRQHandler
PWM1_IRQHandler
I2C0_IRQHandler
I2C1_IRQHandler
I2C2_IRQHandler
SPIFI_IRQHandler
SSP0_IRQHandler
SSP1_IRQHandler
PLL0_IRQHandler
RTC_IRQHandler
EINT0_IRQHandler
EINT1_IRQHandler
EINT2_IRQHandler
EINT3_IRQHandler
ADC_IRQHandler
BOD_IRQHandler
USB_IRQHandler
CAN_IRQHandler
DMA_IRQHandler
I2S_IRQHandler
ENET_IRQHandler
MCI_IRQHandler
MCPWM_IRQHandler
QEI_IRQHandler
PLL1_IRQHandler
USBActivity_IRQHandler
CANActivity_IRQHandler
UART4_IRQHandler
SSP2_IRQHandler
LCD_IRQHandler
GPIO_IRQHandler
PWM0_IRQHandler
EEPROM_IRQHandler

                B       .

                ENDP


                ALIGN


; User Initial Stack & Heap

                IF      :DEF:__MICROLIB

                EXPORT  __initial_sp
                EXPORT  __heap_base
                EXPORT  __heap_limit

                ELSE

                IMPORT  __use_two_region_memory
                EXPORT  __user_initial_stackheap
__user_initial_stackheap

                LDR     R0, =  Heap_Mem
                LDR     R1, =(Stack_Mem + Stack_Size)
                LDR     R2, = (Heap_Mem +  Heap_Size)
                LDR     R3, = Stack_Mem
                BX      LR

                ALIGN

                ENDIF


                END
