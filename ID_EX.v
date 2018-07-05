
module ID_EX
#(
	parameter N=64
)
(
	input clk,
	input reset,
	input Enable_ID_EX,
	
	input [31:0] PC4,
	input [31:0] ReadData1,
	input [31:0] ReadData2,
	input [31:0] ImmediateExtend,
	input [4:0] Rt,
	input [4:0] Rd,
	input [2:0] ALUOp,
	input RegDest,
	input ALUSrc,
	input BNE,
	input BEQ,
	input MEMWrite,
	input MEMRead,
	input JAL,
	input J,
	input JR,
	
	output reg [31:0] PC4_ID_EX,
	output reg [31:0] ReadData1_ID_EX,
	output reg [31:0] ReadData2_ID_EX,
	output reg [31:0] SignExtend_ID_EX,
	output reg [4:0] Rt_ID_EX,
	output reg [4:0] Rd_ID_EX,
	output reg [2:0] ALUOp_ID_EX,
	output reg RegDest_ID_EX,
	output reg ALUSrc_ID_EX,
	output reg BNE_ID_EX,
	output reg BEQ_ID_EX,
	output reg MEMWrite_ID_EX,
	output reg MEMRead_ID_EX,
	output reg JAL_ID_EX,
	output reg J_ID_EX,
	output reg JR_ID_EX

);
always@(negedge reset or negedge clk) begin
	if(reset==0)
		PC4_ID_EX<= 32'h0040_0000;//4_194_304;
	else 
		if	(Enable_ID_EX==1)
			 PC4_ID_EX<=PC4;
			 ReadData1_ID_EX <=  ReadData1;
			 ReadData2_ID_EX <= ReadData2;
			 SignExtend_ID_EX <= ImmediateExtend;
			 Rt_ID_EX <= Rt;
			 Rd_ID_EX <= Rd;
			 ALUOp_ID_EX <= ALUOp;
			 RegDest_ID_EX <=RegDest;
			 ALUSrc_ID_EX <= ALUSrc;
			 BNE_ID_EX <= BNE;
			 BEQ_ID_EX <= BEQ;
			 MEMWrite_ID_EX <= MEMWrite;
			 MEMRead_ID_EX <= MEMRead;
			 JAL_ID_EX <= JAL;
			 J_ID_EX <= J;
			 JR_ID_EX <=JR;
			 
			 
end
endmodule

