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

logic w_RegWEn;
logic [XLEN-1:0] w_mux3_out_W;

logic [XLEN-1:0] w_DataA;
logic [XLEN-1:0] w_DataB;
logic [XLEN-1:0] w_ImmSel_D;
logic [XLEN-1:0] w_Immediate_D;

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

Regfile regfile(
    .clk(clk),
    .rst(rst),
    .WE(w_RegWEn),
    .AddA(INSTR_reg_F[19:15]),
    .AddB(INSTR_reg_F[24:20]),
    .AddD(INSTR_reg_M[11:7]),
    .DataD(w_mux3_out_W),
    //
    .DataA(w_DataA),
    .DataB(w_DataB) 
);

Imm_Gen immediate_gen(
    .Instr(INSTR_reg_F),
    .ImmSel(w_ImmSel_D),
    .immediate(w_Immediate_D)
);

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
always @(posedge clk or negedge rst)begin
if(!rst)begin
PC_reg_D <= 0;
RD1_reg_D <= 0;
RD2_reg_D <= 0;
IMM_reg_D <= 0;
INSTR_reg_D <= 0;
end
else begin
PC_reg_D <= PC_reg_F;
RD1_reg_D <= w_DataA;
RD2_reg_D <= w_DataB;
IMM_reg_D <= w_Immediate_D;
INSTR_reg_D <= INSTR_reg_F;
end
end
// EXECUTE
always @(posedge clk or negedge rst)begin
if(!rst)begin
end
else begin
end
end
// MEMORY ACCESS
always @(posedge clk or negedge rst)begin
if(!rst)begin
end
else begin
end
end
// WRITE BACK
always @(posedge clk or negedge rst)begin
if(!rst)begin
end
else begin
end
end

endmodule