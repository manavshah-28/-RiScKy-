/*/////////////////////////////////////////////
 File: RV32I.v
 Author: Manav Shah
 ----------------------------------------------

    ██████╗ ██╗███████╗ ██████╗██╗  ██╗██╗   ██╗
    ██╔══██╗██║██╔════╝██╔════╝██║ ██╔╝╚██╗ ██╔╝
    ██████╔╝██║███████╗██║     █████╔╝  ╚████╔╝ 
    ██╔══██╗██║╚════██║██║     ██╔═██╗   ╚██╔╝  
    ██║  ██║██║███████║╚██████╗██║  ██╗   ██║   
    ╚═╝  ╚═╝╚═╝╚══════╝ ╚═════╝╚═╝  ╚═╝   ╚═╝   
 ----------------------------------------------
                                    
 Copyright (c) 2024 MANAV SHAH
*//////////////////////////////////////////////

`include "PC.v"
`include "PC_adder.v"
`include "mux.v"
`include "Regfile.v"
`include "Instruction_Memory.v"
`include "ALU.v"
`include "Imm_Gen.v"
`include "branch_comp.v"
`include "Data_mem.v"
`include "RV32_Controller.v"

module RV32I(clk,rst);

input clk,rst;

//wires
wire [31:0]PC_out;
wire [31:0]PC_in;

wire [31:0]PC_4;

wire [31:0]alu;

wire [31:0]reg_DataA;
wire [31:0]reg_DataB;

wire [31:0]immediate;

wire [31:0]alu_in1;
wire [31:0]alu_in2;


wire [31:0]DataR; // Data memory output

wire [31:0]wb;

// Instruction
wire [31:0]Instr;

// control signal wires
wire PCSel;
wire RegWEn;
wire ASel;
wire BSel;
wire [3:0]ALUSel;
wire [2:0]ImmSel;
wire BrUn;
wire MemRW;
wire [1:0]WBSel;

wire BrEq,BrLt;

mux muxPC(.a(PC_4),
          .b(alu),
          .c(PC_in),
          .sel(PCSel));

PC PC_Top(.clk(clk),
          .rst(rst),
          .PC(PC_out),
          .PCP4(PC_in));

PC_adder PCPlus4Top(.PC_add(PC_out),
                    .PCP4_add(PC_4));

Instruction_memory imem(.rst(rst),
                   .A(PC_out),
                   .RD(Instr));

Regfile regfile(.clk(clk),
        .rst(rst),
        .WE(RegWEn),
        .AddD(Instr[11:7]),
        .DataD(wb),
        .AddA(Instr[19:15]),
        .DataA(reg_DataA),
        .AddB(Instr[24:20]),
        .DataB(reg_DataB));

mux muxA(.a(reg_DataA),
         .b(PC_out),
         .c(alu_in1),
         .sel(ASel));

mux muxB(.a(reg_DataB),
         .b(immediate),
         .c(alu_in2),
         .sel(BSel));

ALU ALU_Top(.A(alu_in1),
            .B(alu_in2),
            .control(ALUSel),
            .ALU_result(alu));

Imm_Gen Imm_Gen(.Instr(Instr),
                .ImmSel(ImmSel),
                .immediate(immediate));

branch_comp branch_comp(.A(reg_DataA),
                        .B(reg_DataB),
                        .BrUn(BrUn),
                        .BrEq(BrEq),
                        .BrLt(BrLt));

Data_mem Data_mem(.clk(clk),
                  .A_mem(alu),
                  .DataIP(reg_DataB),
                  .MemRW(MemRW),
                  .D_read(DataR)); 

mux3 mux3(.a(DataR),
          .b(alu),
          .c(PC_4),
          .d(wb),
          .sel(WBSel));

RV32_Controller Controller(.i_instuction(Instr), 
                           .BrEq(BrEq), 
                           .BrLt(BrLt),
                           .PCSel(PCSel), 
                           .ImmSel(ImmSel), 
                           .BrUn(BrUn), 
                           .ASel(ASel), 
                           .BSel(BSel), 
                           .ALUSel(ALUSel), 
                           .MemRW(MemRW), 
                           .RegWEn(RegWEn), 
                           .WBSel(WBSel));

endmodule