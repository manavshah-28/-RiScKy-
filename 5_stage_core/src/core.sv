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

module core(
    input clk,
    input rst
);

//logics
logic [31:0]PC_out;
logic [31:0]PC_in;

logic [31:0]PC_4;

logic [31:0]alu;

logic [31:0]reg_DataA;
logic [31:0]reg_DataB;

logic [31:0]immediate;

logic [31:0]alu_in1;
logic [31:0]alu_in2;


logic [31:0]DataR; // Data memory output

logic [31:0]wb;

// Instruction
logic [31:0]Instr;

// control signal logics
logic PCSel;
logic RegWEn;
logic ASel;
logic BSel;
logic [3:0]ALUSel;
logic [2:0]ImmSel;
logic BrUn;
logic MemRW;
logic [1:0]WBSel;
logic BrEq,BrLt;


logic [31:0] FD_instr;
logic [31:0] FD_PC_out_reg;
logic [31:0] FD_PC_4_reg;

logic [31:0] EM_alu_reg;
logic [31:0] EM_PC_4_reg;
logic EM_MemRW_reg;
logic [1:0] EM_WBSel_reg;
logic EM_PCSel_reg;
logic [31:0] EM_DataB_reg;


logic [31:0] DE_PC_out_reg;
logic [31:0] DE_PC_4_reg;
logic [31:0] DE_DataA_reg, DE_DataB_reg;
logic [31:0] DE_immediate_reg;
logic DE_PCSel_reg;
logic DE_BrUn_reg;
logic DE_ASel_reg,DE_BSel_reg;
logic [3:0] DE_ALUSel_reg;
logic DE_MemRW_reg;
logic [1:0] DE_WBSel_reg;

logic [31:0] MW_DataR_reg;
logic [1:0] MW_WBSel_reg;
logic MW_PCSel_reg;
logic [31:0] MW_alu_reg;
logic [31:0] MW_PC_4_reg;

// monitor for debug
initial begin
    forever begin
@(posedge clk);
$display("PC = %0d; FD = %0h; DE = %0h, %0h, %0h, EM = %0h; MW = %0h WB = %0h", PC_in, FD_instr, DE_DataA_reg, DE_DataB_reg, DE_immediate_reg, EM_alu_reg, MW_DataR_reg, wb);
end
end

PC PC_Top(.clk(clk),
          .rst(rst),
          .PC(PC_out),
          .PCP4(PC_in));

PC_adder PCPlus4Top(.clk(clk),
                    .rst(rst),
                    .PC_add(PC_out),
                    .PCP4_add(PC_4));

int instr_count;
Instruction_memory imem(.rst(rst),
                   .A(PC_out),
                   .RD(Instr));

/*-------------------------------
        ┌──────────────┐
        │   IF / ID    │
        │ PIPELINE REG |
        └──────────────┘
--------------------------------*/


always @(posedge clk or negedge rst)begin
if(!rst)begin
FD_instr <= 'b0;
FD_PC_out_reg <= 'b0;
FD_PC_4_reg <= 0;
end
else begin
FD_instr <= Instr;
FD_PC_out_reg <= PC_out;
FD_PC_4_reg <= PC_4;
end
end

/*-------------------------------
        ┌──────────────┐
        │   ID / IE    │
        │ PIPELINE REG |
        └──────────────┘
--------------------------------*/
Regfile regfile(.clk(clk),
        .rst(rst),
        .WE(RegWEn),
        .AddD(FD_instr[11:7]),
        .DataD(wb),
        .AddA(FD_instr[19:15]),
        .DataA(reg_DataA),
        .AddB(FD_instr[24:20]),
        .DataB(reg_DataB));

Imm_Gen Imm_Gen(.Instr(FD_instr),
                .ImmSel(ImmSel),
                .immediate(immediate));


RV32_Controller Controller(.i_instuction(FD_instr), 
                           .BrEq(BrEq), 
                           .BrLt(BrLt),
                           .PCSel(PCSel), //PCSel
                           .ImmSel(ImmSel), 
                           .BrUn(BrUn), 
                           .ASel(ASel), 
                           .BSel(BSel), 
                           .ALUSel(ALUSel), 
                           .MemRW(MemRW), 
                           .RegWEn(RegWEn), 
                           .WBSel(WBSel));

always @(posedge clk)begin
if(!rst)begin
DE_DataA_reg <= 0;
DE_DataB_reg <= 0;
DE_immediate_reg <= 0;
DE_PC_out_reg <= 0;
DE_PC_4_reg <= 0;
// control signals
DE_PCSel_reg <= '0;
DE_BrUn_reg <= '0;
DE_BSel_reg <= '0;
DE_ASel_reg <= '0;
DE_ALUSel_reg <= '0;
DE_MemRW_reg <= '0;
DE_WBSel_reg <= '0;
end
else begin
DE_PC_out_reg <= FD_PC_out_reg;
DE_DataA_reg <= reg_DataA;
DE_DataB_reg <= reg_DataB;
DE_immediate_reg <= immediate;
DE_PC_4_reg <= FD_PC_4_reg;
// control signals
DE_PCSel_reg <= PCSel;
DE_BrUn_reg <= BrUn;
DE_BSel_reg <= BSel;
DE_ASel_reg <= ASel;
DE_ALUSel_reg <= ALUSel;
DE_MemRW_reg <= MemRW;
DE_WBSel_reg <= WBSel;
end
end


/*-------------------------------
        ┌──────────────┐
        │   IE / IM    │
        │ PIPELINE REG |
        └──────────────┘
--------------------------------*/

branch_comp branch_comp(.A(DE_DataA_reg),
                        .B(DE_DataB_reg),
                        .BrUn(DE_BrUn_reg),
                        .BrEq(BrEq),
                        .BrLt(BrLt));


mux muxA(.a(DE_DataA_reg),
         .b(DE_PC_out_reg),
         .c(alu_in1),
         .sel(DE_ASel_reg));

mux muxB(.a(DE_DataB_reg),
         .b(DE_immediate_reg),
         .c(alu_in2),
         .sel(DE_BSel_reg));

ALU ALU_Top(.A(alu_in1),
            .B(alu_in2),
            .control(DE_ALUSel_reg),
            .ALU_result(alu));

/*-------------------------------
        ┌──────────────┐
        │   IE / IM    │
        │ PIPELINE REG |
        └──────────────┘
--------------------------------*/

always @(posedge clk or negedge rst)begin
if(!rst) begin
EM_alu_reg <= 0;
EM_MemRW_reg <= 0;
EM_WBSel_reg <= 0;
EM_PCSel_reg <= 0;
EM_DataB_reg <= 0;
EM_PC_4_reg <= 0;
end
else begin
EM_alu_reg <= alu;
EM_MemRW_reg <= DE_MemRW_reg;
EM_WBSel_reg <= DE_WBSel_reg;
EM_PCSel_reg <= DE_PCSel_reg;
EM_DataB_reg <= DE_DataB_reg;
EM_PC_4_reg <= DE_PC_4_reg;
end
end

Data_mem Data_mem(.clk(clk),
                  .A_mem(EM_alu_reg),
                  .DataIP(EM_DataB_reg),
                  .MemRW(EM_MemRW_reg),
                  .D_read(DataR)); 

/*-------------------------------
        ┌──────────────┐
        │   IM / IW    │
        │ PIPELINE REG |
        └──────────────┘
--------------------------------*/


always @(posedge clk or negedge rst)begin
if(!rst) begin
MW_DataR_reg <= 0;
MW_WBSel_reg <= 0;
MW_PCSel_reg <= 0;
MW_alu_reg <= 0;
MW_PC_4_reg <= 0;
end
else begin
MW_DataR_reg <= DataR;
MW_WBSel_reg <= EM_WBSel_reg;
MW_PCSel_reg <= EM_PCSel_reg;
MW_alu_reg <= EM_alu_reg;
MW_PC_4_reg <= EM_PC_4_reg;
end
end

mux3 mux3(.a(MW_DataR_reg),
          .b(MW_alu_reg),
          .c(MW_PC_4_reg),
          .d(wb),
          .sel(MW_WBSel_reg));

mux muxPC(.a(PC_4), 
          .b(EM_alu_reg),
          .c(PC_in),
          .sel(EM_PCSel_reg));
          
endmodule