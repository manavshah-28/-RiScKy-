`include "PC.v"
`include "PC_adder.v"
`include "Instruction_memory.v"
`include "Regfile.v"

module RV32_top(clk,rst);

input clk,rst;

//reg [31:0] instr;
//wire instantiations
wire [31:0] PC_Top;
wire [31:0] PCP4_Top;
wire [31:0] Instr;

//module instantiations
PC PC(.clk(clk),
      .rst(rst),
      .PC(PC_Top),
      .PCP4(PCP4_Top));

PC_adder PC_adder(.PC_add(PC_Top),
                  .PCP4_add(PCP4_Top));

Instruction_memory Instruction_memory(.rst(rst),
                                      .A(PC_Top),
                                      .RD(Instr));

Regfile regfile(.clk(clk),
                .rst(rst),
                .WE(),
                .AddD(Instr[11:7]), // [11:7] = rd 
                .DataD(),
                .AddA(Instr[19:15]), // [19:15] = rs1
                .DataA(),
                .AddB(Instr[24:20]), // [24:20] = rs2
                .DataB());


endmodule
