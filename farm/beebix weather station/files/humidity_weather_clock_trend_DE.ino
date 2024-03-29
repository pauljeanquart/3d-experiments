//*********************************************/
//***         Weather Station v1.1          ***/
//* Code based on RobWLakes                   */
//* https://www.thingiverse.com/thing:2849562 */
//*********************************************/
//* Updated & Changed by Beebix               */
//* - Humidity & Temperature                  */
//* - RTC (Realtime Clock)                    */
//* - Trend Pfeile                            */
//         *** Arduino IDE v1.8.5 ***         */
//*********************************************/
#include <Wire.h>
#include <Adafruit_BMP085.h>  // Drucksensor
#include <LiquidCrystal_PCF8574.h> // Display 20x4 I2C
#include "DHT.h" // Feuchte Sensor + Temp DHT11  (Neu im Code)
#include <DS3231.h> // RTC Real Time Clock  (Neu im Code)

// ***          DHT11/22 -Pin = D12
// ***             DS3231-SDA = A4
// ***                   -SCL = A5
// ***             BMP085-SDA = A4
// ***                   -SCL = A5
// ***            PCF8574-SDA = A4
// ***                   -SCL = A5

//RTC & Humidity Added
DS3231 rtc(SDA, SCL); // Abfrage der Ports Arduino UNO (A4 & A5) ist technisch festgelegt  (Neu im Code)

#define DHTTYPE DHT11   // Feuchte Sensor + Temp DHT11/22  (Neu im Code)

LiquidCrystal_PCF8574 lcd(0x3f);  // set the LCD address to 0x3f for a 20 chars and 4 line display
//LiquidCrystal_PCF8574 lcd(0x27);  // set the LCD address to 0x27 for a 16 chars and 2 line display

//Wind Direction
int show = 0;
int error = 0;
int ledPin = 13;
int DHTPIN = 12; // (Neu im Code)
byte direct = 1;//begin with North
char* compass[] = {"N  ", "NNO", "NO ", "NOO", "O  ", "SOO", "SO ", "SSO", "S  ", "SSW", "SW ", "SWW", "W  ", "NWW", "NW ", "NNW","???"};
byte pointer = 0;

//Wind Speed
float radius = 0.065; //metres from center pin to middle of cup
int seconds = 0;
int revolutions = 0; //counted by interrupt
int rps = 0; // read revs per second (5 second interval)
int mps = 0;  //wind speed metre/sec

//Humidity  (Neu im Code)
DHT dht(DHTPIN, DHTTYPE); // Abfrage DHT11   (Neu im Code)

//Rainfall
double rainfall = 0;

//Barometer and Thermometer
double  temperature   = 0.0;
double  barometer = 0.0;
Adafruit_BMP085 bmp;

void setup() {
  //The angle of wind direction is given here for each pin on its own
  //if two opins are activated, ie magnet halfway between, the direction
  //is interpolated so that 16 angles are reported, not just the 8 shown.
  //you may need to experiment with the magnet to get this accurate and
  //reliable.  The alignment of the reed switches should not be critical.
  pinMode( 4, INPUT_PULLUP); //angle ==   0 degrees  N
  pinMode( 5, INPUT_PULLUP); //angle ==  45 degrees  NO
  pinMode( 6, INPUT_PULLUP); //angle ==  90 degrees  O
  pinMode( 7, INPUT_PULLUP); //angle == 135 degrees  SO
  pinMode( 8, INPUT_PULLUP); //angle == 180 degrees  S
  pinMode( 9, INPUT_PULLUP); //angle == 225 degrees  SW
  pinMode(10, INPUT_PULLUP); //angle == 270 degrees  W
  pinMode(11, INPUT_PULLUP); //angle == 315 degrees  NW
  pinMode(ledPin, OUTPUT); // Port 13
  pinMode(DHTPIN, INPUT_PULLUP); // Port 12 auf Input  (Neu im Code) 

//* Generate Grafical Symbol *
//byte Celsius[8] = {B01110,B10001,B01110,B00000,B00000,B00000,B00000,B00000}; lcd.createChar(0, Celsius); // graphical ° Symbol
byte ArrowU[8] = {B00000,B00100,B01110,B11111,B00100,B00100,B00100,B00000}; lcd.createChar(1, ArrowU); // graphical Up Symbol
byte ArrowD[8] = {B00000,B00100,B00100,B00100,B11111,B01110,B00100,B00000}; lcd.createChar(2, ArrowD); // graphical Down Symbol
//* Grafical Symbol end */
  
 rtc.begin();

  Serial.begin(115200);
  Serial.println("LCD...");
  while (! Serial);
  Serial.println("Begin: check for LCD");

  // See http://playground.arduino.cc/Main/I2cScanner
  Wire.begin();
  Wire.beginTransmission(0x3f);
  error = Wire.endTransmission();
  if (error) {
    Serial.print("Error: ");
    Serial.print(error);
    Serial.println(": LCD not found.");
  } // if
  lcd;
  lcd.begin(20, 4); // initialize the lcd
  show = 0;
  //pinMode(12, OUTPUT); //controls LCD Back Light - Port wird für Feuchte Sensor benötigt!!!
  //digitalWrite(12, HIGH); // Port wird für Feuchte Sensor benötigt!!!  ( NEW )
  lcd.setBacklight(255);//also controls LCD Back Light
  
  //Anemometer
  pinMode(2, INPUT_PULLUP);
  attachInterrupt(0, rps_fan, FALLING);
 
  //Rainfall
  pinMode(3, INPUT_PULLUP);
  attachInterrupt(1, tipbuckets, FALLING);
 
  //Barometer
  bmp.begin();    //start the barometer and temp packages

  // Initialize Timer1 for a 1 second interrupt
  // Thanks to http://www.engblaze.com/ for this section, see their Interrupt Tutorial
  cli();          // disable global interrupts
  TCCR1A = 0;     // set entire TCCR1A register to 0
  TCCR1B = 0;     // same for TCCR1B
  // set compare match register to desired timer count:
  OCR1A = 15624;
  // turn on CTC mode:
  TCCR1B |= (1 << WGM12);
  // Set CS10 and CS12 bits for 1024 prescaler:
  TCCR1B |= (1 << CS10);
  TCCR1B |= (1 << CS12);
  // enable timer compare interrupt:
  TIMSK1 |= (1 << OCIE1A);
  // enable global interrupts:
  sei();
} // setup()

//Routine Driven by Interrupt, trap 1 second interrupts, and output every 5 seconds
ISR(TIMER1_COMPA_vect) {
  seconds++;
  if (seconds == 5) { //make 5 for each output
    seconds = 0;
    rps = revolutions;
    revolutions = 0;
  }
}

// executed every time the interrupt 0 (pin2) gets low, ie one rev of cups.
void rps_fan() {
  revolutions++;
}//end of interrupt routine

// executed every time the interrupt 1 (pin3) gets low, ie one tip of buckets.
void tipbuckets() {
  rainfall++;
 //this has not been calibrated as it will depend on your own printing dimensions
 //as a rough guide though, this system has 50 tips per 100ml, over a radius of 4.25cm
 //one tip is approx 2ml, or 2cmCubed. Area of catchment= pi*4.25*4.25=56.7 cm Squared
 //Rainfal per tip is 2/56.7=25th of a ml
}//end of interrupt routine

void loop() {
  //lcd.setBacklight(255);

  lcd.home(); 
  lcd.clear();
//lcd.print("--------------------"); // Muster Text 
  lcd.setCursor(0, 0);
  lcd.print(" Wetterstation v1.1 "); //  - komentiert ist deaktiviert  (Neu im Code)
  lcd.setCursor(0, 1);
  lcd.print("  Hum & Temp Innen  "); //  (Neu im Code)
  lcd.setCursor(0, 2);
  lcd.print("  kPa & Temp Aussen "); //  (Neu im Code)
  lcd.setCursor(0, 3);
  lcd.print("RTC - DHT11 - BMP085"); //  (Neu im Code)
  delay(5000); //   (Neu im Code)
  lcd.clear();  //   (Neu im Code)

  
  while (true) {
    int pointer = -1;
    direct = (((PINB & B00001111) << 4) | ((PIND & B11110000) >> 4)) ^ B11111111;
    //chuck out any non readings where the magnet doesn't work
    switch (direct) {
      case 1:
        pointer = 0;
        break;
      case 3:
        pointer = 1;
        break;
      case 2:
        pointer = 2;
        break;
      case 6:
        pointer = 3;
        break;
      case 4:
        pointer = 4;
        break;
      case 12:
        pointer = 5;
        break;
      case 8:
        pointer = 6;
        break;
      case 24:
        pointer = 7;
        break;
      case 16:
        pointer = 8;
        break;
      case 48:
        pointer = 9;
        break;
      case 32:
        pointer = 10;
        break;
      case 96:
        pointer = 11;
        break;
      case 64:
        pointer = 12;
        break;
      case 192:
        pointer = 13;
        break;
      case 128:
        pointer = 14;
        break;
      case 129:
        pointer = 15;
        break;
      default:
        pointer = 16;
        // if nothing else matches, do the default
        // default 16, "???" mainly for debugging
        break;
    }
    //Serial.print(direct);
    //Serial.print("\t -> ");
    //Serial.print(pointer);
    //Serial.print("\t -> ");
    hexBinDump(direct); //working beautifully

// Humidity DHT11  auslesen (Neu im Code)

  float h = dht.readHumidity(); //
  // Themperatur lesen in Celsius
  float th = dht.readTemperature();

  // Read temperature as Fahrenheit (isFahrenheit = true)
  //float f = dht.readTemperature(true);

  lcd.setCursor(0, 0);
  lcd.print("F:");
  if (h < 100) {
        lcd.print(" ");
  }
  lcd.print(h);
  lcd.print("%");

//* lcd print Up/Down Symbol   -  Enable Void setup char 1 & 2 **************************   (Neu im Code)
       float Hum; 
                            
     if (Hum > h) 
        {
        lcd.setCursor(9, 0);
        lcd.write((uint8_t)2); // Down SymbolUp Symbol
        }
     if (Hum < h) 
        {
        lcd.setCursor(9, 0);
        lcd.write((uint8_t)1);  // Up Symbol
        }
           
     //lcd.print(" "); 
      if (h < 10) {
        lcd.print(" ");}
        
 Serial.print("Hum A: ");Serial.print(h); Serial.println("");        
 Serial.print("Hum B: ");Serial.print(Hum); Serial.println("");
 Hum = h;
//* lcd print Up/Down Symbol End ********************************************************/
  lcd.setCursor(10, 0);
  lcd.print("T:");
  if (temperature < 10) {
        lcd.print(" "); 
  }     
//* lcd print Up/Down Symbol   -  Enable Void setup char 1 & 2 **************************
       float TempF; 
    
     if (TempF >= th) 
        {
        lcd.setCursor(12, 0);
        lcd.write((uint8_t)2); // Down SymbolUp Symbol
        }                
     if (TempF <= th) 
        {
        lcd.setCursor(12, 0);
        lcd.write((uint8_t)1);  // Up Symbol
        }          

     lcd.print(" "); 
      if (th < 10) {
        lcd.print(" ");}
        
 Serial.print("Temp : ");Serial.print(th); Serial.println("");        
 Serial.print("TempF: ");Serial.print(TempF); Serial.println("");
 TempF = th;
//* lcd print Up/Down Symbol End ********************************************************/

  if (th < 10) {
        lcd.print(" ");
  }
  lcd.print(th,1);

  
  //* uncomment your choise *
  //lcd.print((char)223); // Celsius Symbol   (Neu im Code)
  lcd.print("\337");lcd.print("C"); // ("\337")  Grafik ° Symbol
  // lcd.write((uint8_t)0);lcd.print("C"); // graphical ° Symbol - Uncomment on void setup -> [byte Celsius[8] = {B01110...]
  //lcd.print(f);

// Humidity DHT11  auslesen ende
  
  //Wind
    lcd.setCursor(0, 1);
    lcd.print("W:  ");
    
    if (rps != -1) { //Update every 5 seconds, this will be equal to reading frequency (Hz)x5.
      //float kmph = rps * 3.1415 * 2 * radius * 12 * 60 / 1000; // 1 Hallsensor/Reedkontakt  m/m
      float kmph = rps / 2 * radius * 3.1415 * 12 * 30 / 1000; // 2 Hallsensoren  m/s
      //float kmph = rps * radius * 3.1415 * 12 / 1000; // 2 Hallsensoren  m/s
    
      if (direct != 0) {
        //lcd.setCursor(2, 1);
        lcd.print(compass[pointer]);
      }
      
      lcd.setCursor(10, 1);
      lcd.print("@:");
    {
      if (kmph < 100) 
        lcd.print(" ");
      if (kmph < 10) 
        lcd.print(" ");
        
      }
      
      
      lcd.print(kmph, 1); //kilometres per hour to one decimal place
      lcd.print("m/s");
    }
//*************** Barometer and Temperature ***************
    temperature = (double)bmp.readTemperature();   //internal temperature
    barometer = (double)bmp.readPressure() / 100.0; //Pa reduced to mBar
    lcd.setCursor(0, 2);
    lcd.print("D:");
      if (barometer < 1000) {
        lcd.print(" ");
      }
    
    lcd.print(barometer,0);
    lcd.print("kPa");

   //* lcd print Up/Down Symbol   -  Enable Void setup char 1 & 2 **************************
       float pres; 
                
     if (pres >= barometer) 
        {
        lcd.setCursor(9, 2);
        lcd.write((uint8_t)2); // Down SymbolUp Symbol
        }
     if (pres <= barometer) 
        {
        lcd.setCursor(9, 2);
        lcd.write((uint8_t)1);  // Up Symbol
        }                   
  
     lcd.print(" "); 
      if (barometer < 10) {
        lcd.print(" ");}
        
 Serial.print("Press: ");Serial.print(barometer); Serial.println("");        
 Serial.print("Press: ");Serial.print(pres); Serial.println("");
 pres = barometer;
//* lcd print Up/Down Symbol End ********************************************************/

     
    lcd.setCursor(10, 2);
    lcd.print("T:");

//* lcd print Up/Down Symbol   -  Enable Void setup char 1 & 2 **************************
       float TempP; 
                
     if (TempP >= temperature) 
        {
        lcd.setCursor(12, 2);
        lcd.write((uint8_t)2); // Down SymbolUp Symbol
        }
     if (TempP <= temperature) 
        {
        lcd.setCursor(12, 2);
        lcd.write((uint8_t)1);  // Up Symbol
        }           

     //lcd.print(" "); 
     if (temperature < 10) {
       lcd.print(" ");}
        
 Serial.print("Temp : ");Serial.print(temperature);Serial.println("");        
 Serial.print("TempP: ");Serial.print(TempP); Serial.println("");
 TempP = temperature;
//* lcd print Up/Down Symbol End ********************************************************/ 
  
   // lcd.print(" "); 
      if (temperature < 10) {
        lcd.print(" ");
      }
    
    lcd.print(temperature,1);

    
//***************************************************/
 
 //* uncomment your choise *   
  // lcd.print((char)223); // Celsius Symbol   (Neu im Code)
  lcd.print("\337");lcd.print("C"); // ("\337") = graphical ° Symbol
  // lcd.write((uint8_t)0);lcd.print("C"); // graphical ° Symbol - Uncomment on void setup -> [byte Celsius[8] = {B01110...]
  
lcd.setCursor(0,3);
lcd.print("R:");
        
  if (rainfall < 10) {
        lcd.print(" ");
      }
      lcd.print(rainfall,1);
      lcd.print("mm");

// RTC & Datum auslesen    (Neu im Code)  
lcd.setCursor(10,3);
 lcd.print("          ");
 lcd.setCursor(11,3);
 lcd.print(rtc.getTimeStr());
 
delay(1500);
 
 lcd.setCursor(10,3);
 lcd.print("          ");
 lcd.setCursor(10,3);
 lcd.print(rtc.getDateStr());
// RTC & Datum auslesen ende   (Neu im Code)   


  delay(1500);
  }
  
} // loop()

//Useful to invoke to debug the byte Array
void hexBinDump(int myNos) {
  //Serial.println("T A3 10100011 07 00000111 02 00000010 AA 10101010 F0 11110000 06 00000110 FF 11111111 07 00000111 33 00110011 60 01100000");
  byte mask = B10000000;
  if ((myNos & B11110000) == 0) { //alter if you need to change how many bytes you are checking
    Serial.print("0");
  }
  Serial.print(myNos, HEX);
  Serial.print(" ");
  for (int k = 0; k < 8; k++) {
    if (myNos & mask) {
      Serial.print("1");
    }
    else {
      Serial.print("0");
    }
    mask = mask >> 1;
  }
  Serial.println();
}
