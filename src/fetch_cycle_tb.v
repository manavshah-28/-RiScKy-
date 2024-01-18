`timescale 1ps/1ps
`include "fetch_cycle.v"

module fetch_cycle_tb;

initial begin
   $dumpfile("fetch_cycle_tb.vcd");
   $dumpvars(0,fetch_cycle_tb);


   $display(" ### EOD ###");
end
endmodule