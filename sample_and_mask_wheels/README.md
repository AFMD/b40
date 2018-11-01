# Wheel Driver Electronics
Connections to the driver board and controls for turning the wheels look like ![this](/sample_and_mask_wheels/images/board_connections.jpg)

The electrical schematic for the driver of the sample and mask wheels is
[![here](/sample_and_mask_wheels/kicad/wheel_driver/wheel_driver.svg)](https://github.com/AFMD/b40/raw/master/sample_and_mask_wheels/kicad/wheel_driver/wheel_driver.pdf)

The stepper motor driver boards are from pololu.com, [product number 2971](https://www.pololu.com/product/2971): "DRV8880 Stepper Motor Driver Carrier"

Bipolar stepper motors must be used (currently VSS25.200.1.2-UHVG by Phytron). They must be wired so that the two phases of each motor are connected on neighboring screw terminals (as shown in the schematic above).
