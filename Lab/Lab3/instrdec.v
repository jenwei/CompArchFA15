module instrdec
(
input[31:0]	instr,
output reg[5:0]	opcode,
output reg[4:0]	Rs,
output reg[4:0]	Rt,
output reg[4:0]	Rd,
output reg[4:0]	Shamt,
output reg[5:0]	Funct
);

// takes 32-bit instruction and outputs control signals
always @(instr) begin 
	opcode <= instr[31:26];
	Rs <= instr[25:21];
	Rt <= instr[20:16];
	Rd <= instr[15:11];
	Shamt <= instr[10:6];
	Funct <= instr[5:0];
end
endmodule
