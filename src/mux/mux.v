module mux(i_A,i_B,i_sel,o_C);

input i_A,i_B;
input i_sel;
output o_C;

assign o_C= i_sel?i_A:i_B; // if i_sel = 1 then o_C = i_A, else = i_B

endmodule