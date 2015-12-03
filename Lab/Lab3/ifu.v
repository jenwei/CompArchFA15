// controls/updates program counter
module ifu(
input clk,
input zero,
input branch,
input jump,
input[25:0] targetInstr, //target address
input[15:0] imm16,
output[31:0] instr //address
);

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
	else begin //ELSE look to Branch or increment by 1
		if (branch && zero) begin //Take Branch route if branch and zero flag are True
			// pc <= pc + SignE[29:0] + 1;
			pc <= pc + 1 + {imm16[15], imm16[15], imm16[15], imm16[15], imm16[15], imm16[15], imm16[15], imm16[15], imm16[15], imm16[15], imm16[15], imm16[15], imm16[15], imm16[15], imm16}; 
		end
		else begin //Else increment pc by 1;
			pc <= pc + 1;
		end
	end
end
assign instr = {pc, 2'b00}; // Assign the instruction to instr and concatenate the missing '00' (essentially doing the +4 operation)

endmodule
