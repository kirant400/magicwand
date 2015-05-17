/* 
 * File:   magicwandmain.c
 * Author: kirant400
 *
 * Created on 03 May 2015, 22:53
 */

#define WAND_REST 160       //in ms
#define WAND_CHAR_DELAY 900  //in us
#define _XTAL_FREQ 8000000

#include <stdio.h>
#include <stdlib.h>
#include <xc.h>
#include <stdint.h>
#include <string.h>

#include "font.h"   // font definitions

// CONFIG
#pragma config FOSC = HS        // Oscillator Selection bits (XT oscillator)
#pragma config WDTE = OFF        // Watchdog Timer Enable bit (WDT enabled)
#pragma config PWRTE = OFF      // Power-up Timer Enable bit (PWRT disabled)
#pragma config CP = OFF         // FLASH Program Memory Code Protection bit (Code protection off)
#pragma config BOREN = OFF      // Brown-out Reset Enable bit (BOR disabled)

const uint8_t message[] = "KIRAN";

uint8_t display_length = 0; // length of message in characters
uint8_t buffer_length = 0; // length of used part of the display buffer
uint8_t display_buffer[5*6]; // buffer for LED bit image
uint8_t ascii2font(uint8_t ascii);
uint8_t spread(uint8_t ascii);
void run();
void setUpBuffer();

/*
 * 
 */
int main(int argc, char** argv) {
  uint8_t sensor, last_sensor;
  ADCON1 =0x06;
  TRISA = 0xFF;
  //PORTB = 0xFF; //Makes all pins of PORTB Logic High
  TRISC = 0x00; //Makes all pins of TRISC Output
  setUpBuffer();
  sensor = RA0 & 1; // get sensor switch
  last_sensor = sensor;
  while(1)
  {
  sensor = RA0 & 1; // read the direction switch
    if( (sensor != last_sensor) && sensor == 0 ){ // change sensor == 0 for other stroke
    __delay_ms(WAND_REST); // the delay after switch to allows wand to come up to speed again
    run();  // display one run of the buffer
    }
    last_sensor = sensor;
  }
    return (EXIT_SUCCESS);
}
/* **************** END of MAIN *******************/


// *** Other functions ***
void setUpBuffer(){
int j, currentChar=0;
display_length = sizeof(message)-1;
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
