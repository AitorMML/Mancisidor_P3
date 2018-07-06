
module EX_MEM
#(
	parameter N= 114
)
(
	input clk,
	input reset,
	input Enable_EX_MEM,
	
	input [31:0] BranchAddress,
	input [31:0] ALUResult,
	input [31:0] ReadData2,
	input [4:0] WriteReg, //resultado de mux, va a guardar en reg file
	input RegWrite,	//decirle que cuando haga wb, va a guardar en registro
	input BNE,
	input BEQ,
	input Zero,
	input MEMWrite,
	input MEMRead,
	input MEMtoReg,
	input JAL,
	input J,
	input JR,
	 
	output reg [31:0] BranchAddress_EX_MEM,
	output reg [31:0] ALUResult_EX_MEM,	// address de ram
	output reg [31:0] ReadData2_EX_MEM,	// writedata de ram
	output reg [4:0] WriteReg_EX_MEM,	// destino del jal
	output reg RegWrite_EX_MEM,
	output reg BNE_EX_MEM,
	output reg BEQ_EX_MEM,
	output reg Zero_EX_MEM,
	output reg MEMWrite_EX_MEM,
	output reg MEMRead_EX_MEM,
	output reg MEMtoReg_EX_MEM,
	output reg JAL_EX_MEM,
	output reg J_EX_MEM,
	output reg JR_EX_MEM

);
always@(negedge reset or negedge clk) begin
	if(reset==0)
		begin
			BranchAddress_EX_MEM  <= 32'h0040_0000;//4_194_304;
			 BranchAddress_EX_MEM <= 0;
			 ALUResult_EX_MEM 	 <= 0;
			 ReadData2_EX_MEM		 <= 0;
			 WriteReg_EX_MEM 		 <= 0;
			 RegWrite_EX_MEM 		 <= 0;
			 BNE_EX_MEM 			 <= 0;
			 BEQ_EX_MEM 			 <= 0;
			 Zero_EX_MEM			 <= 0;
			 MEMWrite_EX_MEM 		 <= 0;
			 MEMRead_EX_MEM 		 <= 0;
			 MEMtoReg_EX_MEM 		 <= 0;
			 JAL_EX_MEM 			 <= 0;
			 J_EX_MEM 				 <= 0;
			 JR_EX_MEM 				 <= 0;	
		end
	else 
		if	(Enable_EX_MEM == 1)
			begin
				 BranchAddress_EX_MEM <= BranchAddress;
				 ALUResult_EX_MEM 	 <= ALUResult;
				 ReadData2_EX_MEM		 <= ReadData2;
				 WriteReg_EX_MEM 		 <= WriteReg;
				 RegWrite_EX_MEM 		 <= RegWrite;
				 BNE_EX_MEM 			 <= BNE;
				 BEQ_EX_MEM 			 <= BEQ;
				 Zero_EX_MEM			 <= Zero;
				 MEMWrite_EX_MEM 		 <= MEMWrite;
				 MEMRead_EX_MEM 		 <= MEMRead;
				 MEMtoReg_EX_MEM 		 <= MEMtoReg;
				 JAL_EX_MEM 			 <= JAL;
				 J_EX_MEM 				 <= J;
				 JR_EX_MEM 				 <= JR;		 	
			end
end

endmodule

