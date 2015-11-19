module cpu
(
);
// puts everything together 
// pulls instruction from register
// decodes instruction
// does things

//initial reg values to zero
reg
wire[31:0] instruction;
//upload data
//start clock

// Instruction Fetch: input Imm16, zero, branch, jump; get instruction
ifu ifyou(instruction, targetInstr, imm16, clk, zero, branch, jump);
// Instruction Decode: input instruction; get pieces
instrdec indeck(instruction, opcode, Rs, Rt, Rd, Shamt, Funct);

// LUT for opcode to enables and such

// Operand Fetch
regfile reggie(ReadData1,ReadData2,WriteData,ReadRegister1,ReadRegister2,WriteRegister,RegWrite,Clk);
// Execute
alu ayylou(carryout,zero,overflow,result,operandA,operandB,command);
// Store to Mem
datamem deezmeme(clk, dataOut,address,writeEnable,dataIn);
// Next instruction
always @ (posedge clk) begin

end
endmodule
