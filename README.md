# Implementation of Basic Ciphers

## Table of Contents
- [Introduction](#introduction)
- [Team members](#team-members)
- [Theoretical Description and Explanation](#theoretical-description-and-explanation)
- [Hardware Description of Demo Application](#hardware-description-of-demo-application)
- [Software Description](#software-description)
- [Instructions](#instructions)
- [Video](#video)
- [Tools and References](#tools-and-references)

## Introduction
This project aims to demonstrate simple ciphers, such as the Vernam Cipher and Caesar Cipher using basic logic gates and flip-flops on the Nexys A7 FPGA board. Each cipher enabling users to input letters in binary code and observe the resulting ciphertext generated by the encryption process.


## Team members

    Roman Štofa: programming, prezentation
    Adam Hodor: programming, debugging
    Dominik Rechtorík: programming, repository
    Dominik Šrenk: programming, repository

## Theoretical description and explanation

This project aims to demonstrate simple ciphers, in this case the Vernam Cipher and Caesar Cipher using basic logic gates and flip-flops on the Nexys A7 FPGA board. Each cipher enabling users to input letters in binary code and observe the resulting ciphertext generated by the encryption process. Buttons and switches serve as input devices for users to input plaintext messages and control the encryption/decryption process. The seven-segment display is used to show the binary code that we want to encode/decode and this encoded or decoded code can be seen in the Putty console on PC.


## Hardware description of demo application

Nexys A7 50-T and its components

<img src="https://github.com/Karelabiss/VHDL_DE1_FEKT_Cipher/blob/main/img/nexys-a7-callout.png" width="390px"/>
<img src="https://github.com/Karelabiss/VHDL_DE1_FEKT_Cipher/blob/main/img/components.PNG" width="450px"/>

7-segment display schematic

<img src="https://github.com/Karelabiss/VHDL_DE1_FEKT_Cipher/blob/main/img/n4r.png" height="480px"/>

6Pin USB TTL UART converter, CP2102, DTR pin for Nexys A7 50-T board

<img src="https://github.com/Karelabiss/VHDL_DE1_FEKT_Cipher/blob/main/img/1158.png"/>



## Software description

### High level overview

<img src=""/>

This diagram illustrates the components used and the important data flows between them. The components are instantiated in the [top_level](https://github.com/Karelabiss/VHDL_DE1_FEKT_Cipher/blob/main/Project_final/top_level.vhd).

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

![vlastní zapojení](https://github.com/Karelabiss/VHDL_DE1_FEKT_Cipher/blob/main/img/zapojenie%20dosky.png)

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
