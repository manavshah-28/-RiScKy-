`include "PC.v"
`include "instr_mem.v"
`include "register_file.v"
`include "extend.v"

module Single_Cycle_TOP(clk,rst);

input clk,rst;
wire [31:0] PC_Top;
wire [31:0] RD_Instr;

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
                      .RD1(),
                      .RD2());

extend extend(.instr(RD_Instr),
              .ImmExt())
endmodule