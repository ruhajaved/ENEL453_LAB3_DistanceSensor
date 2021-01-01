# ENEL453_LAB3

## Introduction

### Problem Statement

Using a distance sensor with a moving target, modify the functionality of Lab 2 by providing the four modes of operation for the 7-segment displays. The modes of operation will include:
1. Hexadecimal output of SW(7 downto 0) (existing Lab 1 functionality)
2. Decimal output of distance in centimeters. This means that you must provide the decimal point
in the correct location.
3. Decimal output of voltage in volts. This means that you must provide the decimal point in the
correct location.
4. Hexadecimal output value of the moving average of the 12-bit ADC value.

In addition to the above, PB2 should now be used to hold the display value.

For additional challenge (done in the provided solution), blank any leading zeros for values displayed (i.e. everything but the hexadecimal values.

### Project Objective

The project objectives included:

1.	To give the team an opportunity to become familiar with the technologies used.

## Technologies

The technologies used include:

1. VHDL 1997
2. Intel Quartus Prime Lite Edition v20.1
3. ModelSim Intel FPGA Starter Edition
4. DE10-Lite FPGA board from Terasic
5. Sharp Distance Measuring Sensor Unit GP2Y0A41SK0F

# Launch

To launch the project on to the board, you will first have to create a project in Quartus. To do so follow these steps:

1. Select "New Project Wizard".
2. Click "Next" on the intro page.
3. Choose a directory for the project, as well as a name for the project. Set the top level name to "top_level.vhd" and click "Next".
4. Select "Empty Project" and click "Next".
5. Add all the project files (everything with extensions vhd., qsf., and .sdc). Click "Next".
6. Go into the "Board" tab and select "MAX 10 DE10-Lite". Also, make sure to unselect "Create top-level design file" that is located near the bottom of the window. Click "Next".
7. Include no EDA tools. Click "Next".
8. Click "Finish".

Then, to program the hardware, ensure that the distance sensor is connected to the board appropriately.  Refer to "ENEL 453 Lab 3 v2.pdf" in the ENEL453_LAB3 repository for details. Then follow these steps to program the hardware:

1. Compile the design. This can be done through a button on the taskbar.
2. Click on "Program Device".
3. Click on "Hardware Setup".
4. Slect "USB-Blaster" and then "Close".
5. Finally, click on "Start" and wait till the progress bar shows 100%. At this point the board has been programmed and you can test the design.

If looking to simulate the design, create a project in ModelSim. You can then use any of the different testbenches provided to test different parts of the design.
