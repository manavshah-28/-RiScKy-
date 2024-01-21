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
    xreg[2] = 32'h00000000;
    xreg[3] = 32'h00000000;
    xreg[4] = 32'h00000000;
    xreg[5] = 32'h00000000;
    xreg[6] = 32'h00000000;
    xreg[7] = 32'h00000000;
    xreg[8] = 32'h00000000;
    xreg[9] = 32'h00000000;
    xreg[10] = 32'h00000000;
    xreg[11] = 32'h00000000;
    xreg[12] = 32'h00000000;
    xreg[13] = 32'h00000000;
    xreg[14] = 32'h00000000;
    xreg[15] = 32'h00000000;
    xreg[16] = 32'h00000000;
    xreg[17] = 32'h00000000;
    xreg[18] = 32'h00000000;
    xreg[19] = 32'h00000000;
    xreg[20] = 32'h00000000;
    xreg[21] = 32'h00000000;
    xreg[22] = 32'h00000000;
    xreg[23] = 32'h00000000;
    xreg[24] = 32'h00000000;
    xreg[25] = 32'h00000000;
    xreg[26] = 32'h00000000;
    xreg[27] = 32'h00000000;
    xreg[28] = 32'h00000000;
    xreg[29] = 32'h00000000;
    xreg[30] = 32'h00000000;
    xreg[31] = 32'h00000000;
end

always @(posedge clk)begin
   if(WE &(AddD != 5'h00))
       xreg[AddD] <= DataD;  
end

assign DataA = (rst == 1'b0) ? 32'h00000000 : xreg[AddA];
assign DataB = (rst == 1'b0) ? 32'h00000000 : xreg[AddB];

endmodule

