/*********************************************************************************************************
**--------------File Info---------------------------------------------------------------------------------
** File name:           lib_led.c
** Last modified Date:  2019-12-05
** Last Version:        V1.00
** Descriptions:        Atomic led init functions
** Correlated files:    
**--------------------------------------------------------------------------------------------------------       
*********************************************************************************************************/
#define LED_NUM     8                   /* Number of user LEDs                */
#include "LPC17xx.h"
#include "led.h"

int a = 0;

/*----------------------------------------------------------------------------
  Function that initializes LEDs
 *----------------------------------------------------------------------------*/

void LED_init(void)
{
	LPC_PINCON->PINSEL4 &= 0xFFFF0000;	// PIN mode GPIO: P2.0-P2.7 are set to zero
	LPC_GPIO2->FIODIR |= 0x000000FF;		// P2.0-P2.7 on PORT2 defined as Output
}

void LED_deinit(void)
{
  LPC_GPIO2->FIODIR &= 0xFFFFFF00;
}

/*----------------------------------------------------------------------------
  Function that turn off all led
 *----------------------------------------------------------------------------*/

void all_LED_off(void)
{
	LPC_GPIO2->FIOCLR = 0x000000FF;
}

/*----------------------------------------------------------------------------
  Functions that light up four LEDs at a time
 *----------------------------------------------------------------------------*/

void first_four_LED_On(void)
{
	switch (a) {
		case 0:
			LPC_GPIO2->FIOSET = 0x00000010;
			a++;
			break;
		case 1:
			LPC_GPIO2->FIOSET = 0x00000030;
			a++;
			break;
		case 2:
			LPC_GPIO2->FIOSET = 0x00000070;
			a++;
			break;
		case 3:
			LPC_GPIO2->FIOSET = 240;
			a=0;
			break;
	}
  
}

void last_four_LED_On(void)
{
	LPC_GPIO2->FIOSET = 0x000000F;
}
