// written by grey@christoforo.net

// pin definitions
// for sample wheel
const int SW_nSLEEP=2;
const int SW_STEP=0;
const int SW_DIR=6;

// for mask wheel
const int MW_nSLEEP=3;
const int MW_STEP=1;
const int MW_DIR=7;

const int DELAY=100;

void setup() {
  // initialize the pins
  pinMode(LED_BUILTIN, OUTPUT);
  
  digitalWrite(SW_nSLEEP, HIGH);
  digitalWrite(SW_STEP, LOW);
  digitalWrite(SW_DIR, LOW);

  digitalWrite(MW_nSLEEP, HIGH);
  digitalWrite(MW_STEP, LOW);
  digitalWrite(MW_DIR, LOW);

  digitalWrite(SW_nSLEEP, LOW);
  digitalWrite(MW_nSLEEP, LOW);
  
  pinMode(SW_nSLEEP, OUTPUT);
  pinMode(SW_STEP, OUTPUT);
  pinMode(SW_DIR, OUTPUT);

  pinMode(MW_nSLEEP, OUTPUT);
  pinMode(MW_STEP, OUTPUT);
  pinMode(MW_DIR, OUTPUT);
}

void loop() {

  digitalWrite(SW_STEP, HIGH);
  digitalWrite(MW_STEP, HIGH);
  digitalWrite(LED_BUILTIN, HIGH);   // turn the LED on (HIGH is the voltage level)
  delayMicroseconds(DELAY);                       // wait for a second
  digitalWrite(SW_STEP, LOW);
  digitalWrite(MW_STEP, LOW);
  digitalWrite(LED_BUILTIN, LOW);    // turn the LED off by making the voltage LOW
  delayMicroseconds(DELAY);                       // wait for a second
}
