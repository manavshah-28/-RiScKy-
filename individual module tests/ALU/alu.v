module ALU(A,B,ALUControl, Result,V,C,Z,N);

input [31:0] A,B;
input [2:0] ALUControl;

output [31:0] Result;

// flags
// oVerflow, // Carry // Negative // Zero
output V,C,Z,N;

// declaring internals
wire [31:0] a_and_b;
wire [31:0] a_or_b;
wire [31:0] not_b;
wire [31:0] mux_1;
wire [31:0] sum;
wire [31:0] mux_2;
wire cout;

//Logical Operations
assign a_and_b = A & B;
assign a_or_b = A | B;
assign not_b = ~B;

assign mux_1 = (ALUControl[0] == 1'b0) ? B : not_b;
assign {cout,sum} = A + mux_1 + ALUControl[0];
// cout is concatenated with sum. 
assign mux_2 = (ALUControl[1:0] == 2'b00) ? sum :
               (ALUControl[1:0] == 2'b01) ? sum :
               (ALUControl[1:0] == 2'b10) ? a_and_b : a_or_b;

assign Result = mux_2;

//FLAG Assignment
// generate zero flag: A -> ~A -> &(~A)
assign Z = &(~Result);
assign N = Result[31];
assign C = cout & (~ALUControl[1]);

assign V = (~ALUControl[1]) & (A[31] ^ sum[31]) & (~(A[31] ^ B[31] ^ ALUControl[0]));

endmodule