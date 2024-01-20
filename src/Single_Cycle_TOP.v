`include "PC.v"
`include "instr_mem.v"
`include "register_file.v"
`include "extend.v"
`include "alu.v"
`include "control_unit_Top.v"
`include "data_memory.v"
`include "PC_adder.v"

module Single_Cycle_TOP(clk,rst);

input clk,rst;
wire [31:0] PC_Topp;
wire [31:0] RD_Instr;
wire [31:0]RD1_Top;
wire [31:0]ImmExt_top;
wire [31:0]ALUResult;
wire regwrite;
wire [31:0]ReadData;
wire [31:0]PC_Top,PCPlus4;
wire [2:0]ALUControl_top;
PCounter PCOUNTER(.clk(clk),
              .rst(rst),
              .PC(PC_Topp),
              .PC_Nxt(PCPlus4));

Instruction_memory Instr_mem(.rst(rst),
                             .A(PC_Topp),
                             .RD(RD_Instr));

regsiter_file regfile(.clk(clk),
                      .rst(rst),
                      .WE3(RegWrite),
                      .WD3(ReadData),
                      .A1(RD_Instr[19:15]), // giving rs1 to A1
                      .A2(),
                      .A3(RD_Instr[11:7]),
                      .RD1(RD1_Top),
                      .RD2());

extend extend(.instr(RD_Instr),
              .ImmExt(ImmExt_top));

ALU alu(.A(RD1_Top),
        .B(ImmExt_top),
        .ALUControl(ALUControl_top), 
        .Result(ALUResult),
        .V(),
        .C(),
        .Z(),
        .N());
        
Control_unit_top control_top(.op(RD_Instr[6:0]),
                             .RegWrite(regwrite),
                             .ImmSrc(),
                             .ALUSrc(),
                             .MemWrite(),
                             .ResultSrc(),
                             .branch(),
                             .funct3(RD_Instr[14:12]),
                             .funct7(),
                             .ALUControl(ALUControl_top));

data_memory data_memr(.clk(clk),
                      .A(ALUResult),
                      .WD(),
                      .WE(regwrite),
                      .RD(ReadData));

PC_Adder adder(.a(PC_Topp),
               .b(32'd4),
               .c(PCPlus4));



endmodule