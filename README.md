# What is This?
This repository is an implementation of an 8-Bit CPU, Assembly language for it and some for of higher level language compiler tools.

# Phases of work
This project is under active development. Split into various phases, the progress of which is as below:

## 1. CPU Design
Current activities are focused around building the control and data path. At the moment only the RAM is available as part of the source. Development will be around:
- Memory
- Control Path
- Data Path
- Turing complete ISA design [minimalistic]

## 2. Assembler Design
Parked until ISA design is complete.

## 3. Compiler Design
Parked until Assembler architecture is frozen.

# Usage
## Adding access to the JTAG
You obviously need the DE1-SOC board from Altera/Intel. If you are using linux, do the following on first time usage:

create the file: */etc/udev/rules.d/51-usbblaster.rules* and add to it the following lines:
```
SUBSYSTEM==”usb”, ATTR{idVendor}==”09fb”, ATTR{idProduct}==”6001″, MODE=”0666″
SUBSYSTEM==”usb”, ATTR{idVendor}==”09fb”, ATTR{idProduct}==”6002″, MODE=”0666″
SUBSYSTEM==”usb”, ATTR{idVendor}==”09fb”, ATTR{idProduct}==”6003″, MODE=”0666″
SUBSYSTEM==”usb”, ATTR{idVendor}==”09fb”, ATTR{idProduct}==”6010″, MODE=”0666″
SUBSYSTEM==”usb”, ATTR{idVendor}==”09fb”, ATTR{idProduct}==”6810″, MODE=”0666″
```
If you are not able to save the file please make sure that you are in the superuser mode.

# Compiling the source
Open a terminal in the source directory and simple execute
```
make all
```

This will compile the verilog source and output a .sof file in the *output_files* directory. To upload the compiled binary to the FPGA execute:
```
make upload
```

To clean the workspace execute:
```
make clean
```

# Side note
On successful compilation the build system also generates a Quartus Prime Project which can be opened in Quartus prime. This shall be usefule if you want to use the GUI for operations like Pin panning or any other optimization.

As noted above, the build system generates a netlist for Intel Cyclone V based DE1 SOC board. The Source files may however be used to build for other FPGA variantsfrom same or different vendors in which case the build tools and settings would have to be changed accordingly.

# License
MIT License