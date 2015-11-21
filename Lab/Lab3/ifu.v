module ifu(
input 		clk,
input		zero,
input		branch,
input		jump,
input[25:0]	targetInstr, //target address
input[15:0]	imm16,
output reg[31:0] instr //address
);
// controls/updates program counter

reg[29:0] 	pc = 30'b0;
wire[31:0]	SignE;

signextend SEI(
	.imm16(imm16),
	.imm32(SignE)
);

always @(posedge clk) begin
	if (jump) begin //Take Jump route if True
		pc <= {pc[29:26],targetInstr};
	end
	else begin //Else look to Branch or increment by 4
		if (branch && zero) begin //Take Branch route if branch and zero flag are True
			// pc <= pc + SignE[29:0] + 1;
			pc <= pc + 4 + {imm16[15], imm16[15], imm16[15], imm16[15], imm16[15], imm16[15], imm16[15], imm16[15], imm16[15], imm16[15], imm16[15], imm16[15], imm16[15], imm16[15], imm16}; 
		end
		else begin //Else increment pc by 4
			pc <= pc + 4;
		end
	end
	instr <= {pc, 2'b00}; // Assign the instruction to instr and concatenate the missing '00'
end
endmodule
