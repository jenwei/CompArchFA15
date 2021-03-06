module lut
(
input[5:0] 	opcode,
input[5:0]	func,
output reg 	RegDst, 	// 1 selects rt, 0 selects rd
output reg[2:0] ALUcntrl,	// Runs off ALU command codes (Explained inline)
output reg 	ALUsrc, 	// 1 loads from Db, 0 loads from Imm
output reg 	MemtoReg, 	// 1 selects ALU Output, 0 selects Dout at addr of ALU out
output reg	MemWr,		// 1 enables writing, 0 blocks
output reg 	RegWr, 		// 1 enables writing, 0 blocks
output reg	jmp,		// 1 enables jump, 0 does not
output reg	brch		// 1 enables branch, 0 does not
);
//Tracks state and controls enables
always @(opcode or func)  begin
	case (opcode)
		6'b000000: begin //R-Type, use Func to determine command
			if (func == 6'b100000) begin //Add
				RegDst <= 0;
				RegWr <= 1;
				ALUsrc <= 1;
				ALUcntrl <= 3'b000; // ADD code
				MemtoReg <= 1;
				MemWr <= 0;
				jmp <= 0;
				brch <= 0;
			end
			else if (func == 6'b100010) begin //Subtract
				RegDst <= 0;
				RegWr <= 1;
				ALUsrc <= 1;
				ALUcntrl <= 3'b001; // Subtract Code
				MemtoReg <= 1;
				MemWr <= 0;
				jmp <= 0;
				brch <= 0;
			end
			else if (func == 6'b101010)begin //Set Less Than
				RegDst <= 0;
				RegWr <= 1;
				ALUsrc <= 1;
				ALUcntrl <= 3'b011; // SLT code
				MemtoReg <= 1;
				MemWr <= 0;
				jmp <= 0;
				brch <= 0;
			end
			else begin // Handles exceptions
				RegDst <= 0;
				RegWr <= 0; // Do not allow write to Reg
				ALUsrc <= 0;
				ALUcntrl <= 3'b000;
				MemtoReg <= 0;
				MemWr <= 0; // Do not allow write to dataMem
				jmp <= 0; // Do not jump
				brch <= 0; // Do not branch
			end
		end
		6'b000010: begin // Jump
			RegDst <= 0; //x
			RegWr <= 0;
			ALUsrc <= 0; //x
			ALUcntrl <= 3'b000;
			MemtoReg <= 0; //x 
			MemWr <= 0;
			jmp <= 1; // Allow jump
			brch <= 0;
		end
		6'b000011: begin //Jump and Link
			RegDst <= 0;
			RegWr <= 0; //1
			ALUsrc <= 0; //x
			ALUcntrl <= 3'b000; //x
			MemtoReg <= 0;
			MemWr <= 0;
			jmp <= 1; // Allow jump
			brch <= 0;
		end
		6'b000101: begin // Branch on Not Equal
			RegDst <= 0;
			RegWr <= 0;
			ALUsrc <= 0;
			ALUcntrl <= 3'b001; // Subtract to test inequality
			MemtoReg <= 1; //x
			MemWr <= 0;
			jmp <= 0;
			brch <= 1; // Allow branch
		end
		6'b000110: begin // Jump Register
			RegDst <= 0;
			RegWr <= 0;
			ALUsrc <= 0;
			ALUcntrl <= 3'b000;
			MemtoReg <= 0;
			MemWr <= 0;
			jmp <= 1; // Aloow jump
			brch <= 0;
		end
		6'b001110: begin // Exclusive Or Immediate
			RegDst <= 1;
			RegWr <= 1;
			ALUsrc <= 0;
			ALUcntrl <= 3'b010; // XOR code
			MemtoReg <= 1;
			MemWr <= 0;
			jmp <= 0;
			brch <= 0;
		end
		6'b100011: begin // Load
			RegDst <= 1; //0
			RegWr <= 0; //1
			ALUsrc <= 0; //1
			ALUcntrl <= 3'b000;
			MemtoReg <= 1;
			MemWr <= 0; 
			jmp <= 0;
			brch <= 0;
		end
		6'b101011: begin // Store
			RegDst <= 0; //x
			RegWr <= 0; 
			ALUsrc <= 0; //1
			ALUcntrl <= 3'b000;
			MemtoReg <= 1; //x
			MemWr <= 1;
			jmp <= 0;
			brch <= 0;
		end
		default: begin // Handles exceptions
			RegDst <= 0;
			RegWr <= 0; // Do not allow write to Reg
			ALUsrc <= 0;
			ALUcntrl <= 3'b000;
			MemtoReg <= 0;
			MemWr <= 0; // Do not allow write to dataMem
			jmp <= 0; // Do not jump
			brch <= 0; // Do not branch
		end
	endcase
end
		

endmodule
