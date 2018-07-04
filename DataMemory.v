/******************************************************************
* Description
*	This is the data memory for the MIPS processor
*	1.0
* Author:
*	Dr. José Luis Pizano Escalante
* email:
*	luispizano@iteso.mx
* Date:
*	01/03/2014
******************************************************************/

module DataMemory 
#(	parameter DATA_WIDTH = 32,
	parameter MEMORY_DEPTH = 1024

)
(
	input [DATA_WIDTH-1:0] WriteData,
	input [DATA_WIDTH-1:0]  Address,
	input MemWrite,
	input MemRead, 
	input clk,
	output  [DATA_WIDTH-1:0]  ReadData
);
	
	// Declare the RAM variable
	reg [DATA_WIDTH-1:0] ram[MEMORY_DEPTH-1:0];
	wire [DATA_WIDTH-1:0] ReadDataAux;
	wire [DATA_WIDTH-1:0] AddressAux;	// Dirección traducida a esta memoria.
	
	assign AddressAux = (Address - 32'h1001_0000) >> 2; //Recorrida a la derecha para acortar los bits

	always @ (posedge clk)
	begin
		// Write
		if (MemWrite)
			ram[AddressAux] <= WriteData;	
	end
	assign ReadDataAux = ram[AddressAux];
  	assign ReadData = {DATA_WIDTH{MemRead}}& ReadDataAux; //Llena de 1's y hace el AND para sacar la dirección solo si MemRead está encendido.

endmodule
