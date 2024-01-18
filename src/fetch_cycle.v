module fetch_cycle(clk,rst,PCSrcE,PCTargetE, InstrD,PCD,PCPlus4D);

input clk,rst;
input PCSrcE;
input [31:0]PCTargetE; //target value
output [31:0] InstrD;
output [31:0] PCD,PCPlus4D;

//declare internal wires
wire [31:0] PC_F, PCF,PCPlus4F, InstrF;

// Initialize modules
mux PC_Mux (.i_A(PCPlus4F),.i_B(PCTargetE),.i_sel(PCSrcE),.o_C(PC_F));

Prog_Count PCounter(.clk(clk),.rst(rst),.PC(PCF),.PC_Nxt(PC_F));

Instruction_memory Imem(.rst(rst),.A(PCF),.RD(InstrF));

PC_Adder adder(.a(PCF),.b(32'h00000004),.c(PCPlus4F));

//declare registers for PCD, PCPlus4D, and InstrD
reg [31:0] InstrF_reg;
reg [31:0] PCF_reg;
reg [31:0] PCPlus4F_reg;

//Fetch register logic
always @(posedge clk or negedge rst)begin
    if(rst == 1'b0) begin  //reset is active low
        InstrF_reg = 0;
        PCF_reg = 0;
        PCPlus4F_reg = 0;
    end
    else begin
        InstrF_reg <= InstrF;
        PCF_reg <= PCF;
        PCPlus4F_reg <= PCPlus4F;
    end
end
/* Fetch reg logic
when reset is active (ie rst = 0 since it is active low signal)
Then, all registers are reset to zero.

Else the registers store the values of the incomming Instruction, Program counter value and Program counter plus 4 value. 
*/

// now connecting the outputs to the registers via assign statements
assign InstrD = (rst == 1'b0) ? 32'h00000000 : InstrF_reg;
assign PCD = (rst == 1'b0) ? 32'h00000000 : PCF_reg;
assign PCPlus4D = (rst == 1'b0) ? 32'h00000000 : PCPlus4F_reg;
// here to allow resetting of the outputs of D or decode stage, we are using a reset condition with assign statements.

endmodule