`include "PC.v"
`include "PC_adder.v"
`include "Instruction_memory.v"
`include "Regfile.v"
`include "ALU.v"

module RV32_top(clk,rst);

input clk,rst;
reg write = 1;
//reg [31:0] instr;
//wire instantiations
wire [31:0] PC_Top;
wire [31:0] PCP4_Top;
wire [31:0] Instr;

wire[31:0] ALU_in1;
wire[31:0] ALU_in2;
wire[31:0] ALU_res;
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
                .WE(write),
                .AddD(Instr[11:7]), // [11:7] = rd 
                .DataD(ALU_res),
                .AddA(Instr[19:15]), // [19:15] = rs1
                .DataA(ALU_in1),
                .AddB(Instr[24:20]), // [24:20] = rs2
                .DataB(ALU_in2));

ALU ALU(.A(ALU_in1),
        .B(ALU_in2),
        .ALU_result(ALU_res));


endmodule
