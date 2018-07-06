
module MEM_WB
#(
	parameter N=76
)
(
	input clk,
	input reset,
	input Enable_MEM_WB,
	
	input [31:0] ReadMemData,
	input [31:0] ALUResult,
	input [4:0] WriteRegister,
	input JAL,
	input RegWrite,
	input MemtoReg,
	input [31:0]BranchResult,
	
	output reg [31:0] ReadMemData_MEM_WB,
	output reg [31:0] ALUResult_MEM_WB,
	output reg [4:0] WriteRegister_MEM_WB,
	output reg JAL_MEM_WB,
	output reg RegWrite_MEM_WB,
	output reg MemtoReg_MEM_WB,
	output reg [31:0]BranchResult_MEM_WB
);
always@(negedge reset or negedge clk) begin
	if(reset==0)
		begin
			BranchResult_MEM_WB	 <= 32'h0040_0000;//4_194_304;
			ReadMemData_MEM_WB	 <= 0;
			ALUResult_MEM_WB		 <= 0;
			WriteRegister_MEM_WB  <= 0;
			JAL_MEM_WB				 <= 0;
			RegWrite_MEM_WB		 <= 0;
			MemtoReg_MEM_WB 		 <= 0;

		end
	else 
		if	(Enable_MEM_WB == 1)
			begin
				ReadMemData_MEM_WB	 <= ReadMemData;
				ALUResult_MEM_WB		 <= ALUResult;
				WriteRegister_MEM_WB  <= WriteRegister;
				JAL_MEM_WB				 <= JAL;
				RegWrite_MEM_WB		 <= RegWrite;
				MemtoReg_MEM_WB 		 <= MemtoReg;
				BranchResult_MEM_WB	 <= BranchResult; 
			end
end
endmodule 