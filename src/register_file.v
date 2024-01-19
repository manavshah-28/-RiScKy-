module regsiter_file(clk,rst,WE3,WD3,A1,A2,A3,RD1,RD2);

input clk,rst;
input WE3;   // write enable
input [4:0] A1, A2, A3;  // 5 bit input addresses

input [31:0] WD3; //32 bit input data

output [31:0] RD1,RD2; // 32 bit output data
// RD1 is the data read from address A1 of the register
// RD2 is the data read from address A2 of the register

// WD3 is the data to be written into the register
// A3 is the addresss where the data is to be written

reg [31:0] Register[31:0]; // x0 to x31 : The RV32 registers

always @(posedge clk)begin
    
    if(WE3 & (A3 != 5'h00))
       Register[A3] <= WD3;

end

assign RD1 = (rst == 1'b0) ? 32'b0 : Register[A1];
assign RD2 = (rst == 1'b0) ? 32'b0 : Register[A2];

initial begin
 Register[0] = 32'h00000000;
end

endmodule