module ALU_decoder(ALUOp,op,funct3, funct7, ALUControl);

input [6:0]op,funct7;
input [2:0] funct3; 

output [2:0]ALUControl;

//declare internal wires
wire [1:0] concatenation;

assign concatenation = {op5,funct7}; // concatenated according to truth table.
assign ALUControl = (ALUOp == 2'b00) ? ALUControl = 3'b000 : 
                    (ALUOp == 2'b01) ? ALUControl = 3'b001 : 
                    ((ALUOp == 2'b10) & (funct3 == 3'b010) ) ? 3'b101 : //slt
                    ((ALUOp == 2'b10) & (funct3 == 3'b110) ) ? 3'b011 : //or
                    ((ALUOp == 2'b10) & (funct3 == 3'b111) ) ? 3'b010 : //and
                    ((ALUOp == 2'b10) & (funct3 == 3'b000) & (concatenation == 2'b11) ) ? 3'b001 : //sub
//                  ((ALUOp == 2'b10) & (funct3 == 3'b000) & ((concatenation == 2'b00) or (concatenation == 2'b01) or (concatenation == 2'b10))) ? 3'b000 : //add
                    ((ALUOp == 2'b10) & (funct3 == 3'b000) & (concatenation != 2'b11) ) ? 3'b000 : 3'b000;// add optimized version 
endmodule