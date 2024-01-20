`include "PC.v"
`include "PC_adder.v"

module RV32_top(clk,rst);

input clk,rst;

//wire instantiations
wire [31:0]PC_Top;
wire [31:0] PCP4_Top;
//module instantiations
PC PC(.clk(clk),
      .rst(rst),
      .PC(PC_Top),
      .PCP4(PCP4_Top));

PC_adder PC_adder(.PC_add(PC_Top),
                  .PCP4_add(PCP4_Top));


endmodule
