module Regfile(clk,rst,WE,AddD,DataD,AddA,DataA,AddB,DataB);
input clk,rst,WE;
input [4:0] AddA,AddB,AddD;
input [31:0] DataD;
/*
rst: is reset signal(active low).
WE: is Write Enable signal.
AddA,AddB : registers are read at these addresses
and read values are given out at DataA and DataB respectively.
AddD : is the address for the register which is to be written with DataD.
*/
output [31:0] DataA,DataB;

reg [31:0] xreg [31:0]; //x0 to x31 : RV32 registers

initial begin
    xreg[0] = 32'h00000000;
    xreg[1] = 32'h00000000;
    xreg[2] = 32'h00000001;
    xreg[3] = 32'h00000002;
    xreg[4] = 32'h00000003;
    xreg[5] = 32'h00000000;
end

always @(posedge clk)begin
   if(WE &(AddD != 5'h00))
       xreg[AddD] <= DataD;  
end

assign DataA = (rst == 1'b0) ? 32'h00000000 : xreg[AddA];
assign DataB = (rst == 1'b0) ? 32'h00000000 : xreg[AddB];

endmodule

