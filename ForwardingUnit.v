
module ForwardingUnit
//#(
//	parameter N=20
//)
(
	input [4:0] ID_EX_Rs,
	input [4:0] ID_EX_Rt,
	input [4:0] EX_MEM_Rd,	//después de JAL
	input [4:0] MEM_WB_Rd,	
	
	input EX_MEM_RegWrite,	// señal de control
	input MEM_WB_RegWrite,
	
	output reg[1:0] ForwardA,
	output reg[1:0] ForwardB
);
	
localparam IDEX 	= 2'b00;
localparam WB  	= 2'b01;
localparam EXMEM 	= 2'b10;

always@(ID_EX_Rs, ID_EX_Rt,EX_MEM_Rd, MEM_WB_Rd, MEM_WB_RegWrite, EX_MEM_RegWrite) begin

		// EX Forward
	if ( EX_MEM_RegWrite	
	& (EX_MEM_Rd != 0)
	& (EX_MEM_Rd == ID_EX_Rs) )
			ForwardA <= EXMEM;
			
	else if ( EX_MEM_RegWrite
	& (EX_MEM_Rd != 0)
	& (EX_MEM_Rd == ID_EX_Rt) )
			ForwardB <= EXMEM;		
			
		// MEM Forward
	else if ( MEM_WB_RegWrite
	& (MEM_WB_Rd != 0)
	& (EX_MEM_Rd != ID_EX_Rs)
	& (MEM_WB_Rd == ID_EX_Rs) )
			ForwardA <= WB;
			
	else if (MEM_WB_RegWrite
	& (MEM_WB_Rd != 0)
	& (EX_MEM_Rd != ID_EX_Rt)
	& (MEM_WB_Rd == ID_EX_Rt) )
			ForwardB <= WB;
	
	else 
		begin
			ForwardA <= IDEX;
			ForwardB <= IDEX;
		end
	
	
end

endmodule

