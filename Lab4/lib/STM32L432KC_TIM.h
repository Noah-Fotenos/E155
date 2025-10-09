// STM32L432KC_TIM.h
// noah Fotenos
// nfotenos@gmail.com
// Header for TIM functions
// 10/1/25

#ifndef STM32L4_TIM_H
#define STM32L4_TIM_H

#include <stdint.h>

///////////////////////////////////////////////////////////////////////////////
// Definitions
///////////////////////////////////////////////////////////////////////////////

#define __IO volatile

// Base addresses
#define TIM15_BASE (0x40014000UL) // base address of RCC


/**
  * @brief Reset and Clock Control
  */

typedef struct
{
  __IO uint32_t TIM15_CR1;        /*       Address offset: 0x00 */
  __IO uint32_t TIM15_CR2;        /*       Address offset: 0x04 */
  __IO uint32_t TIM15_SMCR;       /*       Address offset: 0x08 */
  __IO uint32_t TIM15_DIER;       /*       Address offset: 0x0C */
  __IO uint32_t TIM15_SR;         /*       Address offset: 0x10 */
  __IO uint32_t TIM15_EGR;        /*       Address offset: 0x14 */
  __IO uint32_t TIM15_CCMR1;      /*       Address offset: 0x18 */
       uint32_t RESERVED1;        /*!< Reserved, Address offset: 0x1C */
  __IO uint32_t TIM15_CCER;       /*       Address offset: 0x20 */
  __IO uint32_t TIM15_CNT;        /*       Address offset: 0x24 */
  __IO uint32_t TIM15_PSC;        /*       Address offset: 0x28 */
  __IO uint32_t TIM15_ARR;        /*       Address offset: 0x2C */
  __IO uint32_t TIM15_RCR;        /*       Address offset: 0x30 */
  __IO uint32_t TIM15_CCR1;       /*       Address offset: 0x34 */
  __IO uint32_t TIM15_CCR2;       /*       Address offset: 0x38 */
       uint32_t RESERVED2;        /*       Address offset: 0x3C */ 
       uint32_t RESERVED3;        /*       Address offset: 0x40 */ 
  __IO uint32_t TIM15_BDTR;       /*       Address offset: 0x44 */
  __IO uint32_t TIM15_DCR;        /*       Address offset: 0x48 */
  __IO uint32_t TIM15_DMAR;       /*       Address offset: 0x4C */
  __IO uint32_t TIM15_OR1;        /*       Address offset: 0x50 */
  uint32_t      RESERVED4;        /*!< Reserved, Address offset: 0x54 */
  uint32_t      RESERVED5;        /*!< Reserved, Address offset: 0x58 */
  uint32_t      RESERVED6;        /*!< Reserved, Address offset: 0x5C */
  __IO uint32_t TIM15_OR2;        /*       Address offset: 0x60 */
  
} TIM15_TypeDef;

#define TIM15 ((TIM15_TypeDef *) TIM15_BASE)

#define TIM16_BASE (0x40014400UL) // base address of RCC

typedef struct
{
  __IO uint32_t TIM16_CR1;        /*       Address offset: 0x00 */
  __IO uint32_t TIM16_CR2;        /*       Address offset: 0x04 */
       uint32_t RESERVED1;        /*!< Reserved, Address offset: 0x08 */
  __IO uint32_t TIM16_DIER;       /*       Address offset: 0x0C */
  __IO uint32_t TIM16_SR;         /*       Address offset: 0x10 */
  __IO uint32_t TIM16_EGR;        /*       Address offset: 0x14 */
  __IO uint32_t TIM16_CCMR1;      /*       Address offset: 0x18 */
       uint32_t RESERVED2;        /*       Address offset: 0x1C */
  __IO uint32_t TIM16_CCER;       /*       Address offset: 0x20 */
  __IO uint32_t TIM16_CNT;        /*       Address offset: 0x24 */
  __IO uint32_t TIM16_PSC;        /*       Address offset: 0x28 */
  __IO uint32_t TIM16_ARR;        /*       Address offset: 0x2C */
  __IO uint32_t TIM16_RCR;        /*       Address offset: 0x30 */
  __IO uint32_t TIM16_CCR1;       /*       Address offset: 0x34 */
  __IO uint32_t TIM16_CCR2;       /*       Address offset: 0x38 */
       uint32_t RESERVED3;        /*!< Reserved, Address offset: 0x3C */ 
       uint32_t RESERVED4;        /*!< Reserved, Address offset: 0x40 */ 
  __IO uint32_t TIM16_BDTR;       /*       Address offset: 0x44 */
  __IO uint32_t TIM16_DCR;        /*       Address offset: 0x48 */
  __IO uint32_t TIM16_DMAR;       /*       Address offset: 0x4C */
  __IO uint32_t TIM16_OR1;        /*       Address offset: 0x50 */
  uint32_t      RESERVED5;        /*!< Reserved, Address offset: 0x54 */
  uint32_t      RESERVED6;        /*!< Reserved, Address offset: 0x58 */
  uint32_t      RESERVED7;        /*!< Reserved, Address offset: 0x5C */
  __IO uint32_t TIM16_OR2;        /*       Address offset: 0x60 */
  
} TIM16_TypeDef; 

#define TIM16 ((TIM16_TypeDef *) TIM16_BASE)


///////////////////////////////////////////////////////////////////////////////
// Function prototypes
///////////////////////////////////////////////////////////////////////////////

void wait(int);
void PWM(int);
void en15_16_APB(void);
#endif