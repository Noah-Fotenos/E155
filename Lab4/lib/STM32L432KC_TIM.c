// STM32L432KC_TIM15.c
// noah Fotenos
// nfotenos@gmail.com
// Source code for TIM15 functions
// 10/1/25


#include "STM32L432KC_TIM.h"
#include "STM32L432KC_RCC.h"
#include "STM32L432KC_GPIO.h"

void en15_16_APB() {
    //enable clock for TIM15 and TIM16
    RCC->APB2ENR |= (1 << 16); //TIM15
    RCC->APB2ENR |= (1 << 17); //TIM16   
    TIM16->TIM16_CR1 |= 1; // en TIM16 counter
    RCC->AHB2ENR |= 1<<0; //enable GPIOA clock
    pinMode(6, GPIO_ALT); //set PA6 as output 
    GPIO->AFRL |= (0b1110U << 24); //set PA6 to AF14 (TIM16_CH1)
    TIM16->TIM16_CCER |= (1<<0);
    TIM16->TIM16_BDTR |= (1<<15);
    TIM16->TIM16_CCER |= (1<<3);
}


void wait(int millisec) {
    // Configure TIM15
    TIM15->TIM15_PSC = 799; // Prescaler value (80 MHz / (799 + 1) = 1000 Hz)
    TIM15->TIM15_ARR = millisec * 100; // Auto-reload value for desired milliseconds
    TIM15->TIM15_EGR |= (1 << 0); // Generate an update event to load the prescaler value
    TIM15->TIM15_SR &= ~(1 << 0); // Clear the update interrupt flag
    TIM15->TIM15_CR1 |= (1 << 0); // Enable the timer

    // Wait until the update event occurs
    while ((TIM15->TIM15_SR & (1 << 0)) == 0);

    TIM15->TIM15_CR1 &= ~(1 << 0); // Disable the time
    TIM15->TIM15_EGR &= ~(1 << 0); // put back to 0 to allow reset at start
}

void PWM(int freq){
    //set PWM frequency
    TIM16->TIM16_CCMR1 &= ~((0b11) << 0) ; //set to output mode 
    TIM16->TIM16_CCMR1 &= (1 << 3) ; //enable preload for CCR1

    if (freq == 0) {
        TIM16->TIM16_CCMR1 |= (0b000 << 4); //set to Frozen
    } else {
        TIM16->TIM16_CCMR1 |= (0b110 << 4); //set to PWM mode 1
    }

    uint32_t temp_arr = 80000000 / freq; //calculate ARR value
    uint32_t temp_PSC = 1; //initialize prescaler value divide by 2 to start for full cycle
    while (temp_arr > 65535) { //while ARR value is too large
        temp_PSC *= 2; //increase predev prescaler value
        temp_arr /= 2; //decrease ARR value
    }
    TIM16->TIM16_PSC = (temp_PSC -  1); //set prescaler value realign since its defined at 1. 
    TIM16->TIM16_ARR = temp_arr; //set ARR value
    TIM16->TIM16_EGR &= ~(1 << 0); // Generate an update event to load the prescaler value
    TIM16->TIM16_EGR |= (1 << 0); // Generate an update event to load the prescaler value
    TIM16->TIM16_SR &= ~(1 << 0); // Clear the update interrupt
    TIM16->TIM16_CCR1 = (temp_arr / 2); //set duty cycle to 50%

}