module testLUT;

reg[5:0] 	opcode;
reg[5:0]	func;
wire RegDst; 	// 1 selects rt, 0 selects rd
wire[2:0] ALUcntrl;	// Runs off ALU command codes (Explained inline)
wire ALUsrc; 	// 1 loads from Db, 0 loads from Imm
wire MemtoReg; 	// 1 selects ALU Output, 0 selects Dout at addr of ALU out
wire MemWr;		// 1 enables writing, 0 blocks
wire RegWr; 		// 1 enables writing, 0 blocks
wire jmp;		// 1 enables jump, 0 does not
wire brch;		// 1 enables branch, 0 does not


lut lute(.opcode(opcode),.func(func),.RegDst(RegDst),.ALUcntrl(ALUcntrl),.ALUsrc(ALUsrc),.MemtoReg(MemtoReg),.MemWr(MemWr),.RegWr(RegWr),.jmp(jmp),.brch(brch));

initial begin
func = 6'b000000;
opcode = 6'b100011;
#100
$display("FUNCTION ||| alucntrl || aluSrc || RegWr || RegDst || MemWr || MemToReg ||| Expected ");
$display("LW  ||| %b %b %b %b %b %b ||| 000, 0, 0, 1, 0, 1", ALUcntrl, ALUsrc, RegWr, RegDst, MemWr, MemtoReg);
opcode = 6'b101011;
#100
$display("SW  ||| %b %b %b %b %b %b ||| 000, 0, 0, 0, 1, 1", ALUcntrl, ALUsrc, RegWr, RegDst, MemWr, MemtoReg);
opcode = 6'b000010;
#100
$display("J   ||| %b %b %b %b %b %b ||| 000, 0, 0, 0, 0, 0", ALUcntrl, ALUsrc, RegWr, RegDst, MemWr, MemtoReg);
opcode = 6'b000110;
#100
$display("JR  ||| %b %b %b %b %b %b ||| 000, 0, 0, 0, 0, 0", ALUcntrl, ALUsrc, RegWr, RegDst, MemWr, MemtoReg);
opcode = 6'b000011;
#100
$display("JAL ||| %b %b %b %b %b %b ||| 000, 0, 1, 0, 0, 0", ALUcntrl, ALUsrc, RegWr, RegDst, MemWr, MemtoReg);
opcode = 6'b000101;
#100
$display("BNE ||| %b %b %b %b %b %b ||| 001, 0, 0, 0, 0, 1", ALUcntrl, ALUsrc, RegWr, RegDst, MemWr, MemtoReg);
opcode = 6'b001110; 
#100
$display("XORI||| %b %b %b %b %b %b ||| 010, 0, 1, 1, 0, 0", ALUcntrl, ALUsrc, RegWr, RegDst, MemWr, MemtoReg);
opcode = 6'b000000; 
func = 6'b100000;
#100
$display("ADD ||| %b %b %b %b %b %b ||| 000, 1, 1, 0, 0, 1", ALUcntrl, ALUsrc, RegWr, RegDst, MemWr, MemtoReg);
opcode = 6'b000000;
func = 6'b100010;
#100
$display("SUB ||| %b %b %b %b %b %b ||| 001, 1, 1, 0, 0, 1", ALUcntrl, ALUsrc, RegWr, RegDst, MemWr, MemtoReg);
#100
opcode = 6'b000000;
func = 6'b101010;
#100
$display("SLT ||| %b %b %b %b %b %b ||| 011, 1, 1, 0, 0, 1", ALUcntrl, ALUsrc, RegWr, RegDst, MemWr, MemtoReg);
end
endmodule
