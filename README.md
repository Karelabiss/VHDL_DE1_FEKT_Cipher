# VHDL_DE1_FEKT_Cipher

# Smart Parking System with Ultrasonic Sensors

## Table of Contents
- [Introduction](#introduction)
- [Team](#team)
- [Theoretical Description and Explanation](#theoretical-description-and-explanation)
- [Hardware Description of Demo Application](#hardware-description-of-demo-application)
- [Software Description](#software-description)
- [Instructions](#instructions)
- [Video](#video)
- [Tools and References](#tools-and-references)

## Introduction
This project aims to design and implement a smart parking system using VHDL on the Nexys A7 FPGA board. The system utilizes ultrasonic sensor for detecting the distance of objects from obstacles.


## Team

    Jonas H: programming, repository, graphics
    Jan D: programming, debugging, constraints, comments
    Adam B: programming, innovation, testbenches
    Patrik B: hardware, documentation and manual, video

## Theoretical description and explanation

Design and implement a smart parking system using VHDL on the Nexys A7 FPGA board. The system will utilize multiple ultrasonic sensors (HS-SR04) connected to the Pmod connectors for detecting the presence and distance of vehicles within parking spaces. Develop algorithms to analyze sensor data and determine parking space availability. Visualize parking space occupancy status using LEDs, while displaying distance measurements on the 7-segment display.

The aim is to develop innovative solutions while implementing the function of proximity sensing using VHDL and FPGA, and relaying the information visually.
It is important to note that HC-SR04 produces a pulse, whose width corresponds to the distance from an obstacle. If we want to process this information,
we shall measure the width, apply unit conversion and finally utilize the board's displays and LEDs. Our extended goal thereafter is to make the code scalable, so that
the board can harness the information of multiple such sensors.

## Hardware description of demo application

<img src="https://github.com/VUT246843/VHDLprojekt/assets/165208595/ff8f4049-588c-4923-8c18-9f2f7cddb844" width="390px"/>
<img src="https://github.com/VUT246843/VHDLprojekt/assets/165208595/f14947a6-a02f-44b1-8cf6-f4306d6abfd6" width="420px"/>

Nexys A7 50-T board and its hardware components

<img src="https://github.com/VUT246843/VHDLprojekt/assets/165208595/83f1c10e-2d14-403f-b75d-5f48001c31d8" height="480px"/>

Nexys A7 50-T schematic 

<img src="https://github.com/VUT246843/VHDLprojekt/assets/165208595/d6bc9a6a-7eee-47c5-b7d7-34a22d4c3e74" width="280"/>
<img src="https://github.com/VUT246843/VHDLprojekt/assets/165208595/533ec0b2-04be-4bcd-b6fd-376e77d05412" width="400px"/>

Ultrasonic sensor HC-SR04 and its function

<img src="https://github.com/VUT246843/VHDLprojekt/assets/165208595/8c3a8a87-8144-4ad8-9705-3614074da50f" width="380px"/>

Arduino Uno used as an external power supply for USS 

## Software description

### High level overview

<img src="https://github.com/VUT246843/VHDLprojekt/assets/114212657/0dec13c9-3b24-4386-9673-b754c8fe2fd8" width="650px"/>

This diagram illustrates the components used and the important data flows between them. The components are instantiated in the [top_level](https://github.com/VUT246843/VHDLprojekt/blob/main/Parking_system/top_level.vhd).

### Component: sensor trigger and pulse width counter <sup>[source](https://github.com/VUT246843/VHDLprojekt/blob/main/Parking_system/Main.vhd), [testbench](https://github.com/VUT246843/VHDLprojekt/blob/main/Parking_system/Testbenches/tb_main.vhd) </sup>

FSM flow state diagram

<img src="https://github.com/VUT246843/VHDLprojekt/assets/114212657/94344147-5161-4f2e-a5cd-74bde0df5d06" width="420px"/>

State can be changed with every rising edge. An asynchronous `reset` initiates the state to `s0`. Signal `start` initiates the measuring process.
An ultrasound pulse is emitted and returns to receiver. State `s2` then increments the `echo_len` for the length of the pulse or until the
specified limit. The hexadecimal output signal `distance` is sent to the next component.

<img src="https://github.com/VUT246843/VHDLprojekt/blob/main/Demos/Tb_main.png"/>

FSM testbench simulation for artificial pulse lengths of 300, 400 and 100 ns which return distances of 3, 4 and 1 cm. Note that the pulse widths are not real and were artificially simulated.

### Component: hex-binary converter and splitter <sup>[source](https://github.com/VUT246843/VHDLprojekt/blob/main/Parking_system/bin2bcd.vhd), [testbench](https://github.com/VUT246843/VHDLprojekt/blob/main/Parking_system/Testbenches/tb_bin2bcd.vhd) </sup>

This component converts hexadecimal numbers supplied by the previous component to a binary number. Afterwards, the binary number is split into signals of
`hundreds`, `tens` and `ones`, which can be easily displayed as numbers on 7-segment displays.

<img src="https://github.com/VUT246843/VHDLprojekt/blob/main/Demos/Tb_bin2bcd.png">

Simulation example with input numbers 51, 30, 124, 2901. The algorithm splits them into four signals,
each standing for one digit, e.g. 2901 → 2;9;0;1. Note that our sensor supports at most 400 cm, making
the signal for thousands redundant.

### Component: 7-segment diplay driver <sup>[source](https://github.com/VUT246843/VHDLprojekt/blob/main/Parking_system/visu7seg.vhd), [testbench](https://github.com/VUT246843/VHDLprojekt/blob/main/Parking_system/Testbenches/tb_visu7seg.vhd)</sup>

<img src="https://github.com/VUT246843/VHDLprojekt/blob/main/Demos/Tb_visu7seg.png">

This component acts as a driver for the displays: it maps binary numbers to individual segments. The component has several inputs, including `hundreds`, `tens` and `ones`.
It uses a counter to cycle through these vector signals to select which one to display on each 7-segment display.

## Instructions

Write an instruction manual for your application, including photos.

![vlastní zapojení](https://github.com/VUT246843/VHDLprojekt/assets/165208595/cdd2d4d5-ef9e-4df4-a03d-988245d2fcb9)

Practical circuit wiring with arduino and the sensor

![rn_image_picker_lib_temp_6f0b5934-7825-4fa5-a5bc-865a4583f82e](https://github.com/VUT246843/VHDLprojekt/assets/165208595/f7b76f36-5ca7-467b-818c-99172666a027)

## Video

[link to a short video](https://www.youtube.com/watch?v=_j5DjAFLo7g)

## Tools and References
[Vivado Design Suite](https://www.xilinx.com/products/design-tools/vivado.html)

[Nexys A7 reference manual](https://digilent.com/reference/programmable-logic/nexys-a7/reference-manual)

[XESS VHDL_lib](https://github.com/xesscorp/VHDL_Lib)

[VHDL testbench generator](https://vhdl.lapinoo.net/testbench/)

[Inkscape](https://inkscape.org/)


Digital Electronics Lectures presentation by Tomas Fryza
