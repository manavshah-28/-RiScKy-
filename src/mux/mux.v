module mux(i_A,i_B,i_sel,o_C);

input [31:0]i_A,i_B;
input i_sel;
output [31:0]o_C;

assign o_C= (~i_sel) ? i_A:i_B; // if i_sel = 0 then o_C = i_A, else = i_B

endmodule

module mux3_1(a,b,c,s,out31);

input [31:0]a,b,c;
input [1:0]s;

output [31:0]out31;

assign out31 =  (s == 2'b00) ? a : (s == 2'b01) ? b : (s == 2'b10) ? c : 32'b0;

endmodule