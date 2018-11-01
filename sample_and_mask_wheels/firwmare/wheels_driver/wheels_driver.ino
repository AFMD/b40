// written by grey@christoforo.net

// pin definitions
// for sample wheel
const byte SW_nSLEEP = 2;
const byte SW_STEP = 0;
const byte SW_DIR = 6;

// for mask wheel
const byte MW_nSLEEP = 3;
const byte MW_STEP = 1;
const byte MW_DIR = 7;

// for inputs
// mask wheel control pins connected to the slider switch
const byte MW_SLIDE_1 = A1;
const byte MW_SLIDE_2 = A2;
const byte MW_SLIDE_3 = 8;
const byte MW_SLIDE_4 = 9;

// sample wheel control pins connected to the rotary switch
const byte SW_ROT_1 = 4;
const byte SW_ROT_2 = 5;

void setup() {
  // initialize the motor pins
  pinMode(LED_BUILTIN, OUTPUT);
  
  digitalWrite(SW_nSLEEP, LOW);
  digitalWrite(SW_STEP, LOW);
  digitalWrite(SW_DIR, LOW);

  digitalWrite(MW_nSLEEP, LOW);
  digitalWrite(MW_STEP, LOW);
  digitalWrite(MW_DIR, LOW);

  //digitalWrite(SW_nSLEEP, HIGH); //HIGH enables the motor
  //digitalWrite(MW_nSLEEP, HIGH); //HIGH enables the motor
  
  pinMode(SW_nSLEEP, OUTPUT);
  pinMode(SW_STEP, OUTPUT);
  pinMode(SW_DIR, OUTPUT);

  pinMode(MW_nSLEEP, OUTPUT);
  pinMode(MW_STEP, OUTPUT);
  pinMode(MW_DIR, OUTPUT);

  // setup input pins
  pinMode(MW_SLIDE_1, INPUT_PULLUP);
  pinMode(MW_SLIDE_2, INPUT_PULLUP);
  pinMode(MW_SLIDE_3, INPUT_PULLUP);
  pinMode(MW_SLIDE_4, INPUT_PULLUP);
  pinMode(SW_ROT_1, INPUT_PULLUP);
  pinMode(SW_ROT_2, INPUT_PULLUP);

  //setup interrupts
  attachInterrupt(digitalPinToInterrupt(MW_SLIDE_1), ISR_slide_change, CHANGE);
  attachInterrupt(digitalPinToInterrupt(MW_SLIDE_2), ISR_slide_change, CHANGE);
  attachInterrupt(digitalPinToInterrupt(MW_SLIDE_3), ISR_slide_change, CHANGE);
  attachInterrupt(digitalPinToInterrupt(MW_SLIDE_4), ISR_slide_change, CHANGE);

  attachInterrupt(digitalPinToInterrupt(SW_ROT_1), ISR_rot_change, CHANGE);
  attachInterrupt(digitalPinToInterrupt(SW_ROT_2), ISR_rot_change, CHANGE);
}

// some global variables/constants
volatile bool do_steps=false;
const int STEP_DELAY_US = 5000; //micro second step delay
const unsigned long DEBOUNCE_MS = 200; // switch debounce time in ms

// ISR flags
volatile bool ISR_FLAG_rot_change = false; // flag for sample wheel rotary switch value change
volatile bool ISR_FLAG_slide_change = false; // flag for mask wheel slide switch value change

void loop() {
  
  if (do_steps){
    digitalWrite(SW_STEP, HIGH);
    digitalWrite(MW_STEP, HIGH);
    digitalWrite(LED_BUILTIN, HIGH);   // turn the LED on (HIGH is the voltage level)
    delayMicroseconds(STEP_DELAY_US);                       // wait
    digitalWrite(SW_STEP, LOW);
    digitalWrite(MW_STEP, LOW);
    digitalWrite(LED_BUILTIN, LOW);    // turn the LED off by making the voltage LOW
    delayMicroseconds(STEP_DELAY_US);                       // wait
  }
}

void handle_rot_change(){

  ISR_FLAG_rot_change = false;
}

void handle_slide_change(){

  ISR_FLAG_slide_change = false;
}


//ISR routines
void ISR_rot_change() {
  ISR_FLAG_rot_change = true;
}

void ISR_slide_change() {
  ISR_FLAG_slide_change = true;
}

/*
 * 
 * 
 * 
 * 
 *    static unsigned long last_interrupt_time = 0;
   unsigned long interrupt_time = millis();
   // If interrupts come faster than DEBOUNCE_MS, assume it's a bounce and ignore
   if (interrupt_time - last_interrupt_time > DEBOUNCE_MS){
    do_steps = !do_steps;
   }
   last_interrupt_time = interrupt_time;
   */
