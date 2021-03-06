EESchema Schematic File Version 4
LIBS:wheel_driver-cache
EELAYER 29 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "B40 Sample and Mask Wheel Driver"
Date "2018-11-01"
Rev "1.0.0"
Comp "grey@christoforo.net"
Comment1 "https://github.com/AFMD/b40/tree/master/kicad/wheel_driver/wheel_driver.pdf"
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L MCU_Module2:Arduino_MKR_ZERO A1
U 1 1 5BDB4E56
P 2300 3200
F 0 "A1" H 2475 4275 50  0000 C CNN
F 1 "Arduino_MKR_ZERO" H 2475 4184 50  0000 C CNN
F 2 "" H 2450 2150 50  0001 L CNN
F 3 "https://www.arduino.cc/en/Main/arduinoBoardUno" H 2100 4250 50  0001 C CNN
	1    2300 3200
	1    0    0    -1  
$EndComp
$Comp
L Driver_Motor:Pololu_Breakout_A4988 A2
U 1 1 5BDB776A
P 5100 1800
F 0 "A2" H 5150 2681 50  0000 C CNN
F 1 "Pololu_Breakout_A8880" V 5550 1100 50  0000 C CNN
F 2 "Module:Pololu_Breakout-16_15.2x20.3mm" H 5375 1050 50  0001 L CNN
F 3 "https://www.pololu.com/product/2980/pictures" H 5200 1500 50  0001 C CNN
	1    5100 1800
	0    -1   -1   0   
$EndComp
$Comp
L Switch:SW_Coded_SH-7040 SW1
U 1 1 5BDB9110
P 1900 6650
F 0 "SW1" H 1957 7117 50  0000 C CNN
F 1 "SW_Coded_SH-7040" H 1957 7026 50  0000 C CNN
F 2 "Button_Switch_SMD:Nidec_Copal_SH-7040B" H 1600 6200 50  0001 L CNN
F 3 "https://www.nidec-copal-electronics.com/e/catalog/switch/sh-7000.pdf" H 1900 6650 50  0001 C CNN
	1    1900 6650
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Pack08 RN1
U 1 1 5BDC749D
P 3800 6500
F 0 "RN1" H 4188 6546 50  0000 L CNN
F 1 "Slide Switch" H 4188 6455 50  0000 L CNN
F 2 "" V 4275 6500 50  0001 C CNN
F 3 "~" H 3800 6500 50  0001 C CNN
	1    3800 6500
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR03
U 1 1 5BDC8ACC
P 3550 6850
F 0 "#PWR03" H 3550 6600 50  0001 C CNN
F 1 "GND" H 3555 6677 50  0000 C CNN
F 2 "" H 3550 6850 50  0001 C CNN
F 3 "" H 3550 6850 50  0001 C CNN
	1    3550 6850
	1    0    0    -1  
$EndComp
Wire Wire Line
	3400 6700 3400 6800
Wire Wire Line
	3400 6800 3500 6800
Wire Wire Line
	3700 6700 3700 6800
Wire Wire Line
	3700 6800 3600 6800
Wire Wire Line
	3600 6700 3600 6800
Connection ~ 3600 6800
Wire Wire Line
	3500 6700 3500 6800
Connection ~ 3500 6800
NoConn ~ 3800 6700
NoConn ~ 3900 6700
NoConn ~ 4000 6700
NoConn ~ 4100 6700
NoConn ~ 4100 6300
NoConn ~ 4000 6300
NoConn ~ 3900 6300
NoConn ~ 3800 6300
Text Notes 3400 7200 0    50   ~ 0
SLIDE SWITCH FOR MASK WHEEL
Wire Notes Line
	3300 7100 4700 7100
Wire Notes Line
	4700 7100 4700 6000
Wire Notes Line
	4700 6000 3300 6000
Wire Notes Line
	3300 6000 3300 7100
Text GLabel 3400 6300 1    50   Input ~ 0
MW_1
Text GLabel 3500 6300 1    50   Input ~ 0
MW_2
Text GLabel 3600 6300 1    50   Input ~ 0
MW_3
Text GLabel 3700 6300 1    50   Input ~ 0
MW_4
Text GLabel 2800 2550 2    50   Input ~ 0
MW_1
Text GLabel 2800 2650 2    50   Input ~ 0
MW_2
Text GLabel 1800 3450 0    50   Input ~ 0
MW_3
Text GLabel 1800 3350 0    50   Input ~ 0
MW_4
Text Notes 1350 7150 0    50   ~ 0
ROTARY SWITCH FOR SAMPLE WHEEL
$Comp
L power:GND #PWR02
U 1 1 5BDCF4EE
P 2900 6550
F 0 "#PWR02" H 2900 6300 50  0001 C CNN
F 1 "GND" H 2905 6377 50  0000 C CNN
F 2 "" H 2900 6550 50  0001 C CNN
F 3 "" H 2900 6550 50  0001 C CNN
	1    2900 6550
	1    0    0    -1  
$EndComp
Wire Wire Line
	2900 6450 2900 6550
Wire Wire Line
	2300 6450 2900 6450
Text GLabel 2300 6550 2    50   Input ~ 0
SW_1
Text GLabel 2300 6650 2    50   Input ~ 0
SW_2
NoConn ~ 2300 6750
NoConn ~ 2300 6850
Text GLabel 2800 3550 2    50   Input ~ 0
SW_1
Text GLabel 2800 3650 2    50   Input ~ 0
SW_2
$Comp
L Driver_Motor:Pololu_Breakout_A4988 A3
U 1 1 5BDD0039
P 5300 4750
F 0 "A3" V 5304 5494 50  0000 L CNN
F 1 "Pololu_Breakout_A8880" V 4800 3600 50  0000 L CNN
F 2 "Module:Pololu_Breakout-16_15.2x20.3mm" H 5575 4000 50  0001 L CNN
F 3 "https://www.pololu.com/product/2980/pictures" H 5400 4450 50  0001 C CNN
	1    5300 4750
	0    1    1    0   
$EndComp
$Comp
L Connector:Screw_Terminal_01x04 J3
U 1 1 5BDD0D11
P 6850 3400
F 0 "J3" H 6930 3392 50  0000 L CNN
F 1 "Screw_Terminal_01x04" H 6930 3301 50  0000 L CNN
F 2 "" H 6850 3400 50  0001 C CNN
F 3 "~" H 6850 3400 50  0001 C CNN
	1    6850 3400
	1    0    0    1   
$EndComp
Text Notes 7850 2950 2    50   ~ 0
MOTOR POWER INPUT (+12V)
NoConn ~ 6650 3200
NoConn ~ 6650 3500
$Comp
L power:GND #PWR08
U 1 1 5BDD1FC9
P 6200 3200
F 0 "#PWR08" H 6200 2950 50  0001 C CNN
F 1 "GND" H 6205 3027 50  0000 C CNN
F 2 "" H 6200 3200 50  0001 C CNN
F 3 "" H 6200 3200 50  0001 C CNN
	1    6200 3200
	1    0    0    1   
$EndComp
Wire Wire Line
	6650 3300 6450 3300
Wire Wire Line
	6200 3300 6200 3200
$Comp
L power:+VDC #PWR09
U 1 1 5BDD30A8
P 6200 3450
F 0 "#PWR09" H 6200 3350 50  0001 C CNN
F 1 "+VDC" H 6200 3725 50  0000 C CNN
F 2 "" H 6200 3450 50  0001 C CNN
F 3 "" H 6200 3450 50  0001 C CNN
	1    6200 3450
	1    0    0    1   
$EndComp
Wire Wire Line
	6650 3400 6450 3400
Wire Wire Line
	6200 3400 6200 3450
Text Label 6200 3400 0    50   ~ 0
+12V
Wire Notes Line
	3000 6000 3000 7000
Wire Notes Line
	3000 7000 1350 7000
Wire Notes Line
	1350 7000 1350 6000
Wire Notes Line
	1350 6000 3000 6000
$Comp
L Connector:Screw_Terminal_01x04 J2
U 1 1 5BDD9376
P 5300 5750
F 0 "J2" V 5172 5930 50  0000 L CNN
F 1 "Screw_Terminal_01x04" V 5263 5930 50  0000 L CNN
F 2 "" H 5300 5750 50  0001 C CNN
F 3 "~" H 5300 5750 50  0001 C CNN
	1    5300 5750
	0    1    1    0   
$EndComp
$Comp
L Connector:Screw_Terminal_01x04 J1
U 1 1 5BDDA39B
P 5100 850
F 0 "J1" V 5064 562 50  0000 R CNN
F 1 "Screw_Terminal_01x04" V 4973 562 50  0000 R CNN
F 2 "" H 5100 850 50  0001 C CNN
F 3 "~" H 5100 850 50  0001 C CNN
	1    5100 850 
	0    -1   -1   0   
$EndComp
Wire Notes Line
	4050 600  4050 2650
Wire Notes Line
	4050 2650 6600 2650
Wire Notes Line
	6600 2650 6600 600 
Wire Notes Line
	6600 600  4050 600 
Wire Notes Line
	6700 5950 4000 5950
Wire Notes Line
	4000 5950 4000 3900
Wire Notes Line
	4000 3900 6700 3900
Wire Notes Line
	6700 3900 6700 5950
Text Notes 5900 6050 0    50   ~ 0
MASK WHEEL DRIVER
Text Notes 5800 2750 0    50   ~ 0
SAMPLE WHEEL DRIVER
Wire Notes Line
	6050 2950 6050 3800
Wire Notes Line
	6050 3800 7850 3800
Wire Notes Line
	7850 3800 7850 2950
Wire Notes Line
	6050 2950 7850 2950
$Comp
L Device:CP1 C1
U 1 1 5BDE6051
P 4150 2050
F 0 "C1" H 3900 1950 50  0000 L CNN
F 1 "100μF" H 3800 2050 50  0000 L CNN
F 2 "" H 4150 2050 50  0001 C CNN
F 3 "~" H 4150 2050 50  0001 C CNN
	1    4150 2050
	1    0    0    -1  
$EndComp
Wire Wire Line
	4150 1600 4200 1600
Wire Wire Line
	4150 1900 4150 1600
$Comp
L power:GND #PWR04
U 1 1 5BDE8C9D
P 4150 2250
F 0 "#PWR04" H 4150 2000 50  0001 C CNN
F 1 "GND" H 4155 2077 50  0000 C CNN
F 2 "" H 4150 2250 50  0001 C CNN
F 3 "" H 4150 2250 50  0001 C CNN
	1    4150 2250
	-1   0    0    -1  
$EndComp
Wire Wire Line
	4150 2200 4150 2250
$Comp
L Device:CP1 C2
U 1 1 5BDEB8B0
P 6500 5200
F 0 "C2" H 6615 5246 50  0000 L CNN
F 1 "100μF" H 6150 5200 50  0000 L CNN
F 2 "" H 6500 5200 50  0001 C CNN
F 3 "~" H 6500 5200 50  0001 C CNN
	1    6500 5200
	1    0    0    -1  
$EndComp
Wire Wire Line
	6000 4950 6500 4950
$Comp
L power:GND #PWR011
U 1 1 5BDED4A9
P 6500 5450
F 0 "#PWR011" H 6500 5200 50  0001 C CNN
F 1 "GND" H 6505 5277 50  0000 C CNN
F 2 "" H 6500 5450 50  0001 C CNN
F 3 "" H 6500 5450 50  0001 C CNN
	1    6500 5450
	-1   0    0    -1  
$EndComp
Wire Wire Line
	6500 5350 6500 5450
Wire Wire Line
	6500 5050 6500 4950
Text GLabel 5300 4350 1    50   Input ~ 0
MW_STEP
Text GLabel 5200 4350 1    50   Input ~ 0
MW_DIR
Wire Wire Line
	5100 5250 5100 5550
Wire Wire Line
	5200 5550 5200 5250
Wire Wire Line
	5300 5250 5300 5550
Wire Wire Line
	5400 5550 5400 5250
Wire Wire Line
	5000 1050 5000 1300
Wire Wire Line
	5100 1300 5100 1050
Wire Wire Line
	5200 1050 5200 1300
Wire Wire Line
	5300 1300 5300 1050
$Comp
L power:GND #PWR07
U 1 1 5BDF26CC
P 6200 1900
F 0 "#PWR07" H 6200 1650 50  0001 C CNN
F 1 "GND" H 6205 1727 50  0000 C CNN
F 2 "" H 6200 1900 50  0001 C CNN
F 3 "" H 6200 1900 50  0001 C CNN
	1    6200 1900
	-1   0    0    -1  
$EndComp
$Comp
L power:+VDC #PWR05
U 1 1 5BDF2D66
P 4200 1250
F 0 "#PWR05" H 4200 1150 50  0001 C CNN
F 1 "+VDC" H 4200 1525 50  0000 C CNN
F 2 "" H 4200 1250 50  0001 C CNN
F 3 "" H 4200 1250 50  0001 C CNN
	1    4200 1250
	-1   0    0    -1  
$EndComp
Wire Wire Line
	4200 1250 4200 1600
$Comp
L power:+VDC #PWR010
U 1 1 5BDF39C2
P 6500 4700
F 0 "#PWR010" H 6500 4600 50  0001 C CNN
F 1 "+VDC" H 6500 4975 50  0000 C CNN
F 2 "" H 6500 4700 50  0001 C CNN
F 3 "" H 6500 4700 50  0001 C CNN
	1    6500 4700
	-1   0    0    -1  
$EndComp
Wire Wire Line
	6500 4700 6500 4950
Connection ~ 6500 4950
Text GLabel 5200 2200 3    50   Input ~ 0
SW_DIR
Text GLabel 5100 2200 3    50   Input ~ 0
SW_STEP
NoConn ~ 5000 2200
NoConn ~ 4700 2200
NoConn ~ 5500 2200
NoConn ~ 5600 2200
NoConn ~ 4800 4350
NoConn ~ 4900 4350
NoConn ~ 5400 4350
NoConn ~ 5700 4350
$Comp
L power:GND #PWR06
U 1 1 5BDF8F90
P 4250 5100
F 0 "#PWR06" H 4250 4850 50  0001 C CNN
F 1 "GND" H 4255 4927 50  0000 C CNN
F 2 "" H 4250 5100 50  0001 C CNN
F 3 "" H 4250 5100 50  0001 C CNN
	1    4250 5100
	-1   0    0    -1  
$EndComp
Wire Wire Line
	4500 4750 4250 4750
Wire Wire Line
	4250 4750 4250 4950
Wire Wire Line
	4500 4950 4250 4950
Connection ~ 4250 4950
Wire Wire Line
	4250 4950 4250 5100
Wire Wire Line
	5900 1600 6200 1600
Wire Wire Line
	6200 1600 6200 1800
Wire Wire Line
	5900 1800 6200 1800
Connection ~ 6200 1800
Wire Wire Line
	6200 1800 6200 1900
Text GLabel 2800 3150 2    50   Input ~ 0
SW_STEP
Text GLabel 2800 3250 2    50   Input ~ 0
MW_STEP
Text GLabel 2800 3350 2    50   Input ~ 0
SW_~SLEEP
Text GLabel 2800 3450 2    50   Input ~ 0
MW_~SLEEP
Text GLabel 4800 2200 3    50   Input ~ 0
SW_~SLEEP
Text GLabel 5600 4350 1    50   Input ~ 0
MW_~SLEEP
Text GLabel 1800 3650 0    50   Input ~ 0
SW_DIR
Text GLabel 1800 3550 0    50   Input ~ 0
MW_DIR
NoConn ~ 2800 3050
NoConn ~ 2800 2950
NoConn ~ 2800 2850
NoConn ~ 2800 2750
NoConn ~ 2800 2350
NoConn ~ 2800 2450
NoConn ~ 1800 3250
NoConn ~ 1800 3150
NoConn ~ 1800 3050
NoConn ~ 1800 2950
NoConn ~ 1800 2850
NoConn ~ 1800 2750
$Comp
L power:GND #PWR01
U 1 1 5BE04D1E
P 1500 2850
F 0 "#PWR01" H 1500 2600 50  0001 C CNN
F 1 "GND" H 1505 2677 50  0000 C CNN
F 2 "" H 1500 2850 50  0001 C CNN
F 3 "" H 1500 2850 50  0001 C CNN
	1    1500 2850
	-1   0    0    -1  
$EndComp
NoConn ~ 1800 2350
NoConn ~ 1800 2450
NoConn ~ 1800 2550
Text Notes 4450 750  0    50   ~ 0
SAMPLE WHEEL MOTOR CONNECTION
Text Notes 4550 5900 0    50   ~ 0
MASK WHEEL MOTOR CONNECTION
Wire Wire Line
	4400 1600 4200 1600
Connection ~ 4200 1600
Wire Wire Line
	1500 2850 1500 2650
Wire Wire Line
	1500 2650 1800 2650
Wire Wire Line
	3500 6800 3550 6800
Wire Wire Line
	3550 6850 3550 6800
Connection ~ 3550 6800
Wire Wire Line
	3550 6800 3600 6800
$Comp
L power:PWR_FLAG #FLG01
U 1 1 5BE0AE52
P 6450 3300
F 0 "#FLG01" H 6450 3375 50  0001 C CNN
F 1 "PWR_FLAG" H 6450 3473 50  0001 C CNN
F 2 "" H 6450 3300 50  0001 C CNN
F 3 "~" H 6450 3300 50  0001 C CNN
	1    6450 3300
	1    0    0    -1  
$EndComp
Connection ~ 6450 3300
Wire Wire Line
	6450 3300 6200 3300
$Comp
L power:PWR_FLAG #FLG02
U 1 1 5BE0B31F
P 6450 3400
F 0 "#FLG02" H 6450 3475 50  0001 C CNN
F 1 "PWR_FLAG" H 6450 3573 50  0001 C CNN
F 2 "" H 6450 3400 50  0001 C CNN
F 3 "~" H 6450 3400 50  0001 C CNN
	1    6450 3400
	-1   0    0    1   
$EndComp
Connection ~ 6450 3400
Wire Wire Line
	6450 3400 6200 3400
$Comp
L Motor:Stepper_Motor_bipolar M1
U 1 1 5BDB3F6A
P 7800 1200
F 0 "M1" H 7988 1324 50  0000 L CNN
F 1 "Stepper_Motor_bipolar" H 7988 1233 50  0000 L CNN
F 2 "" H 7810 1190 50  0001 C CNN
F 3 "http://www.infineon.com/dgdl/Application-Note-TLE8110EE_driving_UniPolarStepperMotor_V1.1.pdf?fileId=db3a30431be39b97011be5d0aa0a00b0" H 7810 1190 50  0001 C CNN
	1    7800 1200
	1    0    0    -1  
$EndComp
$Comp
L Motor:Stepper_Motor_bipolar M2
U 1 1 5BDB54BA
P 7800 5300
F 0 "M2" H 7988 5424 50  0000 L CNN
F 1 "Stepper_Motor_bipolar" H 7988 5333 50  0000 L CNN
F 2 "" H 7810 5290 50  0001 C CNN
F 3 "http://www.infineon.com/dgdl/Application-Note-TLE8110EE_driving_UniPolarStepperMotor_V1.1.pdf?fileId=db3a30431be39b97011be5d0aa0a00b0" H 7810 5290 50  0001 C CNN
	1    7800 5300
	1    0    0    -1  
$EndComp
Text Notes 7550 5700 0    50   ~ 0
MASK WHEEL MOTOR
Text Notes 7400 1500 0    50   ~ 0
SAMPLE WHEEL MOTOR
Text Label 5300 1300 1    50   ~ 0
SW_2B
Text Label 5200 1300 1    50   ~ 0
SW_2A
Text Label 5100 1300 1    50   ~ 0
SW_1A
Text Label 5000 1300 1    50   ~ 0
SW_1B
Text Label 7500 1300 2    50   ~ 0
SW_2B
Text Label 7500 1100 2    50   ~ 0
SW_2A
Text Label 7700 900  1    50   ~ 0
SW_1B
Text Label 7900 900  1    50   ~ 0
SW_1A
Wire Notes Line
	7100 600  8850 600 
Wire Notes Line
	8850 600  8850 1400
Wire Notes Line
	8850 1400 7100 1400
Wire Notes Line
	7100 1400 7100 600 
Text Label 5100 5550 1    50   ~ 0
MW_1B
Text Label 5200 5550 1    50   ~ 0
MW_1A
Text Label 5300 5550 1    50   ~ 0
MW_2A
Text Label 5400 5550 1    50   ~ 0
MW_2B
Text Label 7700 5000 1    50   ~ 0
MW_1B
Text Label 7900 5000 1    50   ~ 0
MW_1A
Text Label 7500 5200 2    50   ~ 0
MW_2A
Text Label 7500 5400 2    50   ~ 0
MW_2B
Wire Notes Line
	7200 5600 7200 4700
Wire Notes Line
	7200 4700 8950 4700
Wire Notes Line
	8950 4700 8950 5600
Wire Notes Line
	8950 5600 7200 5600
Wire Wire Line
	6000 4750 6000 3800
Wire Wire Line
	6000 3800 5000 3800
Wire Wire Line
	5000 3800 5000 4350
Wire Wire Line
	5400 2200 5400 2750
Wire Wire Line
	5400 2750 4400 2750
Wire Wire Line
	4400 2750 4400 1800
Text Label 4400 2000 1    50   ~ 0
V3P3
Text Label 6000 4650 1    50   ~ 0
V3P3
$EndSCHEMATC
