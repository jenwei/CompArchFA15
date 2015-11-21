module cpu
(
);
// puts everything together 
// pulls instruction from register
// decodes instruction
// does things

//initial reg values to zero
wire[31:0] instruction;
wire[5:0] opcode;
wire[5:0] Funct;
wire MemWr, RegWr;
wire aluCntrl;

//upload data
//start clock


// Instruction Fetch: input Imm16, zero, branch, jump; get instruction
ifu ifyou(instruction, targetInstr, imm16, clk, zero, branch, jump);
// Instruction Decode: input instruction; get pieces
instrdec indeck(instruction, opcode, Rs, Rt, Rd, Shamt, Funct);
// LUT for opcode to enables and such
LUT lute(.ALUcntrl(aluCntrl), .ALUsrc(aluSrc), .RegWr(RegWr), .RegDst(RegDst), .MemWr(MemWr), .MemtoReg(MemToReg), .opcode(opcode), .func(Funct));
// Operand Fetch
mux regdest(WriteRegister, Rt, Rd, RegDst); 
regfile reggie(ReadData1,ReadData2,WriteData,ReadRegister1,ReadRegister2,WriteRegister,RegWr,Clk);
// Execute
signextend sextnd(imm16, imm32);
mux aluchoice(operandB, ReadData2, imm32, aluSrc);
alu ayylou(carryout,zero,overflow,result,operandA,operandB,aluCntrl);
// Store to Mem
datamem deezmeme(clk, dataOut,address,MemWr,dataIn);
mux mem2reg(WriteData, dataOut, result, MemToReg);
// Next instruction
always @ (posedge clk) begin

end
endmodule
