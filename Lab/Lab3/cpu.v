// puts everything together 
// pulls instruction from register
// decodes instruction
// does things
module cpu
(
input clk
);

//initial reg values to zero

wire[31:0] ReadData1, ReadData2, operandB, result, instruction, WriteData, DataIn, DataOut, imm32;
			
wire[2:0] aluCntrl;

wire[5:0] opcode, Funct;
wire[4:0] Rs, Rt, Rd, Shamt, WriteRegister;

wire MemWr, RegWr, jmp, brch;

wire[15:0] imm16;
wire[25:0] targetInstr;

//upload data

// Instruction Fetch: input Imm16, zero, branch, jump; get instruction
ifu ifyou(.instr(instruction), 
		.targetInstr(targetInstr), 
		.imm16(imm16), 
		.clk(clk), 
		.zero(zero), 
		.branch(branch), 
		.jump(jump));

// Instruction Decode: input instruction; get pieces
instrdec indeck(.instr(instruction), 
		.opcode(opcode), 
		.Rs(Rs), 
		.Rt(Rt), 
		.Rd(Rd), 
		.Shamt(Shamt), 
		.Funct(Funct));

// LUT for opcode to enables and such
lut lute(.ALUcntrl(aluCntrl), 
		.ALUsrc(aluSrc), 
		.RegWr(RegWr), 
		.RegDst(RegDst), 
		.MemWr(MemWr), 
		.MemtoReg(MemToReg), 
		.opcode(opcode), 
		.func(Funct),
		.jmp(jmp),
		.brch(brch));

// Operand Fetch
mux5 regdest(.selected(WriteRegister), 
			.inputA(Rd), 
			.inputB(Rt), 
			.select(RegDst));
			
regfile reggie(.ReadData1(ReadData1),
		.ReadData2(ReadData2),
		.WriteData(WriteData),
		.ReadRegister1(Rs),
		.ReadRegister2(Rt),
		.WriteRegister(WriteRegister),
		.RegWrite(RegWr),
		.Clk(clk));

// Execute
signextend sextnd(.imm16(imm16), 
			.imm32(imm32));

mux32 aluchoice(.selected(operandB), 
		.inputA(imm32), 
		.inputB(ReadData2), 
		.select(aluSrc));
				
alu ayylou(.carryout(carryout),
		.zero(zero),
		.overflow(overflow),
		.result(result),
		.operandA(ReadData1),
		.operandB(operandB),
		.command(aluCntrl));

memory memINI(.clk(clk),
		.regWE(MemWr),
		.DataAddr(result[9:0]),
		.DataIn(ReadData2),
		.DataOut(DataOut));
					
mux32 mem2reg(.selected(WriteData), 
		.inputA(DataOut), 
		.inputB(result), 
		.select(1'b1)); //swapped out Mem

assign imm16 = {Rd, Shamt, Funct};
assign targetInstr = {Rt, Rs, Rd, Shamt, Funct};

endmodule
