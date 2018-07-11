
module ForwardingUnit
#(
	parameter N=20
)
(
	input [4:0] ID_EX_Rs,
	input [4:0] ID_EX_Rt,
	input [4:0] EX_MEM_Rd,	//después de JAL
	input [4:0] MEM_WB_Rd,	
	
	input EX_MEM_RegWrite,	// señal de control
	input MEM_WB_RegWrite,
	
	output reg[1:0] ForwardA,
	output reg[1:0] ForwardB
	
	
	always@(ID_EX_Rs,ID_EX_Rt,EX_MEM_Rd,MEM_WB_Rd) begin

			// EX Forward
		if ( EX_MEM_RegWrite
		and (EX_MEM_Rd != 0)
		and (EX_MEM_Rd = ID_EX_Rs) )
				ForwardA <= 10;
				
		else if ( EX_MEM_RegWrite
		and (EX_MEM_Rd != 0)
		and (EX_MEM_Rd = ID_EX_Rt) )
				ForwardB <= 10;		
				
			// MEM Forward
		else if ( MEM_WB_RegWrite
		and (MEM_WB_Rd != 0)
		and (EX_MEM_Rd != ID_EX_Rs)
		and (MEM_WB_Rd = ID_EX_Rs) )
				ForwardA <= 01;
				
		else if (MEM_WB_RegWrite
		and (MEM_WB_Rd != 0)
		and (EX_MEM_Rd != ID_EX_Rt)
		and (MEM_WB_Rd = ID_EX_Rt) )
				ForwardB <= 01;
		
		else 
			begin
				ForwardA <= 00;
				ForwardB <= 00;
			end
		
		
	end
);


endmodule

