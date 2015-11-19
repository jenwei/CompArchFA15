module testINSTRDEC;

reg[31:0]	instr;
wire[5:0]	opcode;
wire[4:0]	Rs;
wire[4:0]	Rt;
wire[4:0]	Rd;
wire[4:0]	Shamt;
wire[5:0]	Funct;

instrdec IST(.instr(instr),
		.opcode(opcode),
		.Rs(Rs),
		.Rt(Rt),
		.Rd(Rd),
		.Shamt(Shamt),
		.Funct(Funct));

integer i;

initial begin
	//$display("               Instr            || OP  | RS  | RT  | RD  |Shamt|Funct");
	for (i=0;i<1024;i=i+1) begin
		instr = i; 
		#10;
		if (opcode != instr[31:26]) begin
			$display("DUT did not pass test %d. The opcode did not match the instruction.",i);
			$stop;
		end
		else if (Rs != instr[25:21]) begin
			$display("DUT did not pass test %d. The RS value did not match the instruction.",i);
			$stop;
		end
		else if (Rt != instr[20:16]) begin
			$display("DUT did not pass test %d. The RT value did not match the instruction.",i);
			$stop;
		end
		else if (Rd != instr[15:11]) begin
			$display("DUT did not pass test %d. The RD value did not match the instruction.",i);
			$stop;
		end
		else if (Shamt != instr[10:6]) begin
			$display("DUT did not pass test %d. The shamt value did not match the instruction.",i);
			$stop;
		end
		else if (Funct != instr[5:0]) begin
			$display("DUT did not pass test %d. The function value did not match the instruction.",i);
			$stop;
		end
	//$display("%b||%b|%b|%b|%b|%b|%b",instr,opcode,Rs,Rt,Rd,Shamt,Funct);
	end
	$display("DUT PASSED");
	
end

endmodule
