/*/////////////////////////////////////////////
 File: core.sv
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

parameter XLEN = 32;
parameter ILEN = 32;

module core(
input clk,
input rst
);

// registers
logic [XLEN-1:0] PC_reg_F;
logic [XLEN-1:0] PC_reg_D;
logic [XLEN-1:0] PC_reg_E;

logic [ILEN-1:0] INSTR_reg_F;
logic [ILEN-1:0] INSTR_reg_D;
logic [ILEN-1:0] INSTR_reg_E;
logic [ILEN-1:0] INSTR_reg_M;

logic [XLEN-1:0] RD1_reg_D;

logic [XLEN-1:0] RD2_reg_D;
logic [XLEN-1:0] RD2_reg_E;


logic [XLEN-1:0] IMM_reg_D;

logic [XLEN-1:0] ALU_Out_reg_E;
logic [XLEN-1:0] ALU_Out_reg_M;

logic [XLEN-1:0] PC4_reg_M;

logic [XLEN-1:0] Mem_reg_M;

// wires
logic [XLEN-1:0] w_PCP4;
logic [XLEN-1:0] w_ALU_Out_reg_E;
logic [XLEN-1:0] w_PC_in;
logic [XLEN-1:0] w_PC_out;
logic w_PC_Sel_M;

logic [ILEN-1:0] w_instr_F;

// __________________________________________________________________________
// Module Connections
// __________________________________________________________________________

// FETCH
mux mux_enter_PC_F(
    .a(w_PCP4),
    .b(w_ALU_Out_reg_E),
    .c(w_PC_in),
    .sel(w_PC_Sel_M)
);

PC PC_F(
    .clk(clk),
    .rst(rst),
    .PCP4(w_PC_in),
    .PC(w_PC_out)
);

PC_adder adder(
    .PC_in(w_PC_out),
    .PCP4_out(w_PCP4)
);

Instruction_memory imem(
    .rst(rst),
    .A(w_PC_out),
    .RD(w_instr_F)
);

// DECODE

// EXECUTE

// MEMORY ACCESS

// WRITE BACK


// __________________________________________________________________________
// Sequential Logic (Always Flip Flops for registers)
// __________________________________________________________________________

// FETCH
always @(posedge clk or negedge rst)begin
if(!rst)begin
PC_reg_F <= 0;
INSTR_reg_F <= 0;
end
else begin
PC_reg_F <= w_PC_out;
INSTR_reg_F <= w_instr_F;
end
end
// DECODE

// EXECUTE

// MEMORY ACCESS

// WRITE BACK
endmodule