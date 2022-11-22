#define LED_NUM     8                   /* Number of user LEDs                */
#include "LPC17xx.h"

void LED_On(unsigned int num) {
	int a = 7 - num;
	int n = 1<<a;
	/*for (int i = 0; i < a; i++) {
		n *= 2;
	}
	*/
	LPC_GPIO2->FIOSET = n;
}

void LED_Off(unsigned int num) {
	int a = 7 - num;
	int n = 1<<a;
	LPC_GPIO2->FIOCLR |= n;
}

void shift_left() {
	unsigned int led_value = LPC_GPIO2->FIOPIN;
	LPC_GPIO2->FIOCLR |= led_value;
	led_value &= 0x000000FF;
	if (led_value == 0x80)
		led_value = 1;
	else 
		led_value = led_value<<1;
	
	LPC_GPIO2->FIOSET = led_value;
}

void shift_right() {
	unsigned int led_value = LPC_GPIO2->FIOPIN;
	LPC_GPIO2->FIOCLR |= led_value;
	led_value &= 0x000000FF;
	if (led_value == 0x01)
		led_value = 0x80;
	else 
		led_value = led_value>>1;
	
	LPC_GPIO2->FIOSET = led_value;
}


void begin_show() {
	for (int j = 0; j < 8; j++)  {
		//all_LED_off();
		if (j > 0) LED_Off(j-1);
		LED_On(j);
		for (int i = 0; i < 8000000; i++);
	}
	for (int j = 7; j >= 0; j--)  {
		//all_LED_off();
		if (j < 7) LED_Off(j+1);
		LED_On(j);
		for (int i = 0; i < 600000; i++);
	}
	for (int j = 0; j < 8; j++)  {
		//all_LED_off();
		if (j > 0) LED_Off(j-1);
		LED_On(j);
		for (int i = 0; i < 600000; i++);
	}
	for (int j = 7; j >= 0; j--)  {
		//all_LED_off();
		if (j < 7) LED_Off(j+1);
		LED_On(j);
		for (int i = 0; i < 600000; i++);
	}
}
