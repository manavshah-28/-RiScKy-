`include "ALU_decoder.v"
`include "main_decoder.v"

module Control_unit_top(Op,RegWrite,ImmSrc,ALUSrc,MemWrite,ResultSrc,branch,funct3,funct7,ALUControl);

input [6:0]op,funct7;
input [2:0]funct3;

output RegWrite,ALUSrc,MemWrite,ResultSrc,branch;
output [1:0]ImmSrc;
output [2:0]ALUControl;

wire[1:0]ALUOp;

main_decoder main_decoder(.op(Op),
                          .zero(),
                          .RegWrite(RegWrite), 
                          .MemWrite(MemWrite), 
                          .ResultSrc(ResultSrc), 
                          .ALUSrc(ALUSrc), 
                          .ImmSrc(ImmSrc), 
                          .ALUOp(ALUOp), 
                          .PCSrc());
                        
ALU_decoder ALU_decoder(.ALUOp(ALUOp),
                        .op(op),
                        .funct3(funct3), 
                        .funct7(funct7), 
                        .ALUControl(ALUControl));

endmodule