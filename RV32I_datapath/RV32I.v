`include "PC.v"
`include "PC_adder.v"
`include "mux.v"
`include "Regfile.v"
`include "Instruction_Memory.v"
`include "ALU.v"

module RV32I(clk,rst);

input clk,rst;

//wires
wire [31:0]PC_out;
wire [31:0]PC_in;

wire [31:0]PC_4;

wire [31:0]alu;

wire [31:0]reg_DataD;

wire [31:0]reg_DataA;
wire [31:0]reg_DataB;

wire [31:0]immediate;

wire [31:0]alu_in1;
wire [31:0]alu_in2;

// Instruction
wire [31:0]Instr;

// control signal wires
wire PCSel = 0;
wire RegWEn = 1;
wire ASel;
wire BSel;
wire ALUSel;

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
        .DataD(reg_DataD),
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


endmodule