module mux(a,b,c,sel);

input [31:0]a,b;
input sel;

output [31:0]c;

assign c = (sel == 1'b1) ? b : a;

endmodule