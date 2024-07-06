`timescale 1ps/1ps
`include "mux.v"

module mux_tb;

reg i_A;
reg i_B;
reg i_sel;

wire o_C;

mux dut(i_A,i_B,i_sel,o_C);

initial begin

$dumpfile("mux_tb.vcd");
$dumpvars(0,mux_tb);

    i_A=0;
    i_B=1;
    i_sel=0;
    #10;

    i_sel=1;
    #10;

    i_A=1;
    i_B=0;
    #10

    $display("End of Test");

end

endmodule