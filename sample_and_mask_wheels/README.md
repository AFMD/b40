# Wheel Driving System Description
Connections to the driver board and controls for turning the wheels look like ![this](/sample_and_mask_wheels/images/board_connections.jpg)

The electrical schematic for the driver of the sample and mask wheels is
[![here](/sample_and_mask_wheels/kicad/wheel_driver/wheel_driver.svg)](https://github.com/AFMD/b40/raw/master/sample_and_mask_wheels/kicad/wheel_driver/wheel_driver.pdf)

The controller logic is governed by [this Arduino firmware](https://github.com/AFMD/b40/blob/master/sample_and_mask_wheels/firwmare/wheels_driver/wheels_driver.ino) which runs on the Arduino MKR Zero module in the system. The Arduino must powered separately from the motors. Probably just power it via its micro USB port.

The stepper motor driver boards are from pololu.com, [product number 2971](https://www.pololu.com/product/2971): "DRV8880 Stepper Motor Driver Carrier"

The motors in the system are bipolar steppers (currently VSS25.200.1.2-UHVG by Phytron). They must be wired so that the two phases of each motor are connected on neighboring screw terminals (as shown in the schematic above). These are 200 step per revolution motors. The pololu motor driver boards are left in their default configuration, except M1 is connected to V3P3 so that they're in 1/16 microstepping mode and the firmware delivers 800 pulses on the step pin for a quarter turn (one sample/mask change). The pulses are delivered at 100Hz, so it takes 4 seconds for an adjacent change and 8 seconds to change to the opposite position.

The sample wheel positions should be marked 0-3 and the mask wheel positions should be marked 1-4.

## Operating principals
* The wheels are generally not free to turn by hand and doing so may cause damage to the motors and/or the controller
* The amber LED has four valid states:
  1. Off: the Arduino module has no power
  2. Blinking slowly: normal operation
  3. Blinking very fast: the motors are "asleep" and the wheels are free to rotate very carefully by hand
    * The only way to get out of this state is by pressing the reset button
  4. Solid: The firmware is in the 5 second wait mode after the user has changed a switch position OR the wheels are moving
* When the system powers up or comes out of reset it will assume the wheels are in the positions shown by the switch and dial
* __The firmware only reads the slider and dial positions 5 seconds after the user has stopped changing them__ That means you can make as many changes to the sample wheel dial and mask wheel slider as you like but only the positions they're in 5 seconds after you've stopped moving them matters. That means, as long as you don't make a 5 second pause, you have as much time as you need to get your input selection right.

## Hardware setup instructions
1. Begin by wiring the motors to the controller board. Connect mask and sample wheel motors to the terminals as shown in the above diagram. The two phases of each motor must be connected on neighboring screw terminals (this can be checked with an ohm meter; there should be ~2-3 ohm between the two motor connection screws 1 and 2 as well as between 3 and 4, and over half a mega ohm between 2 and 3. If this is not the case, the motor is either damaged or wired incorrectly).
1. Move the sample wheel selector to the zero position and the mask wheel slider to the 8 position.
1. Apply USB power to the Arduino module. The amber LED should now be blinking very fast.
1. Wire up the +12V motor power supply to the terminals as shown in the above diagram and turn it on. It should be supplying approximately 1 mA at this point.
1. By hand, rotate the wheels (or adjust their setscrews) so that the sample wheel has slot 0 exactly over the evaporation window and the mask wheel has slot 1 exactly over the window.
1. Move the mask wheel slider switch to position 1.
1. Push the reset button. The wheel motors will now receive power and they'll be locked in position in agreement with the slide switch and dial. The amber LED should blink slowly. The system is now ready to use and the 12V power supply should be delivering about 475mA.

## Usage
* Use a little flat head screwdriver to interact with the mask slider switch and the sample wheel dial.
* Rotate the sample wheel dial to cause the sample wheel to move. The amber LED will become solid when you move the dial. Wait for it to start blinking again before you make another movement.
  * The sample wheel dial has a little white dot that lines up with the number that's currently selected. Numbers 0-3 on the dial correspond to wheel positions 0-3. __The rest of the numbers on the dial (4-9) also correspond to different sample wheel positions, but probably don't use them because they're confusing:__ dial 4 = wheel 0, 5=1, 6=2, 7=3, 8=0, 9=1
* Move the mask wheel slider to cause the mask wheel to move. The amber LED will become solid when you move the slider. Wait for it to start blinking again before you make another movement.
  * Positions 1-4 correspond to mask wheel positions 1-4.
  * If you move the mask wheel slider to positions 5-8 the motors will be put to sleep as shown by the amber LED blinking very fast. In this state, the wheels can be carefully rotated by hand. To exit this "motor asleep" state, move the wheels to their desired positions, set the mask slider switch and sample dial to their corresponding positions and press the reset button.
* If the wheels somehow become out of sync with the input controls, move the slider to position 8 to put the system into "motor sleep mode" (amber LED blinking very fast) and follow the last three steps of the hardware setup instructions above.


## FAQ
__Q.__ What do I do if the wheels aren't moving and the amber LED is blinking very fast?  
__A.__ Manually move the sample wheel to position 0. Manually move the mask wheel to position 1. Twist the sample selector on the control PCB to position 0. Move the mask wheel slider switch to position 1. Push the reset button on the Arduino on the control PCB. The amber LED should now be blinking slowly and the system should be ready for use.  


__Q.__ How do I power it down?  
__A.__ Move the mask wheel slider switch to position 8 and wait for the amber LED to start blinking very fast. Power off the 12V motor power supply. Remove power from the Arduino board by unplugging its USB cable. Failure to power down in the correct way could cause damage to the system.  


__Q.__ How do I power it up?  
__A.__ Make sure the mask wheel slider switch is in position 8. Apply USB power to the Arduino. The amber LED should start blinking very fast. Power on the 12V motor power supply, it should now be supplying ~1mA. Move the sample wheel control dial to match the position the sample wheel is in. Move the mask wheel control slider switch to match the position the mask wheel is in. Push the reset button on the Arduino. The 12V power supply should now be providing ~475mA and the amber LED should be blinking slowly. The system is now ready for use. Failure to power down in the correct way could cause damage to the system.
