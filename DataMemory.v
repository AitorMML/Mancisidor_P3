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
	parameter MEMORY_DEPTH = 512	//$sp = 0x10010000 + d'512

)
(
	input [DATA_WIDTH-1:0] WriteData,
	input [DATA_WIDTH-1:0]  Address,
	input MemWrite,MemRead, clk,
	output  [DATA_WIDTH-1:0]  ReadData
);
	
	// Declare the RAM variable
	reg [DATA_WIDTH-1:0] ram[MEMORY_DEPTH-1:0];
	wire [DATA_WIDTH-1:0] ReadDataAux;
	wire [DATA_WIDTH-1:0] AddressAux; //Direccion a memoria
	
	assign AddressAux = (Address -32'h1001_0000)>>2; //Corrida a la derecha 

	always @ (posedge clk)
	begin
		// Write
		if (MemWrite)
			ram[AddressAux] <= WriteData;
	end
	assign ReadDataAux = ram[AddressAux];
  	assign ReadData = ReadDataAux & {DATA_WIDTH{MemRead}};

endmodule
