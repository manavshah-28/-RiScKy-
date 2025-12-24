/*/////////////////////////////////////////////
 File: Instruction_Memory.sv
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

module Instruction_memory(rst,A,RD);

input rst;
input [31:0]A;

output [31:0]RD;

int instr_count;

logic [31:0]mem[1023:0];

assign RD = (rst == 1'b0) ? {32{1'b0}} : mem[A[31:2]];

initial begin
    $readmemh("hex/load_store.hex",mem, 0,1023);
    // Count until first uninitialized word
    for (int i = 0; i < 1024; i++) begin
        if (mem[i] !== 32'hx)
            instr_count++;
        else
            break;
    end
end

//test purposes
/*initial begin
mem[0]=32'h002082B3;
mem[4]=32'h005182B3;
mem[8]=32'h005202B3;
end*/

endmodule