
module Hazard
#(
	parameter N = 16
)
(
		input ID_EX_MemRead, 
		input [4:0] ID_EX_Rt,
		input [4:0] IF_ID_Rs,
		input [4:0] IF_ID_Rt,
		
		output reg HazardMux, 
		output reg IF_ID_Write,
		output reg PCWrite    
		
);

always@(ID_EX_MemRead or ID_EX_Rt or IF_ID_Rs or IF_ID_Rt or PCWrite or IF_ID_Write) 
begin
	if( ID_EX_MemRead && ( (ID_EX_Rt == IF_ID_Rs) || (ID_EX_Rt == IF_ID_Rt) ) )
		begin				// Insertar burbuja
			PCWrite 		<= 0;
			IF_ID_Write <= 0;
			HazardMux 	<= 1;
		end 
	else
		begin				// Re encender enables
			PCWrite 		<= 1;
			IF_ID_Write <= 1;
			HazardMux 	<= 0;
		end
		
end
	
endmodule