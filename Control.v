/******************************************************************
* Description
*	This is control unit for the MIPS processor. The control unit is 
*	in charge of generation of the control signals. Its only input 
*	corresponds to opcode from the instruction.
*	1.0
* Author:
*	Dr. José Luis Pizano Escalante
* email:
*	luispizano@iteso.mx
* Date:
*	01/03/2014
******************************************************************/
module Control
(
	input [5:0]OP,
	
	output JAL,
	output Jump,
	output RegDst,
	output BranchEQ,
	output BranchNE,
	output MemRead,
	output MemtoReg,
	output MemWrite,
	output ALUSrc,
	output RegWrite,
	output [2:0]ALUOp
);

//opcodes
localparam R_Type 		= 0;
localparam I_Type_ADDI 	= 6'h08;
localparam I_Type_ORI 	= 6'h0d;
localparam I_Type_ANDI	= 6'h0c;
localparam I_Type_LUI	= 6'h0f;
localparam I_Type_LW		= 6'h23;
localparam I_Type_SW		= 6'h2b;
localparam I_Type_BEQ	= 6'h04;
localparam I_Type_BNE	= 6'h05;

localparam J_Type_J		= 6'h02;
localparam J_Type_JAL	= 6'h03;
// localparam JR			= 6'h0 es tipo R


reg [12:0] ControlValues;

always@(OP) begin
	casex(OP)
		R_Type:      ControlValues= 13'b00_1_001_00_00_111;
		I_Type_ADDI: ControlValues= 13'b00_0_101_00_00_100;
		I_Type_ORI:	 ControlValues= 13'b00_0_101_00_00_101;
		I_Type_ANDI: ControlValues= 13'b00_0_101_00_00_110;
		I_Type_LUI:	 ControlValues= 13'b00_0_101_00_00_000;
		I_Type_LW:	 ControlValues= 13'b00_0_111_10_00_100; //hace una suma
		I_Type_SW:	 ControlValues= 13'b00_0_100_01_00_100; //hace otra suma
		I_Type_BEQ:	 ControlValues= 13'b00_0_0x0_00_01_001; //hacer restas
		I_Type_BNE:  ControlValues= 13'b00_0_0x0_00_10_001;

		J_Type_J:	 ControlValues= 13'b01_0_000_00_00_000;
		J_Type_JAL:	 ControlValues= 13'b11_0_001_00_00_000;
		
		default:
			ControlValues= 13'b00_0_000_00_00_000;
		endcase
end	

assign JAL			= ControlValues[12];		// 0 WritreBack a RegFile,		1 Escribe en RegFile Resultado del salto
assign Jump			= ControlValues[11];		// 0 no salta,						1 salta		

assign RegDst 		= ControlValues[10];		// 0 para guardar en rt, 		1 para guardar en rd

assign ALUSrc 		= ControlValues[9];		// 0 para alimentar readData2,1 para alimentar inmediato extendido,
assign MemtoReg 	= ControlValues[8];		// 0 hace WB de ALU, 			1 hace WB de RAM
assign RegWrite 	= ControlValues[7];		// 0 no guarda, 					1 pone en WriteRegister lo de WriteData

assign MemRead 	= ControlValues[6];		// 1 pone contenido de la dirección input como salida
assign MemWrite 	= ControlValues[5];		// 1 reemplaza el valor en la dirección por el input de write data

assign BranchNE 	= ControlValues[4];		
assign BranchEQ 	= ControlValues[3];

assign ALUOp 		= ControlValues[2:0];		// valor que ejecuta la ALU

endmodule


