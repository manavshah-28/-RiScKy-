module immediate_gen(inst_imm,imm);

input [11:0] inst_imm;
output [31:0] imm;

assign imm = (inst_imm[11] == 1'b1) ? {{20{1'b1}},inst_imm[11:0]} : {{20{1'b0}},inst_imm[11:0]};

endmodule