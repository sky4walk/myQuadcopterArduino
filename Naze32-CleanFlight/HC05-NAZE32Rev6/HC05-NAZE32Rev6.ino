// im Terminalprogramm Sowohl CR als auch LN einstellen
#include <SoftwareSerial.h>


//#define BAUD_HC05 

/*
 * AT commands HC06 linvorV1.8
 * AT+VERSION
 * AT+NAMEnaze32
 * AT+PIN0000
 * AT+BAUD8 -> 115200 
 */
#ifdef BAUD_HC05
  #define BAUD_BT 38400
#else
  #define BAUD_BT 9600
#endif

// (RX,TX)
SoftwareSerial bluetooth(10, 11); 

void setup()
{
  // set key pin HC-05 to HIGH to switch into AT mode
  pinMode(9, OUTPUT);  
  digitalWrite(9, HIGH);
  Serial.begin(9600);
  Serial.println("AT CMD:");
  bluetooth.begin(BAUD_BT);  
}

void loop() {
  if (bluetooth.available())
    Serial.write(bluetooth.read());
  if (Serial.available())
    bluetooth.write(Serial.read());
}
