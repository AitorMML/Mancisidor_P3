/******************************************************************
* Description
*	This is the top-level of a MIPS processor that can execute the next set of instructions:
*		add
*		addi
*		sub
*		ori
*		or
*		bne
*		beq
*		and
*		nor
* This processor is written Verilog-HDL. Also, it is synthesizable into hardware.
* Parameter MEMORY_DEPTH configures the program memory to allocate the program to
* be execute. If the size of the program changes, thus, MEMORY_DEPTH must change.
* This processor was made for computer organization class at ITESO.
* Version:
*	1.0
* Author:
*	Dr. José Luis Pizano Escalante
* email:
*	luispizano@iteso.mx
* Date:
*	12/06/2016
******************************************************************/


module MIPS_Processor
#(
	parameter MEMORY_DEPTH = 128
)

(
	// Inputs
	input clk,
	input reset,
	input [7:0] PortIn,
	// Output
	output [31:0] ALUResultOut,
	output [31:0] PortOut
);
//******************************************************************/
//******************************************************************/
assign  PortOut = 0;

//******************************************************************/
//******************************************************************/
// Data types to connect modules
wire BranchNE_wire;
wire BranchEQ_wire;
wire RegDst_wire;
wire NotZeroANDBrachNE;
wire ZeroANDBrachEQ;
//wire ORForBranch;
wire ALUSrc_wire;
wire RegWrite_wire;
wire MemRead_wire;
wire MemWrite_wire;
wire MemtoReg_wire;
wire Zero_wire;
wire Jump_wire;
wire JAL_wire;
wire OPCodeAND_wire;
wire FuncAND_wire;
wire JRControl_wire;
wire [2:0] ALUOp_wire;
wire [3:0] ALUOperation_wire;
wire [4:0] IorJ_wire;
wire [4:0] WriteRegister_wire;

wire [27:0] ShiftedInstruction_wire;
wire [31:0] Instruction_wire;
wire [31:0] ReadData1_wire;
wire [31:0] ReadData2_wire;
wire [31:0] InmmediateExtend_wire;
wire [31:0] ReadData2OrInmmediate_wire;
wire [31:0] ALUResult_wire;
wire [31:0] ReadMemData_wire;
wire [31:0] WriteBack_wire;
wire [31:0] PC_4_wire;
wire [31:0] PC_wire;
wire [31:0] InmmediateExtendAnded_wire;
wire [31:0] PCtoBranch_wire;
wire [31:0] ShiftedImmediateExtended_wire;
wire [31:0] BranchAddress_wire;	// El que entra al mux de ramas
wire [31:0] BranchResult_wire;	// El que entra al MUX del salto
wire [31:0] JumpAddress_wire;		// Combinación del desplazo de instrucción y parte alta de PC+4
wire [31:0] JumpResult_wire;		// Resultado del MUX, entra el MUX de JR
wire [31:0] JALResult_Writeback_wire; // Pone PC o WB en RegFile
wire [31:0] JRResult_wire;			// Vuelve a PC

integer ALUStatus;


//******************************************************************/
//******************************************************************/
//******************************************************************/
//******************************************************************/
//******************************************************************/
Control
ControlUnit
(
	.OP(Instruction_wire[31:26]),
	.JAL(JAL_wire),
	.Jump(Jump_wire),
	.RegDst(RegDst_wire),
	.BranchNE(BranchNE_wire),
	.BranchEQ(BranchEQ_wire),
	.MemRead(MemRead_wire),
	.MemWrite(MemWrite_wire),
	.ALUOp(ALUOp_wire),
	.ALUSrc(ALUSrc_wire),
	.RegWrite(RegWrite_wire),
	.MemtoReg(MemtoReg_wire)
);

PC_Register
ProgramCounter
(
	.clk(clk),
	.reset(reset),
	.NewPC(JRResult_wire),
	.PCValue(PC_wire)
);


ProgramMemory
#(
	.MEMORY_DEPTH(MEMORY_DEPTH)
)
ROMProgramMemory
(
	.Address(PC_wire),
	.Instruction(Instruction_wire)
);

Adder32bits
PC_Plus_4
(
	.Data0(PC_wire),
	.Data1(4),
	
	.Result(PC_4_wire)
);


//******************************************************************/
//******************************************************************/
//******************************************************************/
//******************************************************************/
//******************************************************************/
Multiplexer2to1
#(
	.NBits(5)
)
MUX_ForRTypeAndIType
(
	.Selector(RegDst_wire),
	.MUX_Data0(Instruction_wire[20:16]),
	.MUX_Data1(Instruction_wire[15:11]),
	
	.MUX_Output(IorJ_wire)

);



RegisterFile
Register_File
(
	.clk(clk),
	.reset(reset),
	.RegWrite(RegWrite_wire),
	.WriteRegister(WriteRegister_wire),
	.ReadRegister1(Instruction_wire[25:21]),
	.ReadRegister2(Instruction_wire[20:16]),
	.WriteData(JALResult_Writeback_wire),	//viene de RAM
	.ReadData1(ReadData1_wire),
	.ReadData2(ReadData2_wire)

);

SignExtend
SignExtendForConstants
(   
	.DataInput(Instruction_wire[15:0]),
   .SignExtendOutput(InmmediateExtend_wire)
);



Multiplexer2to1
#(
	.NBits(32)
)
MUX_ForReadDataAndInmediate
(
	.Selector(ALUSrc_wire),
	.MUX_Data0(ReadData2_wire),
	.MUX_Data1(InmmediateExtend_wire),
	
	.MUX_Output(ReadData2OrInmmediate_wire)

);


ALUControl
ArithmeticLogicUnitControl
(
	.ALUOp(ALUOp_wire),
	.ALUFunction(Instruction_wire[5:0]),
	.ALUOperation(ALUOperation_wire)

);



ALU
ArithmeticLogicUnit 
(
	.ALUOperation(ALUOperation_wire),
	.A(ReadData1_wire),
	.B(ReadData2OrInmmediate_wire),
	.shamt(Instruction_wire[10:6]),
	.Zero(Zero_wire),
	.ALUResult(ALUResult_wire)
);

assign ALUResultOut = ALUResult_wire;

//LW y SW
DataMemory
#(
	.MEMORY_DEPTH(MEMORY_DEPTH)
)
RAMDataMemory
(
	.WriteData(ReadData2_wire),
	.Address(ALUResult_wire),
	.clk(clk),
	.MemWrite(MemWrite_wire),
	.MemRead(MemRead_wire),
	
	.ReadData(ReadMemData_wire)
);

Multiplexer2to1
#(
	.NBits(32)
)
MUX_WB_ALUorRAM
(
	.Selector(MemtoReg_wire),
	.MUX_Data0(ALUResult_wire),
	.MUX_Data1(ReadMemData_wire),
	
	.MUX_Output(WriteBack_wire)

);



//Branches
ShiftLeft2
BranchesShiftLeft2
(
	.DataInput(InmmediateExtend_wire),
	.DataOutput(ShiftedImmediateExtended_wire)
);

Adder32bits
BranchAdder
(
	.Data0(PC_4_wire),
	.Data1(ShiftedImmediateExtended_wire),
	
	.Result(BranchAddress_wire)
);

ANDGate
BEQ_AND
(
	.A(BranchEQ_wire),
	.B(Zero_wire),
	
	.C(ZeroANDBrachEQ)
);

ANDGate
BNE_AND
(
	.A(BranchNE_wire),
	.B(~Zero_wire),				//No debe ser 0
	
	.C(NotZeroANDBrachNE)
);


Multiplexer2to1_Modified
#(
	.NBits(32)
)
BEQ_MUX
(
	.Selector1(ZeroANDBrachEQ),
	.Selector2(NotZeroANDBrachNE),
	.MUX_Data0(PC_4_wire),
	.MUX_Data1(BranchAddress_wire),
	
	.MUX_Output(BranchResult_wire)

);

ShiftLeft2
JumpShift
(
	.DataInput(Instruction_wire[25:0]),
	.DataOutput(ShiftedInstruction_wire)
);

assign JumpAddress_wire = {PC_4_wire[31:28],ShiftedInstruction_wire}; //[27:0]

Multiplexer2to1
#(
	.NBits(32)
)
JumpMUX
(
	.Selector(Jump_wire),
	.MUX_Data0(BranchResult_wire),
	.MUX_Data1(JumpAddress_wire),
	
	.MUX_Output(JumpResult_wire)

);

//JAL
Multiplexer2to1
#(
	.NBits(32)
)
JALMUX
(
	.Selector(JAL_wire),
	.MUX_Data0(WriteBack_wire),
	.MUX_Data1(BranchResult_wire), //Escribe pc+4 en $ra ; no está cambiando PC  
	
	.MUX_Output(JALResult_Writeback_wire)
);

Multiplexer2to1
#(
	.NBits(5)
)
StoreRA_MUX						// Seleccionar registro a almacenar
(
	.Selector(JAL_wire),
	.MUX_Data0(IorJ_wire), 	// registro normal ($rd o $rt)
	.MUX_Data1(31),			// $ra
	
	.MUX_Output(WriteRegister_wire)
);


//JR
LargeANDGate
OPCodeAND
(
	.A(Instruction_wire[31:26]),
	.B(0),
	.C(OPCodeAND_wire)
);

LargeANDGate
FuncAND
(
	.A(Instruction_wire[5:0]),
	.B(8),
	.C(FuncAND_wire)
);

ANDGate
JRANDGate
(
	.A(OPCodeAND_wire),
	.B(FuncAND_wire),
	.C(JRControl_wire)
);

Multiplexer2to1
#(
	.NBits(32)
)
JRMUX	
(
	.Selector(JRControl_wire),		// resultado de la AND
	.MUX_Data0(JumpResult_wire), 	// Siguiente tiempo si no salta
	.MUX_Data1(ReadData1_wire),	// Contenido de rs
	
	.MUX_Output(JRResult_wire)		//Manda a PC
);

endmodule

