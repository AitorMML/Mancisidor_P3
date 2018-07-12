
module ID_EX
#(
	parameter N=192
)
(
	input clk,
	input reset,
	input Enable_ID_EX,
	
	input [31:0] PC4,
	input [31:0] ReadData1,
	input [31:0] ReadData2,
	input [31:0] ImmediateExtend,
	input [31:0]JumpAddress,
	input [4:0] Rs,
	input [4:0] Rt,
	input [4:0] Rd,
	input [2:0] ALUOp,
	input RegDest,
	input ALUSrc,
	input BNE,
	input BEQ,
	input MemWrite,
	input MemRead,
	input MemtoReg,
	input RegWrite,
	input JAL,
	input J,
	input JR, 

	
	output reg [31:0] PC4_ID_EX,
	output reg [31:0] ReadData1_ID_EX,
	output reg [31:0] ReadData2_ID_EX,
	output reg [31:0] SignExtend_ID_EX,
	output reg [31:0]JumpAddress_ID_EX,
	output reg [4:0] Rs_ID_EX,
	output reg [4:0] Rt_ID_EX,
	output reg [4:0] Rd_ID_EX,
	output reg [2:0] ALUOp_ID_EX,
	output reg RegDest_ID_EX,
	output reg ALUSrc_ID_EX,
	output reg RegWrite_ID_EX,
	output reg BNE_ID_EX,
	output reg BEQ_ID_EX,
	output reg MemWrite_ID_EX,
	output reg MemRead_ID_EX,
	output reg MemtoReg_ID_EX,
	output reg JAL_ID_EX,
	output reg J_ID_EX,
	output reg JR_ID_EX

);
always@(negedge reset or negedge clk) begin
	if(reset==0) 
		begin
			PC4_ID_EX <= 32'h0040_0000;//4_194_304;
			ReadData1_ID_EX 	<= 0;
			ReadData2_ID_EX 	<= 0;
			SignExtend_ID_EX 	<= 0;
			JumpAddress_ID_EX <= 0;
			Rs_ID_EX				<= 0;
			Rt_ID_EX 			<= 0;
			Rd_ID_EX 			<= 0;
			ALUOp_ID_EX 		<= 0;
			RegDest_ID_EX 		<= 0;
			ALUSrc_ID_EX 		<= 0;
			BNE_ID_EX 			<= 0;
			BEQ_ID_EX 			<= 0;
			RegWrite_ID_EX 	<= 0;
			MemWrite_ID_EX 	<= 0;
			MemRead_ID_EX 		<= 0;
			MemtoReg_ID_EX 	<= 0;
			JAL_ID_EX 			<= 0;
			J_ID_EX 				<= 0;
			JR_ID_EX 			<= 0;
		end
	else 
		if	(Enable_ID_EX == 1) 
			begin
				PC4_ID_EX 			<= PC4;
				ReadData1_ID_EX 	<= ReadData1;
				ReadData2_ID_EX 	<= ReadData2;
				SignExtend_ID_EX 	<= ImmediateExtend;
				JumpAddress_ID_EX <= JumpAddress;
				Rs_ID_EX				<= Rs;
				Rt_ID_EX 			<= Rt;
				Rd_ID_EX 			<= Rd;
				ALUOp_ID_EX 		<= ALUOp;
				RegDest_ID_EX 		<= RegDest;
				ALUSrc_ID_EX 		<= ALUSrc;
				BNE_ID_EX 			<= BNE;
				BEQ_ID_EX 			<= BEQ;
				RegWrite_ID_EX 	<= RegWrite;
				MemWrite_ID_EX 	<= MemWrite;
				MemRead_ID_EX 		<= MemRead;
				MemtoReg_ID_EX 	<= MemtoReg;
				JAL_ID_EX 			<= JAL;
				J_ID_EX 				<= J;
				JR_ID_EX 			<= JR;
			end
end

endmodule

