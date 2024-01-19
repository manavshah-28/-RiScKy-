module extend(instr,ImmExt)
input [31:0]instr; // takes the 31 to 20th bits, check if 31st bit is 1 or 0 and sign extend
output [31:0]Imm_Ext;

assign ImmExt = (instr[31] == 1'b1) ? {20{1'b1},instr[31:20]} : {20{1'b0},instr[31:20]}; // sign extension
endmodule