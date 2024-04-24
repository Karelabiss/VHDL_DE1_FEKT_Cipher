# Implementation of Basic Ciphers

## Table of Contents
- [Introduction](#introduction)
- [Developer team](#Developer-team)
- [Theoretical Description and Explanation](#theoretical-description-and-explanation)
- [Hardware Description of Demo Application](#hardware-description-of-demo-application)
- [Software Description](#software-description)
- [Instructions](#instructions)
- [Video](#video)
- [Tools and References](#tools-and-references)

## Introduction
The objective of this project is to showcase elementary ciphers like the Vernam Cipher, Caesar Cipher and Adbash Cipher by employing fundamental logic gates and flip-flops on the Nexys A7 FPGA board. Through this setup, users can input letters in binary code and witness the resulting ciphertext generated during the encryption process for each cipher.


## Developer team

    Roman Štofa: tried programming but failed :(, prezentation, repository
    Adam Hodor: programming, testing, top_level diagram
    Dominik Rechtorík: programming, documentation
    Dominik Šrenk: programming, repository, testbenches

## Theoretical description and explanation

This project aims to demonstrate simple ciphers, in this case the Vernam Cipher, Caesar Cipher and Adbash Cipher using basic logic gates and flip-flops on the Nexys A7 FPGA board. Each cipher is enabling users to input letters in binary code and observe the resulting ciphertext generated by the encryption process. Buttons and switches serve as input devices for users to input letters and control the encryption/decryption process. The seven-segment display is used to show the binary code that we want to encode/decode and this encoded or decoded code can be seen in the Putty console on PC. We are connecting the board to the computer using the 6Pin USB TTL UART converter.


## Hardware description of demo application

Nexys A7 50-T and its components

<img src="https://github.com/Karelabiss/VHDL_DE1_FEKT_Cipher/blob/main/img/nexys-a7-callout.png" width="390px"/>
<img src="https://github.com/Karelabiss/VHDL_DE1_FEKT_Cipher/blob/main/img/components.PNG" width="450px"/>

Nexys A7 50-T schematic

<img src="https://github.com/Karelabiss/VHDL_DE1_FEKT_Cipher/blob/main/img/n4r.png" height="480px"/>

6Pin USB TTL UART converter, CP2102, DTR pin for Nexys A7 50-T board

<img src="https://github.com/Karelabiss/VHDL_DE1_FEKT_Cipher/blob/main/img/1158.png"/>



## Software description

<img src="https://github.com/Karelabiss/VHDL_DE1_FEKT_Cipher/blob/main/img/diagramik.drawio.png"/>

This diagram depicts the utilized components and the significant data exchanges among them. The components are instantiated at the [top_level](https://github.com/Karelabiss/VHDL_DE1_FEKT_Cipher/blob/main/Project_final/top_level.vhd).

### Component: Caesar Cipher <sup>[source](https://github.com/Karelabiss/VHDL_DE1_FEKT_Cipher/blob/main/Project_final/Ceaser_cipher.vhd), [testbench](https://github.com/Karelabiss/VHDL_DE1_FEKT_Cipher/blob/main/Ceaser_cipher/Ceaser_cipher_tb.vhd) </sup>

<img src="https://github.com/Karelabiss/VHDL_DE1_FEKT_Cipher/blob/main/img/Ceaser_tb_image.png"/>

The `input` is given as "ahoj" (65 - a, 72 - h, 79 - o, 74 - j), the `shift` is set to 2, so when encoding, 2 is added to each letter and output as `code_output` (encoded message). Subsequently, `code_output` is transformed into `coded_text_input`, and the `shift` is subtracted from its values to produce `decode_output`, which is essentially the decoded output.

### Component: Atbash Cipher <sup>[source](https://github.com/Karelabiss/VHDL_DE1_FEKT_Cipher/blob/main/Atbash_cipher/atbash_cipher.vhd), [testbench](https://github.com/Karelabiss/VHDL_DE1_FEKT_Cipher/blob/main/Atbash_cipher/atbash_cipher_tb.vhd) </sup>

<img src="https://github.com/Karelabiss/VHDL_DE1_FEKT_Cipher/blob/main/img/Atbash_tb_image.png/">

Transforms A to Z, B to Y etc.


### Component: Vernam Cipher <sup>[source](https://github.com/Karelabiss/VHDL_DE1_FEKT_Cipher/blob/main/Project_final/Vernam_cipher.vhd), [testbench](https://github.com/Karelabiss/VHDL_DE1_FEKT_Cipher/blob/main/Vernam_cipher/Vernam_cipher_tb.vhd) </sup>



<img src="https://github.com/Karelabiss/VHDL_DE1_FEKT_Cipher/blob/main/img/Vernam_tb_image/">

The `input` is given as "ahoj", the `shift` generates random seed (in this case 00000011), so when encoding, `input` values are XOR-ed with `shift` value creating `code_output` (encoded message). `code_output` is transformed into `coded_text_input`, and the `shift` is again using mathematical function XOR to create `decode_output`, which is essentially the decoded output.

### Component: 7-segment display driver <sup>[source](https://github.com/Karelabiss/VHDL_DE1_FEKT_Cipher/blob/main/Project_final/driver_7seg_4digits.vhd), [testbench](https://github.com/Karelabiss/VHDL_DE1_FEKT_Cipher/blob/main/display_freeza_funkcni/tb_driver_7seg_4digits.vhd)</sup>

<img src="https://github.com/Karelabiss/VHDL_DE1_FEKT_Cipher/blob/main/img/7seg_8digits_display.png"/>

This component acts as a driver for the displays: it maps binary numbers to individual segments. sig_clk_100MHz is set to 2 ms. The component has several inputs, including `sig_data7` - `sig_data0` and outputs `sig_dig7` - `sig_dig0` responsible for the position on the 7-segment display. `sig_seg6` - `sig_seg0`  are used to illuminate individual segments. 
It uses a counter to cycle through these vector signals to select which one to display on each 7-segment display.

## Instructions

<img src="https://github.com/Karelabiss/VHDL_DE1_FEKT_Cipher/blob/main/img/port_description.png" width="450" height="400"/>

BTNC - reset

BTNR - sends data from the board to the computer via a 6-pin USB TTL UART converter

BTND - stores data from the display as input into the component

SWL0 - encoding

SWL1 - decoding

SWL2 - Adbash cipher

SWL3 - Vernam cipher

SWL4 - Caesar cipher

SW[0:7] - sets 0 or 1 on individual digits

Ja-Pins(1) - serves to connect the board and the computer using the 6Pin USB TTL UART converter

![vlastní zapojení](https://github.com/Karelabiss/VHDL_DE1_FEKT_Cipher/blob/main/img/zapojenie%20dosky.png)

Since we're writing letters in binary code, the ASCII table will come in handy.

<img src="https://github.com/Karelabiss/VHDL_DE1_FEKT_Cipher/blob/main/img/ASCII.png" width="700" height="400"/>



## Video

[Videosák](https://youtu.be/R-h31Xu8xJs?si=o2DK031GZXZFYlqp)

## Tools and References
[Vivado Design Suite](https://www.xilinx.com/products/design-tools/vivado.html)

[VHDPlus](https://vhdplus.com/)

[Nexys A7 reference manual](https://digilent.com/reference/programmable-logic/nexys-a7/reference-manual)

[GTKWave](https://gtkwave.sourceforge.net/)

[VHDL testbench generator](https://vhdl.lapinoo.net/testbench/)

[Draw.io](https://www.drawio.com/)


Digital Electronics Lectures presentation by Tomas Fryza
