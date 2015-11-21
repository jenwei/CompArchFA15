module testLUT;
reg[5:0] opcode, Funct;
wire alucntrl, aluSrc, RegWr, RegDst, MemWr, MemToReg;

lut lute(.ALUcntrl(aluCntrl), .ALUsrc(aluSrc), .RegWr(RegWr), .RegDst(RegDst), .MemWr(MemWr), .MemtoReg(MemToReg), .opcode(opcode), .func(Funct));

initial begin
Funct = 6'b000000;
opcode = 6'b100011;
#100
$display("FUNCTION ||| alucntrl || aluSrc || RegWr || RegDst || MemWr || MemToReg ||| Expected ");
$display("LW  ||| %b %b %b %b %b %b ||| 000, 0, 0, 1, 0, 1", alucntrl, aluSrc, RegWr, RegDst, MemWr, MemToReg);
opcode = 6'b101011;
#100
$display("SW  ||| %b %b %b %b %b %b ||| 000, 0, 0, 0, 1, 1", alucntrl, aluSrc, RegWr, RegDst, MemWr, MemToReg);
opcode = 6'b000010;
#100
$display("J   ||| %b %b %b %b %b %b ||| 000, 0, 0, 0, 0, 0", alucntrl, aluSrc, RegWr, RegDst, MemWr, MemToReg);
opcode = 6'b000110;
#100
$display("JR  ||| %b %b %b %b %b %b ||| 000, 0, 0, 0, 0, 0", alucntrl, aluSrc, RegWr, RegDst, MemWr, MemToReg);
opcode = 6'b000011;
#100
$display("JAL ||| %b %b %b %b %b %b ||| 000, 0, 1, 0, 0, 0", alucntrl, aluSrc, RegWr, RegDst, MemWr, MemToReg);
opcode = 6'b000101;
#100
$display("BNE ||| %b %b %b %b %b %b ||| 001, 0, 0, 0, 0, 1", alucntrl, aluSrc, RegWr, RegDst, MemWr, MemToReg);
opcode = 6'b001110; 
#100
$display("XORI||| %b %b %b %b %b %b ||| 010, 0, 1, 0, 0, 0", alucntrl, aluSrc, RegWr, RegDst, MemWr, MemToReg);
opcode = 6'b000000; 
Funct = 100000;
#100
$display("ADD ||| %b %b %b %b %b %b ||| 000, 1, 1, 1, 0, 1", alucntrl, aluSrc, RegWr, RegDst, MemWr, MemToReg);
Funct = 100010;
#100
$display("SUB ||| %b %b %b %b %b %b ||| 001, 1, 1, 1, 0, 1", alucntrl, aluSrc, RegWr, RegDst, MemWr, MemToReg);
Funct = 101010;
#100
$display("SLT ||| %b %b %b %b %b %b ||| 011, 1, 1, 1, 0, 1", alucntrl, aluSrc, RegWr, RegDst, MemWr, MemToReg);
end
endmodule
