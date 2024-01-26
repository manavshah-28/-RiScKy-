module Imm_Gen(Instr,ImmSel,immediate);

input [31:0]Instr;
input [2:0]ImmSel;

output [31:0]immediate;

/* 
ImmSel
0       nothing
1       I type
2       S type 
3       B type 
*/

assign immediate = (ImmSel == 3'b001 & Instr[31] == 1'b0) ? {{20{1'b0}},Instr[31:20]} :  // I type immediate 
                   (ImmSel == 3'b001 & Instr[31] == 1'b1) ? {{20{1'b1}},Instr[31:20]} :  // consider sign extension of most signifiacnt bit ie. bit 31 here
                   (ImmSel == 3'b010 & Instr[31] == 1'b0) ? {{20{1'b0}},Instr[31:25],Instr[11:7]} : // S type immediate 
                   (ImmSel == 3'b010 & Instr[31] == 1'b1) ? {{20{1'b1}},Instr[31:25],Instr[11:7]} : 
                   (ImmSel == 3'b011 & Instr[31] == 1'b0) ? {{20{1'b0}},Instr[31],Instr[7],Instr[30:25],Instr[11:8]} : // B type immediate 
                   (ImmSel == 3'b011 & Instr[31] == 1'b1) ? {{20{1'b1}},Instr[31],Instr[7],Instr[30:25],Instr[11:8]} : 
                   32'h00000000;

endmodule