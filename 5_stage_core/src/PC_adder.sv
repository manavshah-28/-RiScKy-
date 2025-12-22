/*/////////////////////////////////////////////
 File: PC_adder.sv
 Author: Manav Shah
 ----------------------------------------------

    ██████╗ ██╗███████╗ ██████╗██╗  ██╗██╗   ██╗
    ██╔══██╗██║██╔════╝██╔════╝██║ ██╔╝╚██╗ ██╔╝
    ██████╔╝██║███████╗██║     █████╔╝  ╚████╔╝ 
    ██╔══██╗██║╚════██║██║     ██╔═██╗   ╚██╔╝  
    ██║  ██║██║███████║╚██████╗██║  ██╗   ██║   
    ╚═╝  ╚═╝╚═╝╚══════╝ ╚═════╝╚═╝  ╚═╝   ╚═╝   
 ----------------------------------------------
                                    
 Copyright (c) 2025 MANAV SHAH
*//////////////////////////////////////////////

module PC_adder(clk,rst,PC_add,PCP4_add);

input clk, rst;
input [31:0]PC_add;

output logic [31:0]PCP4_add;

always @(posedge clk or negedge rst)begin
if(!rst)begin
PCP4_add <= '0;
end
else begin
PCP4_add <= PC_add + 32'd4;
end
end

endmodule