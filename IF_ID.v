
module IF_ID
#(
	parameter N=64
)
(
	input clk,
	input reset,
	input Enable_IF_ID,
	
	input [31:0] PC4,
	input [31:0] Instruction,
	
	output reg [31:0] PC4_IF_ID,
	output reg [31:0] Instruction_IF_ID
	

);
always@(negedge reset or negedge clk) begin
	if(reset==0)
		PC4_IF_ID <= 32'h0040_0000;//4_194_304;
	else 
		if	(Enable_IF_ID==1)
			PC4_IF_ID <= PC4;
			Instruction_IF_ID <= Instruction;
end
endmodule

