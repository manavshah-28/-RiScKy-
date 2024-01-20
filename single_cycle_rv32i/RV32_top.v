`include "PC.v"
`include "PC_adder.v"
`include "Instruction_memory.v"
`include "Regfile.v"
`include "ALU.v"
`include "Controller.v"

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

wire Controller_WE;
wire Controller_ALU;
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
                .WE(Controller_WE),
                .AddD(Instr[11:7]), // [11:7] = rd 
                .DataD(ALU_res),
                .AddA(Instr[19:15]), // [19:15] = rs1
                .DataA(ALU_in1),
                .AddB(Instr[24:20]), // [24:20] = rs2
                .DataB(ALU_in2));

ALU ALU(.A(ALU_in1),
        .B(ALU_in2),
        .control(Controller_ALU),
        .ALU_result(ALU_res));

Controller controller(.instr(Instr),
                      .opcode(Instr[6:0]),
                      .rs1(Instr[19:15]),
                      .rs2(Instr[24:20]),
                      .rd(Instr[11:7]),
                      .funct3(Instr[14:12]),
                      .funct7(Instr[31:25]),
                      .RegWE(Controller_WE),
                      .ALU_control(Controller_ALU));

endmodule
