/* 
 * File:   main.c
 * Author: Jpavoo
 *
 * Created on May 12, 2015, 3:12 PM
 */

#define _XTAL_FREQ 4000000
#define WAND_REST 160       //in ms  
#define WAND_CHAR_DELAY 900  //in us
#include <xc.h>
#include <stdint.h>
#include <string.h>

#include "font.h"   // font definitions
// #pragma config statements should precede project file includes.
// Use project enums instead of #define for ON and OFF.

// CONFIG
#pragma config FOSC = INTOSCCLK // Oscillator Selection bits (INTOSC oscillator: CLKOUT function on RA6/OSC2/CLKOUT pin, I/O function on RA7/OSC1/CLKIN)
#pragma config WDTE = OFF        // Watchdog Timer Enable bit (WDT enabled)
#pragma config PWRTE = OFF      // Power-up Timer Enable bit (PWRT disabled)
#pragma config MCLRE = OFF      // RA5/MCLR/VPP Pin Function Select bit (RA5/MCLR/VPP pin function is digital input, MCLR internally tied to VDD)
#pragma config BOREN = OFF       // Brown-out Detect Enable bit (BOD enabled)
#pragma config LVP = OFF         // Low-Voltage Programming Enable bit (RB4/PGM pin has PGM function, low-voltage programming enabled)
#pragma config CPD = OFF        // Data EE Memory Code Protection bit (Data memory code protection off)
#pragma config CP = OFF         // Flash Program Memory Code Protection bit (Code protection off)

const uint8_t message[] = "AADI KIRAN";
const uint8_t display_length = 10; // length of message in characters

uint8_t buffer_length = 0; // length of used part of the display buffer 
uint8_t display_buffer[12*6]; // buffer for LED bit image
uint8_t ascii2font(uint8_t ascii);
uint8_t spread(uint8_t ascii);
void run();
void setUpBuffer();
/*
 * 
 */
int main(int argc, char** argv) {
  uint8_t sensor, last_sensor;
  TRISB = 0x0; //RB as Output
  CMCON = 0x07;
  TRISA1 = 1; //RA1 as Input
  setUpBuffer();
  sensor = RA1 & 1; // get sensor switch
  last_sensor = sensor;
  while(1)
  {
//      if(RA1==0){
//    PORTB = 0xFF;  // LED ON
//      } else {
//      //__delay_ms(1000); // 1 Second Delay
//      PORTB = 0x0;  // LED OFF
//      //__delay_ms(1000); // 1 Second Delay
//     }
    sensor = RA1 & 1; // read the direction switch
    if( (sensor != last_sensor) && sensor == 0 ){ // change sensor == 0 for other stroke
    __delay_ms(WAND_REST); // the delay after switch to allows wand to come up to speed again
    run();  // display one run of the buffer
    }
    last_sensor = sensor;
  }
  return 0;
}
/* **************** END of MAIN *******************/


// *** Other functions ***
void setUpBuffer(){
int j, currentChar=0;
  for(currentChar=0; currentChar<display_length; currentChar++) { // for each letter in message
 // enter text character
   for(j=0; j<6; j++) { // for each column
     display_buffer[buffer_length] = spread(matrixFont[ascii2font(message[currentChar])][j]);  // build up bit pattern
     buffer_length++; // move to next entry in the buffer
    }
 }
  display_buffer[buffer_length] = 0; // blank out last entry
}

uint8_t ascii2font(uint8_t ascii){ // convert ASCII into character font number
 ascii -= 0x20;
return ascii;
}
uint8_t spread(uint8_t b){
  b = ((b & 0x55) << 1) | ((b >> 1) & 0x55);
  b = ((b & 0x33) << 2) | ((b >> 2) & 0x33);
  b = ((b & 0x0F) << 4) | (b >> 4);
 
return b;
}

void run(){ // display the buffer
int i;
  for(i=0; i<buffer_length; i++){
     PORTB = display_buffer[i]; // display next column of LEDs
     __delay_us(WAND_CHAR_DELAY); // sets the width of each character 
     PORTB = 0x0; // blank out all LEDs
  } 
}