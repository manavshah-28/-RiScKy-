module main_decoder(op,zero,RegWrite, MemWrite, ResultSrc, ALUSrc, ImmSrc, ALUOp, PCSrc);

input zero; // this is the zero wire flag from the ALU
input [6:0] op;  // opcode

output RegWrite, MemWrite, ResultSrc, ALUSrc, PCSrc;
output [1:0] ImmSrc, ALUOp;

//internal wires
wire branch;


assign RegWrite = ((op == 7'b 0000011) | (op = 7'b 0110011)) ? 1'b1 : 1'b0;
//                 load word opcode       R Type Instruction   you have to write registers
assign MemWrite = (op = 7'b0100011) ? 1'b1 : 1'b0;
//                 Store word       The only place when you have to write to memory
assign ResultSrc = (op = 7'b0000011) ? 1'b1 : 1'b0;
//                  Load word 
assign ALUSrc = ((op == 7'b 0000011) | (op = 7'b 0100011)) ? 1'b1 : 1'b0;
//                 Load word             Store Word
assign branch = (op == 7'b1100011) ? 1'b1 : 1'b0;

assign ImmSrc = (op == 7'b0100011) ? 2'b 01 : (op = 7'b1100011) ? 2'b10 : 2'b00;

assign ALUOp = (op = 7'b0110011) ? 2'b10 : (op = 7'b1100011) ? 2'b01 : 2'b00;

assign PCSrc = zero & branch;

endmodule
