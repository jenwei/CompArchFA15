module ifu
(
output reg[31:0] 	instr,
input[25:0]	targetInstr,
input[15:0]	imm16,
input 		clk,
input		zero,
input		branch,
input		jump
);
// controls/updates program counter

reg[29:0] 	pc;
reg[32:0]	SignE;

signextend SEI(.imm16(imm16),.imm32(SignE));

always @(posedge clk) begin
	if (jump) begin //Take Jump route if True
		pc <= {pc[29:26], targetInstr};
	end
	else begin //Else look to Branch or increment by 1
		if (branch and zero) begin //Take Branch route if branch and zero flag are True
			pc <= pc + SignE[29:0] + 1;
		end
		else begin //Else increment by 1 pc
			pc <= pc + 1;
		end
	end
	instr <= {pc, 2'b00}; // Assign the instruction to instr and concatenate the missing '00'
end
endmodule
