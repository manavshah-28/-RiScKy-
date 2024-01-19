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
// slt takes only the most signifiacant bit
wire [31:0]slt; // set less than (N-1 zero extended to 32 bits).
//Logical Operations
assign a_and_b = A & B;
assign a_or_b = A | B;
assign not_b = ~B;

assign mux_1 = (ALUControl[0] == 1'b0) ? B : not_b;
assign {cout,sum} = A + mux_1 + ALUControl[0];
assign slt = {31'b0000000000000000000000000000000,sum[31]};

// cout is concatenated with sum. 
assign mux_2 = (ALUControl[2:0] == 3'b000) ? sum :
               (ALUControl[2:0] == 3'b001) ? sum : // this is subtraction
               (ALUControl[2:0] == 3'b010) ? a_and_b : 
               (ALUControl[2:0] == 3'b011) ? a_or_b : 
               (ALUControl[2:0] == 3'b101) ? slt : 32'h00000000;

assign Result = mux_2;

//FLAG Assignment
// generate zero flag: A -> ~A -> &(~A)
assign Z = &(~Result);
assign N = Result[31];
assign C = cout & (~ALUControl[1]);
assign V = (~ALUControl[1]) & (A[31] ^ sum[31]) & (~(A[31] ^ B[31] ^ ALUControl[0]));

endmodule