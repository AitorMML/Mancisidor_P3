/******************************************************************
* Description
*	This is a  an 3to1 multiplexer that can be parameterized in its bit-width.
******************************************************************/

module Multiplexer3to1
#(
	parameter NBits=32
)
(
	input Selector[1:0],	// 2-bit selector
	input [NBits-1:0] MUX_Data0,	// ID/EX
	input [NBits-1:0] MUX_Data1,	// WB
	input [NBits-1:0] MUX_Data2,	// EX/MEM
	
	output reg [NBits-1:0] MUX_Output

);

	always@(Selector,MUX_Data2,MUX_Data1,MUX_Data0) begin
		if(Selector == 01)
			MUX_Output = MUX_Data1;
		else if (Selector == 10)
			MUX_Output = MUX_Data2;
		else	// 00 or 11
			MUX_Output = Mux_Data0;
	end

endmodule