/*/////////////////////////////////////////////
 File: branch_comp.v
 Author: Manav Shah
 ----------------------------------------------

    ██████╗ ██╗███████╗ ██████╗██╗  ██╗██╗   ██╗
    ██╔══██╗██║██╔════╝██╔════╝██║ ██╔╝╚██╗ ██╔╝
    ██████╔╝██║███████╗██║     █████╔╝  ╚████╔╝ 
    ██╔══██╗██║╚════██║██║     ██╔═██╗   ╚██╔╝  
    ██║  ██║██║███████║╚██████╗██║  ██╗   ██║   
    ╚═╝  ╚═╝╚═╝╚══════╝ ╚═════╝╚═╝  ╚═╝   ╚═╝   
 ----------------------------------------------
                                    
 Copyright (c) 2024 MANAV SHAH
*//////////////////////////////////////////////

module branch_comp(A,B,BrUn,BrEq,BrLt);

input [31:0]A,B;
input BrUn;

output BrEq,BrLt;

assign BrEq = ((BrUn == 1'b0) & (A == B)) ? 1 :
              ((BrUn == 1'b1) & (A[30:0] == B[30:0])) ? 1 : 0;
 
assign BrLt = ((BrUn == 1'b0) & (A < B)) ? 1 :
              ((BrUn == 1'b1) & (A[30:0] < B[30:0])) ? 1 : 0; 

endmodule