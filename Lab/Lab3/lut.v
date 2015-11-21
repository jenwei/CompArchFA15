module lut
(
input[5:0] 	opcode,
input[5:0]	func,
output reg 	RegDst, 	// 1 selects rt, 0 selects rd
output reg[2:0] ALUcntrl,
output reg 	ALUsrc, 	// 1 loads from Db, 0 loads from Imm
output reg 	MemtoReg, 	// 1 selects ALU Output, 0 selects Dout at addr of ALU out
output reg	MemWr, 
output reg 	RegWr, 		// 1 enable writng, 0 blocks
output reg	jmp,
output reg	brch
);
//Tracks state and controls enables
always @(opcode or func)begin
	case (opcode)
		6'd0:begin //R-Type, use Func to determine command
			case(func)
				6'd32:begin //Add
					RegDst = 0;
					RegWr = 1;
					ALUsrc = 1;
					MemtoReg = 1;
					MemWr = 0;
				end
				6'd34:begin //Subtract
					RegDst = 0;
					RegWr = 1;
					ALUsrc = 1;
					MemtoReg = 1;
					MemWr = 0;
				end
				6'd42:begin //Set Less Than
					RegDst = 0;
					RegWr = 1;
					ALUsrc = 1;
					MemtoReg = 1;
					MemWr = 0;
				end
				default:begin // Handles exceptions
					RegDst = 0;
					RegWr = 0;
					ALUsrc = 0;
					MemtoReg = 0;
					MemWr = 0;
					jmp = 0;
					brch =0;
				end
		end
		6'd2:begin // Jump
			RegWr = 0;
			MemtoReg = 0;
			MemWr = 0;
			jmp = 1;
		end
		6'd3:begin //Jump and Link
			RegWr = 0;
			MemtoReg = 0;
			MemWr = 0;
			jmp = 1;
		end
		6'd5:begin // Branch on Not Equal
			RegWr = 0;
			MemtoReg = 1;
			MemWr = 0;
			brch = 1;
		end
		6'd6:begin // Jump Register
			RegWr = 0;
			MemtoReg = 1;
			MemWr = 0;
			jmp = 1;
		end
		6'd14:begin // Exclusive Or Immediate
			RegDst = 1;
			RegWr = 1;
			ALUsrc = 0;
			MemtoReg = 1;
			MemWr = 0;
		end
		6'd35:begin // Load
			RegDst = 1;
			RegWr = 0;
			ALUsrc = 0;
			MemtoReg = 1;
			MemWr = 0;
		end
		6'd43:begin // Store
			RegWr = 0;
			ALUsrc = 0;
			MemtoReg = 1;
			MemWr = 1;
		end
		default:begin // Handles exceptions
			RegDst = 0;
			RegWr = 0;
			ALUsrc = 0;
			MemtoReg = 0;
			MemWr = 0;
			jmp = 0;
			brch =0;
		end
	
end
		

endmodule
