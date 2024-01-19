`include "PC.v"
`include "instr_mem.v"
`include "register_file.v"
`include "extend.v"
`include "alu.v"
`include "control_unit_Top.v"

module Single_Cycle_TOP(clk,rst);

input clk,rst;
wire [31:0] PC_Top;
wire [31:0] RD_Instr;
wire [31:0]RD1_Top;
wire [31:0]ImmExt_top;

Prog_Count PC(.clk(clk),
              .rst(rst),
              .PC(PC_Top),
              .PC_Nxt());

Instruction_memory Instr_mem(.rst(rst),
                             .A(PC_Top),
                             .RD(RD_Instr));

regsiter_file regfile(.clk(clk),
                      .rst(rst),
                      .WE3(),
                      .WD3(),
                      .A1(RD_Instr[19:15]), // giving rs1 to A1
                      .A2(),
                      .A3(),
                      .RD1(RD1_Top),
                      .RD2());

extend extend(.instr(RD_Instr),
              .ImmExt(ImmExt_top);

ALU alu(.A(RD1_Top),
        .B(ImmExt_top),
        .ALUControl(), 
        .Result(),
        .V(),
        .C(),
        .Z(),
        .N());
        
Control_unit_top control_top(.Op(RD_Instr[6:0]),
                             .RegWrite(),
                             .ImmSrc(),
                             .ALUSrc(),
                             .MemWrite(),
                             .ResultSrc(),
                             .branch(),
                             .funct3(RD_Instr[14:12]),
                             .funct7(),
                             .ALUControl());


endmodule