// written by grey@christoforo.net
#include <Automaton.h>

#define USE_SERIAL_COMMS

Atm_button button1;
Atm_button button2;

Atm_button button3;
Atm_button button4;
Atm_button button5;
Atm_button button6;

Atm_timer timer;
Atm_timer timer1;

Atm_led led1;
Atm_led led2;

// wait this many ms before handling an input change
const unsigned long int INPUT_DELAY = 5000;

// keeps track of if we should ignore input events
volatile bool ignore_events = true;

// places to store wheel positions
volatile int current_sample_wheel_position = -1;
volatile int current_mask_wheel_position = -1;

// is true when them motors are asleep
volatile bool motors_asleep = false;

void enable_inputs( int idx, int v, int up ){
  ignore_events = false;
}

// gets called INPUT_DELAY ms after the last input change
void handle_ui_event( int idx, int v, int up ) {
  bool states[6] = {false};
  int new_sample_wheel_position;
  int new_mask_wheel_position;
  int mask_movement;
  int sample_movement;

  // read the switch states
  readStates(states);
  printStates(states);

  // compute where the wheels should go
  new_sample_wheel_position = get_desired_sample_wheel_position(states);
  new_mask_wheel_position = get_desired_mask_wheel_position(states);

  // compute how they should get there
  sample_movement = workout_movement(new_sample_wheel_position, current_sample_wheel_position);
  mask_movement = workout_movement(new_mask_wheel_position, current_mask_wheel_position);

  //move sample wheel
  move_wheel(1,sample_movement);

  //move sample wheel
  move_wheel(2,mask_movement);

  //record the new wheel positions
  current_sample_wheel_position = new_sample_wheel_position;
  current_mask_wheel_position = new_mask_wheel_position;

  if ( !motors_asleep ){
    led1.trigger( led1.EVT_BLINK );
  }
}


// gets called INPUT_DELAY ms after the last input change
void handle_button( int idx, int v, int up ) {
  if ( !motors_asleep && !ignore_events){
    led1.trigger( led1.EVT_ON );
    timer.trigger( timer.EVT_START );
  }
}

//void button_change( int idx, int v, int up ) {
//  printStates();
//  //if ( v == 1 ) {
//    //printStates();
//  //}
//}



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
  // setup led
  led1.begin( LED_BUILTIN );
  led1.blink( 40 );
  led1.pause( 500 );
  led2.begin( LED_BUILTIN );
  led2.blink( 40 );
  led2.pause( 100 );
  
  // initialize the motor pins
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

  // setup the input delay timer
  timer.begin( INPUT_DELAY )
    .onTimer( handle_ui_event );

  // setup the boot up button un-ignorer timer
  timer1.begin ( 100 )
    .onTimer( enable_inputs );

  // setup input pins
  button1.begin( SW_ROT_1 );
  pinMode( SW_ROT_2, INPUT_PULLUP);
  button2.begin( MW_SLIDE_1 );
  button3.begin( MW_SLIDE_2 );
  button4.begin( MW_SLIDE_3 );
  button5.begin( MW_SLIDE_4 );

  #ifdef USE_SERIAL_COMMS
  Serial.begin(115200);
  while (!Serial) {
    ; // wait for serial port to connect. Needed for native USB port only
  }
  #endif

  bool states[6] = {false};
  readStates(states);
  printStates(states);

  #ifdef USE_SERIAL_COMMS
  // send an intro:
  Serial.println("\n\nReady for action.\n");
  Serial.println();
  #endif

  // assume the wheels are wherever the switches say they are on boot up
  current_sample_wheel_position = get_desired_sample_wheel_position(states);
  current_mask_wheel_position = get_desired_mask_wheel_position(states);

  if ( !motors_asleep ){
    led1.trigger( led1.EVT_BLINK );
    
    // register button events
    button1.onPress( handle_button );
    button2.onPress( handle_button );
    button3.onPress( handle_button );
    button4.onPress( handle_button );
    button5.onPress( handle_button );
    button1.onRelease( handle_button );
    button2.onRelease( handle_button );
    button3.onRelease( handle_button );
    button4.onRelease( handle_button );
    button5.onRelease( handle_button );
  
    digitalWrite(SW_nSLEEP, HIGH); //HIGH enables the motor
    digitalWrite(MW_nSLEEP, HIGH); //HIGH enables the motor
  }
  // wait 100ms after boot to enable input events so we don't act on the initial button conditions
  timer1.trigger( timer.EVT_START );
}

// checks for valid switch positions and puts the motors to sleep if the switches dictate so
void go_to_sleep(){
  digitalWrite(SW_nSLEEP, LOW); //HIGH enables the motor
  digitalWrite(MW_nSLEEP, LOW); //HIGH enables the motor
  led1.trigger( led1.EVT_OFF );
  led2.trigger( led2.EVT_BLINK );
  motors_asleep = true;
}

//volatile unsigned long last_change_time = 0; // last time we got an interrupt change
//const unsigned long ACTION_DELAY = 3000; //delay between input change and action ms


// some global variables/constants
//volatile bool do_steps=false;
//const int STEP_DELAY_US = 5000; //micro second step delay

//const unsigned int STEP_RATE = 100; //step rate in Hz
//const unsigned int STEP_DURATION = 1000; //step duration in ms


// ISR flags
//volatile bool ISR_FLAG_input_changed = false; //gets set Serial.println(true by an ISR whenever a button or switch changes state
//volatile bool ISR_FLAG_rot_change = false; // flag for sample wheel rotary switch value change
//volatile bool ISR_FLAG_slide_change = false; // flag for mask wheel slide switch value change

void loop() {
  automaton.run();
//  char tool[22];
//
//  if (ISR_FLAG_input_changed){
//    chill_out();
//    int new_sample_input = get_desired_sample_wheel_position();
//    int new_mask_input = get_desired_mask_wheel_position();
//
//    if ((new_sample_input != -1) && (new_mask_input != -1)){
//      ;
//    }
//  }

//  if (Serial.available()) {      // If anything comes in Serial (USB),
//    Serial.readBytes(tool,Serial.available());
//    printStates();
//  }



  //run_motors();
}

//void chill_out(){
//  delay (ACTION_DELAY+10);
//  while (true){
//    if (millis() - last_change_time > ACTION_DELAY){
//      break;
//    } else {
//      delay (ACTION_DELAY);
//    }
//  }
//}

//void handle_input_change(){
//  if (debounced()){
//    if ((digitalRead(SW_ROT_1) == HIGH) && (digitalRead(SW_ROT_2) == HIGH)){
//      run_motors();
//    }
//    
//  }
//if ((digitalRead(SW_ROT_1) == HIGH) && (digitalRead(SW_ROT_2) == HIGH)){
//  //run_motors();
//  }
  //Serial.println(String("SW_ROT_1= ") + String(digitalRead(SW_ROT_1)));
  //Serial.println(String("SW_ROT_2= ") + String(digitalRead(SW_ROT_2)));
  //Serial.println();
//  ISR_FLAG_input_changed = false;
//}

//void handle_slide_change(){
//  printStates();
//  ISR_FLAG_slide_change = false;
//}

// returns -1, 1, 2, 3 or 4
// based on rotary switch position
// -1 is invalid and should be physically impossible
// 1, 2, 3 and 4 are for valid wheel positions
// boolean array of all the switch states as input
int get_desired_sample_wheel_position(bool states[6]){
  bool r1 = !states[0];
  bool r2 = !states[1];

  int desired = -1; // default to invalid

  if (!r1 && !r2){
     desired = 1; //sw pos 1
  } else if (r1 && !r2) {
    desired = 2; //sw pos 2
  } else if (!r1 && r2) {
    desired = 3; //sw pos 2
  } else if (r1 && r2) {
    desired = 4; //sw pos 4
  } else {
    desired = -1;
  }
  
  if ( (desired == -1) ){
    go_to_sleep();
  }
  
  return(desired);
}

// returns -1, 0, 1, 2, 3 or 4
// based on slide switch position
// -1 is invalid and means the switch is bridging two contacts or something
// 0 means it's in a non-mask wheel posision (5, 6, 7 or 8) and will put both motors to sleep
// 1, 2, 3 and 4 are for valid wheel positions
// boolean array of all the switch states as input
int get_desired_mask_wheel_position(bool states[6]){
  bool s1 = !states[2];
  bool s2 = !states[3];
  bool s3 = !states[4];
  bool s4 = !states[5];

  int desired = -1; // default to invalid

  if (s1 && !s2 && !s3 && !s4) {
    desired = 1; //mw pos 1
  } else if (!s1 && s2 && !s3 && !s4) {
    desired = 2; //mw pos 2
  } else if (!s1 && !s2 && s3 && !s4) {
    desired = 3; //mw pos 3
  } else if (!s1 && !s2 && !s3 && s4) {
    desired = 4; //mw pos 4
  } else if (!s1 && !s2 && !s3 && !s4) {
    desired = 0; //motors asleep
  } else {
    desired = -1; // invalid
  }

  if ( (desired == -1) || (desired == 0) ){
    go_to_sleep();
  }
  
  return(desired);
}

bool* readStates(bool states[6]){
  states[0] = digitalRead(SW_ROT_1);
  states[1] = digitalRead(SW_ROT_2);
  states[2] = digitalRead(MW_SLIDE_1);
  states[3] = digitalRead(MW_SLIDE_2);
  states[4] = digitalRead(MW_SLIDE_3);
  states[5] = digitalRead(MW_SLIDE_4);
}

void printStates(bool states[6]){
  #ifdef USE_SERIAL_COMMS
  Serial.println(String("\nSW_ROT_1= ") + String(states[0]) + String("\nSW_ROT_2= ") + String(states[1]) + String("\nMW_SLIDE_1= ") + String(states[2]) + String("\nMW_SLIDE_2= ") + String(states[3]) + String("\nMW_SLIDE_3= ") + String(states[4]) + String("\nMW_SLIDE_4= ") + String(states[5]) + String("\n"));
  #endif
}

// decides how to move
// return value can be -1 (one slot backwards), 1 or 2 (slots forwards), or 0 (no movement)
int workout_movement(int new_position, int old_position) {
  int diff = new_position - old_position;
  int result = 0;
  if ( diff == 0 ){
    result = 0;
  } else if (diff == 1 || diff == -3){
    result = 1;
  } else if (diff == 3 || diff == -1){
    result = -1;
  } else if (diff == 2 || diff == -2) {
    result = 2;
  }
  return(result);
}

//ISR routines
//void ISR_input_change() {
// ISR_FLAG_input_changed = true;
//  last_change_time = millis();
//}

//void run_motors(){
//  tone(SW_STEP, STEP_RATE, STEP_DURATION);
//  tone(MW_STEP, STEP_RATE, STEP_DURATION);
//}

//bool debounced(){
//  bool ret = false;
//  static unsigned long last_interrupt_time = 0;
//  
//  unsigned long interrupt_time = millis();
//  // If interrupts come faster than DEBOUNCE_MS, assume it's a bounce and ignore
//  if (interrupt_time - last_interrupt_time > DEBOUNCE_MS){
//    ret = true;
//   }
//   last_interrupt_time = interrupt_time;
//   return (ret);
//}

// moves a wheel
// the first argument should be 1 or 2 for sample or mask wheel respsectively
// the second argument is the number of slots to move (can be -1, 0, 1 or 2)
void move_wheel(int wheel, int movement){
  int step_pin = 0;
  int dir_pin = 0;
  if (wheel == 1){
    #ifdef USE_SERIAL_COMMS
    Serial.print("Moving sample wheel ");
    #endif
  } else if (wheel == 2){
    #ifdef USE_SERIAL_COMMS
    Serial.print("Moving mask wheel ");
    #endif
  }

  if (movement < 0){
    #ifdef USE_SERIAL_COMMS
    Serial.print("backwards ");
    #endif
  } else {
    #ifdef USE_SERIAL_COMMS
    Serial.print("forwards ");
    #endif
  }

  #ifdef USE_SERIAL_COMMS
  Serial.println(String("by ") + String(abs(movement)) + String(" slots."));
  #endif
  
}


/*
 * 
 * 
 * 
 * 

   */


//  if(do_steps){
//    digitalWrite(SW_STEP, HIGH);
//    digitalWrite(MW_STEP, HIGH);
//    digitalWrite(LED_BUILTIN, HIGH);   // turn the LED on (HIGH is the voltage level)
//    delayMicroseconds(STEP_DELAY_US);                       // wait
//    digitalWrite(SW_STEP, LOW);
//    digitalWrite(MW_STEP, LOW);
//    digitalWrite(LED_BUILTIN, LOW);    // turn the LED off by making the voltage LOW
//    delayMicroseconds(STEP_DELAY_US);                       // wait
//  }
