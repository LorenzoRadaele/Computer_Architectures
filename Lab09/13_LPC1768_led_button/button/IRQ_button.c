#include "button.h"
#include "LPC17xx.h"
#include "../led/led.h"

void EINT0_IRQHandler (void)	  
{
	all_LED_off();
	LED_On(7);
  LPC_SC->EXTINT |= (1 << 0);     /* clear pending interrupt         */
}

void EINT1_IRQHandler (void)	  
{
	
	shift_left();
	//first_four_LED_On();
	LPC_SC->EXTINT |= (1 << 1);     /* clear pending interrupt         */
}

void EINT2_IRQHandler (void)	  
{
	shift_right();
	//last_four_LED_On();
  LPC_SC->EXTINT |= (1 << 2);     /* clear pending interrupt         */    
}
