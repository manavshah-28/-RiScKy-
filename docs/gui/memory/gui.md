
## GUI for Registers & Data Memory 

### Problem
* The registers [x0 to x31] in RV32 ISA are loaded with data to be operated upon. This is the internal memory of the Processor.
* For testing or simulation, these registers were required to be manually entered and initiated in the Verilog code which was a tedious task.

### Solution
* I have developed a Python based Graphical user interface and changed the way the register files are loaded and initialized in the verilog code.
* The verilog code now uses the $readmemh function to read a reg_load.hex file into all 32 registers.
* The reg_load.hex file is generated by the GUI by default in the following manner:
```
@00000000
00000000
00000000
00000000
.
.
.
00000000
```
* This is the default file format.
* The @00000000 shows the starting address of the instructions.
* The next line is the data to be entered into the x0 register, the 2nd line is entered in the x1 register and so on...
* When the python GUI is run, you get a window popup as follows: 
* ![Alt text](/getting_started/images/gui.png)
* The register configuration can be done from this terminal, and the saved file should be in the main directory where all the verilog modules of the core are loacted.
* The name of the file should always be "reg_load.hex" since that is programmed in the verilog file for registers.
* The file generated when 2 -> x2 and 3-> x3 is as follows 
```
@00000000
00000000
00000000
00000002
00000003
00000000
00000000
``` 