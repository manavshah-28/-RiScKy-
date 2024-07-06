# RV32I core design
![alt text](</docs/images/RiScKy banner.png>)  

## Table of contents
<!-- TOC -->

- [RV32I core design](#rv32i-core-design)
  - [Table of contents](#table-of-contents)
  - [Objectives](#objectives)
  - [Datapath](#datapath)
  - [Supported Instructions (RV32I base instruction set)](#supported-instructions-rv32i-base-instruction-set)
  - [Tech stack](#tech-stack)
  - [Controller Design](#controller-design)
- [Yosys](#yosys)
  - [Using Yosys](#using-yosys)
    - [diagram created by YOSYS](#diagram-created-by-yosys)

<!-- /TOC -->

## Objectives
- [x] Study RV32I Instruction Set architecture.
- [x] Design Datapth for single Cycle RV32I processor. (verilog).
- [x] Design Controller.
- [x] Design GUI for interfacing with data memory, registers and instruction hex files.
- [x] Verify individual instructions with targeted assembly tests.
- [ ] understand verilator.
- [ ] understand makefiles.
- [ ] study other cores for grasping these concepts to move from verilog rtl to verification.
- [ ] Achieve complete RISCV compliance.

## Datapath   
![Alt text](</docs/images/-RiScKy-.jpg>)

## Supported Instructions (RV32I base instruction set)
* [x] add,sub,sll,slt,sltu,xor,srl,sra,or,and
* [x] addi,slti,sltiu,xori,ori,andi,slli,srli,srai
* [x] lb,lh,lw,lbu,lhu
* [x] sb,sh,sw
* [x] beq,bne,blt,bge,bltu,bgeu
* [x] jal, jalr
* [x] lui, auipc
* [ ] fence,ecall,ebreak 
  
## Tech stack
* Iverilog
* Gtkwave
* Verilog HDL
* Python
* Git/Github
* VS Code
* Yosys
* Graphviz
  
## Controller Design
![alt text](</docs/images/controller_design.jpeg>)


# Yosys

* install [yosys](https://github.com/YosysHQ/yosys) 
* windows exe of [yosys](https://github.com/YosysHQ/oss-cad-suite-build/releases/download/2024-04-08/oss-cad-suite-windows-x64-20240408.exe)

## Using Yosys

* press start in windows
* open command prompt
* go to the directory where your verilog files are stored
* ```<extracted_location>\oss-cad-suite\environment.bat```
* This will open up OSS CAD Suite
* ```yosys```
* This opens yosys
* ![alt text](/docs/images/yosys1.png)
* Now enter the command ```read_verilog RV32I.v```
* ![alt text](/docs/images/yosys2.png)
* Next enter ```show RV32I```
* ![alt text](/docs/images/yosys3.png)
* Install [Graphviz](https://gitlab.com/api/v4/projects/4207231/packages/generic/graphviz-releases/10.0.1/windows_10_cmake_Release_graphviz-install-10.0.1-win64.exe)
* Open another command prompt terminal and navigate to the same directory
* Enter the command ```dot -Tpng show.dot > output.png```
* This will make a png image of your design with the name output.png

### diagram created by YOSYS  
![alt text](/docs/images/yosys/output.png)