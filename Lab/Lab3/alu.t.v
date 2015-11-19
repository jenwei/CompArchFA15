module testALU;
wire[31:0] result, result0;
wire carryout, carry0, zero, overflow, overflow0;
reg[31:0] operandA, operandB;
reg[2:0] command;
reg carryin=0;

alu device(carryout, zero, overflow, result, operandA, operandB, command);
integer i;
reg[31:0] Expected;
initial begin //Test Bench display
//$display("Structural ALU");
	//$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
	//Testing doubles
	
	command = 000; operandA = 32'h00000000; operandB = 32'h00000000; #1000000 //All zero case
	Expected = 32'b00000000000000000000000000000000;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!"); 
		$stop;
	end

	command = 000; operandA = 32'hffffffff; operandB = 32'hffffffff; #1000000 //Double negative case
	Expected = 32'b11111111111111111111111111111110;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111110", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end

	command = 000; operandA = 32'h00000001; operandB = 32'h00000001; #1000000 //Double positive case
	Expected = 32'b00000000000000000000000000000010;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000010", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end
	

	command = 000; operandA = 32'h9fffffff; operandB = 32'h9fffffff; #1000000 //Double negative with overflow posibility
	Expected = 32'b00111111111111111111111111111110;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00111111111111111111111111111110", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end
	

	command = 000; operandA = 32'h70000000; operandB = 32'h70000000; #1000000 //Double positive with overflow posibility
	Expected = 32'b11100000000000000000000000000000;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 11100000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end
	

	//Testing cases with zeros
	command = 000; operandA = 32'h00000001; operandB = 32'h00000000; #1000000 //Positive and zero case
	Expected = 32'b00000000000000000000000000000001;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000001", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 000; operandA = 32'h00000000; operandB = 32'h00000001; #1000000 //Same case, reverse order
	Expected = 32'b00000000000000000000000000000001;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000001", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 000; operandA = 32'h00000000; operandB = 32'hffffffff; #1000000 //Negative and zero case
	Expected = 32'b11111111111111111111111111111111;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 000; operandA = 32'hffffffff; operandB = 32'h00000000; #1000000 //Same case, reverse order
	Expected = 32'b11111111111111111111111111111111;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	//Testing remaining cases
	command = 000; operandA = 32'hffffffff; operandB = 32'h00000001; #1000000 //Small negative and small positive case
	Expected = 32'b00000000000000000000000000000000;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 000; operandA = 32'h00000001; operandB = 32'hffffffff; #1000000 //Same case, reverse order
	Expected = 32'b00000000000000000000000000000000;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 000; operandA = 32'hfffffff9; operandB = 32'h00000001; #1000000 //Large negative and small positive case
	Expected = 32'b11111111111111111111111111111010;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111010", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 000; operandA = 32'h10000000; operandB = 32'hfffffff9; #1000000 //Same case, reverse order 
	Expected = 32'b00001111111111111111111111111001;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00001111111111111111111111111001", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 000; operandA = 32'h70000000; operandB = 32'hffffffff; #1000000 //Large positive and small negative case
	Expected = 32'b01101111111111111111111111111111;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 01101111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 000; operandA = 32'hffffffff; operandB = 32'h70000000; #1000000  //Same case, reverse order
	Expected = 32'b01101111111111111111111111111111;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 01101111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 000; operandA = 32'h70000000; operandB = 32'h9fffffff; #1000000 //Large positive and large negative case
	Expected = 32'b00001111111111111111111111111111;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00001111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 000; operandA = 32'h9fffffff; operandB = 32'h70000000; #1000000  //Same case, reverse order
	Expected = 32'b00001111111111111111111111111111;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00001111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
//$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
	//Testing doubles
	command = 001; operandA = 32'h00000000; operandB = 32'h00000000; #1000000 //All zero case
	Expected = 32'b00000000000000000000000000000000;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 001; operandA = 32'hffffffff; operandB = 32'hffffffff; #1000000 //Double negative case
	Expected = 32'b00000000000000000000000000000000;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 001; operandA = 32'h00000001; operandB = 32'h00000001; #1000000 //Double positive case
	Expected = 32'b00000000000000000000000000000000;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 001; operandA = 32'h9fffffff; operandB = 32'h9fffffff; #1000000 //Double negative with overflow posibility
	Expected = 32'b00000000000000000000000000000000;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 001; operandA = 32'h70000000; operandB = 32'h70000000; #1000000 //Double positive with overflow posibility
	Expected = 32'b00000000000000000000000000000000;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	//Testing cases with zeros
	command = 001; operandA = 32'h00000001; operandB = 32'h00000000; #1000000 //Positive and zero case
	Expected = 32'b00000000000000000000000000000001;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000001", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 001; operandA = 32'h00000000; operandB = 32'h00000001; #1000000 //Same case, reverse order
	Expected = 32'b11111111111111111111111111111111;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 001; operandA = 32'h00000000; operandB = 32'hffffffff; #1000000 //Negative and zero case
	Expected = 32'b00000000000000000000000000000001;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000001", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 001; operandA = 32'hffffffff; operandB = 32'h00000000; #1000000 //Same case, reverse order
	Expected = 32'b11111111111111111111111111111111;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	//Testing remaining cases
	command = 001; operandA = 32'hffffffff; operandB = 32'h00000001; #1000000 //Small negative and small positive case
	Expected = 32'b11111111111111111111111111111110;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111110", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 001; operandA = 32'h00000001; operandB = 32'hffffffff; #1000000 //Same case, reverse order
	Expected = 32'b00000000000000000000000000000010;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000010", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 001; operandA = 32'hfffffff9; operandB = 32'h00000001; #1000000 //Large negative and small positive case
	Expected = 32'b11111111111111111111111111111000;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111000", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 001; operandA = 32'h10000000; operandB = 32'hfffffff9; #1000000 //Same case, reverse order 
	Expected = 32'b00010000000000000000000000000111;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00010000000000000000000000000111", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 001; operandA = 32'h70000000; operandB = 32'hffffffff; #1000000 //Large positive and small negative case
	Expected = 32'b01110000000000000000000000000001;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 01110000000000000000000000000001", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 001; operandA = 32'hffffffff; operandB = 32'h70000000; #1000000  //Same case, reverse order
	Expected = 32'b10001111111111111111111111111111;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 10001111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 001; operandA = 32'h70000000; operandB = 32'h9fffffff; #1000000 //Large positive and large negative case
	Expected = 32'b11010000000000000000000000000001;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 11010000000000000000000000000001", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 001; operandA = 32'h9fffffff; operandB = 32'h70000000; #1000000  //Same case, reverse order
	Expected = 32'b00101111111111111111111111111111;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00101111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
  
//$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
	//Testing doubles
	command = 010; operandA = 32'h00000000; operandB = 32'h00000000; #1000000 //All zero case
	Expected = 32'b00000000000000000000000000000000;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 010; operandA = 32'hffffffff; operandB = 32'hffffffff; #1000000 //Double negative case
	Expected = 32'b00000000000000000000000000000000;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 010; operandA = 32'h00000001; operandB = 32'h00000001; #1000000 //Double positive case
	Expected = 32'b00000000000000000000000000000000;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 010; operandA = 32'h9fffffff; operandB = 32'h9fffffff; #1000000 //Double negative with overflow posibility
	Expected = 32'b00000000000000000000000000000000;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 010; operandA = 32'h70000000; operandB = 32'h70000000; #1000000 //Double positive with overflow posibility
	Expected = 32'b00000000000000000000000000000000;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	//Testing cases with zeros
	command = 010; operandA = 32'h00000001; operandB = 32'h00000000; #1000000 //Positive and zero case
	Expected = 32'b00000000000000000000000000000001;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000001", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 010; operandA = 32'h00000000; operandB = 32'h00000001; #1000000 //Same case, reverse order
	Expected = 32'b00000000000000000000000000000001;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000001", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 010; operandA = 32'h00000000; operandB = 32'hffffffff; #1000000 //Negative and zero case
	Expected = 32'b11111111111111111111111111111111;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 010; operandA = 32'hffffffff; operandB = 32'h00000000; #1000000 //Same case, reverse order
	Expected = 32'b11111111111111111111111111111111;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	//Testing remaining cases
	command = 010; operandA = 32'hffffffff; operandB = 32'h00000001; #1000000 //Small negative and small positive case
	Expected = 32'b11111111111111111111111111111110;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111110", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 010; operandA = 32'h00000001; operandB = 32'hffffffff; #1000000 //Same case, reverse order
	Expected = 32'b11111111111111111111111111111110;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111110", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 010; operandA = 32'hfffffff9; operandB = 32'h00000001; #1000000 //Large negative and small positive case
	Expected = 32'b11111111111111111111111111111000;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111000", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 010; operandA = 32'h10000000; operandB = 32'hfffffff9; #1000000 //Same case, reverse order 
	Expected = 32'b11101111111111111111111111111001;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 11101111111111111111111111111001", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 010; operandA = 32'h70000000; operandB = 32'hffffffff; #1000000 //Large positive and small negative case
	Expected = 32'b10001111111111111111111111111111;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 10001111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 010; operandA = 32'hffffffff; operandB = 32'h70000000; #1000000  //Same case, reverse order
	Expected = 32'b10001111111111111111111111111111;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 10001111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 010; operandA = 32'h70000000; operandB = 32'h9fffffff; #1000000 //Large positive and large negative case
	Expected = 32'b11101111111111111111111111111111;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 11101111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 010; operandA = 32'h9fffffff; operandB = 32'h70000000; #1000000  //Same case, reverse order
	Expected = 32'b11101111111111111111111111111111;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 11101111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
  //$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
	//Testing doubles
	command = 011; operandA = 32'h00000000; operandB = 32'h00000000; #1000000 //All zero case
	Expected = 32'b00000000000000000000000000000000;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 011; operandA = 32'hffffffff; operandB = 32'hffffffff; #1000000 //Double negative case
	Expected = 32'b00000000000000000000000000000000;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 011; operandA = 32'h00000001; operandB = 32'h00000001; #1000000 //Double positive case
	Expected = 32'b00000000000000000000000000000000;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 011; operandA = 32'h9fffffff; operandB = 32'h9fffffff; #1000000 //Double negative with overflow posibility
	Expected = 32'b00000000000000000000000000000000;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 011; operandA = 32'h70000000; operandB = 32'h70000000; #1000000 //Double positive with overflow posibility
	Expected = 32'b00000000000000000000000000000000;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	//Testing cases with zeros
	command = 011; operandA = 32'h00000001; operandB = 32'h00000000; #1000000 //Positive and zero case
	Expected = 32'b00000000000000000000000000000000;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 011; operandA = 32'h00000000; operandB = 32'h00000001; #1000000 //Same case, reverse order
	Expected = 32'b00000000000000000000000000000001;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000001", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 011; operandA = 32'h00000000; operandB = 32'hffffffff; #1000000 //Negative and zero case
	Expected = 32'b00000000000000000000000000000000;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 011; operandA = 32'hffffffff; operandB = 32'h00000000; #1000000 //Same case, reverse order
	Expected = 32'b00000000000000000000000000000001;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000001", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	//Testing remaining cases
	command = 011; operandA = 32'hffffffff; operandB = 32'h00000001; #1000000 //Small negative and small positive case
	Expected = 32'b00000000000000000000000000000001;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000001", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 011; operandA = 32'h00000001; operandB = 32'hffffffff; #1000000 //Same case, reverse order
	Expected = 32'b00000000000000000000000000000000;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 011; operandA = 32'hfffffff9; operandB = 32'h00000001; #1000000 //Large negative and small positive case
	Expected = 32'b00000000000000000000000000000001;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000001", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 011; operandA = 32'h10000000; operandB = 32'hfffffff9; #1000000 //Same case, reverse order 
	Expected = 32'b00000000000000000000000000000000;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 011; operandA = 32'h70000000; operandB = 32'hffffffff; #1000000 //Large positive and small negative case
	Expected = 32'b00000000000000000000000000000000;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 011; operandA = 32'hffffffff; operandB = 32'h70000000; #1000000  //Same case, reverse order
	Expected = 32'b00000000000000000000000000000001;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000001", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 011; operandA = 32'h70000000; operandB = 32'h9fffffff; #1000000 //Large positive and large negative case
	Expected = 32'b00000000000000000000000000000000;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 011; operandA = 32'h9fffffff; operandB = 32'h70000000; #1000000  //Same case, reverse order
	Expected = 32'b00000000000000000000000000000001;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000001", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
  //$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
	//Testing doubles
	command = 100; operandA = 32'h00000000; operandB = 32'h00000000; #1000000 //All zero case
	Expected = 32'b00000000000000000000000000000000;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 100; operandA = 32'hffffffff; operandB = 32'hffffffff; #1000000 //Double negative case
	Expected = 32'b11111111111111111111111111111111;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 100; operandA = 32'h00000001; operandB = 32'h00000001; #1000000 //Double positive case
	Expected = 32'b00000000000000000000000000000001;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000001", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 100; operandA = 32'h9fffffff; operandB = 32'h9fffffff; #1000000 //Double negative with overflow posibility
	Expected = 32'b10011111111111111111111111111111;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 10011111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 100; operandA = 32'h70000000; operandB = 32'h70000000; #1000000 //Double positive with overflow posibility
	Expected = 32'b01110000000000000000000000000000;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 01110000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	//Testing cases with zeros
	command = 100; operandA = 32'h00000001; operandB = 32'h00000000; #1000000 //Positive and zero case
	Expected = 32'b00000000000000000000000000000000;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 100; operandA = 32'h00000000; operandB = 32'h00000001; #1000000 //Same case, reverse order
	Expected = 32'b00000000000000000000000000000000;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 100; operandA = 32'h00000000; operandB = 32'hffffffff; #1000000 //Negative and zero case
	Expected = 32'b00000000000000000000000000000000;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 100; operandA = 32'hffffffff; operandB = 32'h00000000; #1000000 //Same case, reverse order
	Expected = 32'b00000000000000000000000000000000;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	//Testing remaining cases
	command = 100; operandA = 32'hffffffff; operandB = 32'h00000001; #1000000 //Small negative and small positive case
	Expected = 32'b00000000000000000000000000000001;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000001", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 100; operandA = 32'h00000001; operandB = 32'hffffffff; #1000000 //Same case, reverse order
	Expected = 32'b00000000000000000000000000000001;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000001", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 100; operandA = 32'hfffffff9; operandB = 32'h00000001; #1000000 //Large negative and small positive case
	Expected = 32'b00000000000000000000000000000001;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000001", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 100; operandA = 32'h10000000; operandB = 32'hfffffff9; #1000000 //Same case, reverse order 
	Expected = 32'b00010000000000000000000000000000;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00010000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 100; operandA = 32'h70000000; operandB = 32'hffffffff; #1000000 //Large positive and small negative case
	Expected = 32'b01110000000000000000000000000000;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 01110000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 100; operandA = 32'hffffffff; operandB = 32'h70000000; #1000000  //Same case, reverse order
	Expected = 32'b01110000000000000000000000000000;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 01110000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 100; operandA = 32'h70000000; operandB = 32'h9fffffff; #1000000 //Large positive and large negative case
	Expected = 32'b00010000000000000000000000000000;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00010000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 100; operandA = 32'h9fffffff; operandB = 32'h70000000; #1000000  //Same case, reverse order
	Expected = 32'b00010000000000000000000000000000;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00010000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
  //$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
	//Testing doubles
	command = 101; operandA = 32'h00000000; operandB = 32'h00000000; #1000000 //All zero case
	Expected = 32'b11111111111111111111111111111111;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 101; operandA = 32'hffffffff; operandB = 32'hffffffff; #1000000 //Double negative case
	Expected = 32'b00000000000000000000000000000000;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 101; operandA = 32'h00000001; operandB = 32'h00000001; #1000000 //Double positive case
	Expected = 32'b11111111111111111111111111111110;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111110", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 101; operandA = 32'h9fffffff; operandB = 32'h9fffffff; #1000000 //Double negative with overflow posibility
	Expected = 32'b01100000000000000000000000000000;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 01100000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 101; operandA = 32'h70000000; operandB = 32'h70000000; #1000000 //Double positive with overflow posibility
	Expected = 32'b10001111111111111111111111111111;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 10001111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	//Testing cases with zeros
	command = 101; operandA = 32'h00000001; operandB = 32'h00000000; #1000000 //Positive and zero case
	Expected = 32'b11111111111111111111111111111111;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 101; operandA = 32'h00000000; operandB = 32'h00000001; #1000000 //Same case, reverse order
	Expected = 32'b11111111111111111111111111111111;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 101; operandA = 32'h00000000; operandB = 32'hffffffff; #1000000 //Negative and zero case
	Expected = 32'b11111111111111111111111111111111;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 101; operandA = 32'hffffffff; operandB = 32'h00000000; #1000000 //Same case, reverse order
	Expected = 32'b11111111111111111111111111111111;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	//Testing remaining cases
	command = 101; operandA = 32'hffffffff; operandB = 32'h00000001; #1000000 //Small negative and small positive case
	Expected = 32'b11111111111111111111111111111110;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111110", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 101; operandA = 32'h00000001; operandB = 32'hffffffff; #1000000 //Same case, reverse order
	Expected = 32'b11111111111111111111111111111110;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111110", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 101; operandA = 32'hfffffff9; operandB = 32'h00000001; #1000000 //Large negative and small positive case
	Expected = 32'b11111111111111111111111111111110;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111110", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 101; operandA = 32'h10000000; operandB = 32'hfffffff9; #1000000 //Same case, reverse order 
	Expected = 32'b11101111111111111111111111111111;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 11101111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 101; operandA = 32'h70000000; operandB = 32'hffffffff; #1000000 //Large positive and small negative case
	Expected = 32'b10001111111111111111111111111111;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 10001111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 101; operandA = 32'hffffffff; operandB = 32'h70000000; #1000000  //Same case, reverse order
	Expected = 32'b10001111111111111111111111111111;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 10001111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 101; operandA = 32'h70000000; operandB = 32'h9fffffff; #1000000 //Large positive and large negative case
	Expected = 32'b11101111111111111111111111111111;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 11101111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 101; operandA = 32'h9fffffff; operandB = 32'h70000000; #1000000  //Same case, reverse order
	Expected = 32'b11101111111111111111111111111111;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 11101111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
  //$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
	//Testing doubles
	command = 110; operandA = 32'h00000000; operandB = 32'h00000000; #1000000 //All zero case
	Expected = 32'b11111111111111111111111111111111;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 110; operandA = 32'hffffffff; operandB = 32'hffffffff; #1000000 //Double negative case
	Expected = 32'b00000000000000000000000000000000;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 110; operandA = 32'h00000001; operandB = 32'h00000001; #1000000 //Double positive case
	Expected = 32'b11111111111111111111111111111110;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111110", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 110; operandA = 32'h9fffffff; operandB = 32'h9fffffff; #1000000 //Double negative with overflow posibility
	Expected = 32'b01100000000000000000000000000000;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 01100000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 110; operandA = 32'h70000000; operandB = 32'h70000000; #1000000 //Double positive with overflow posibility
	Expected = 32'b10001111111111111111111111111111;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 10001111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	//Testing cases with zeros
	command = 110; operandA = 32'h00000001; operandB = 32'h00000000; #1000000 //Positive and zero case
	Expected = 32'b11111111111111111111111111111110;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111110", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 110; operandA = 32'h00000000; operandB = 32'h00000001; #1000000 //Same case, reverse order
	Expected = 32'b11111111111111111111111111111110;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111110", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 110; operandA = 32'h00000000; operandB = 32'hffffffff; #1000000 //Negative and zero case
	Expected = 32'b00000000000000000000000000000000;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 110; operandA = 32'hffffffff; operandB = 32'h00000000; #1000000 //Same case, reverse order
	Expected = 32'b00000000000000000000000000000000;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	//Testing remaining cases
	command = 110; operandA = 32'hffffffff; operandB = 32'h00000001; #1000000 //Small negative and small positive case
	Expected = 32'b00000000000000000000000000000000;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 110; operandA = 32'h00000001; operandB = 32'hffffffff; #1000000 //Same case, reverse order
	Expected = 32'b00000000000000000000000000000000;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 110; operandA = 32'hfffffff9; operandB = 32'h00000001; #1000000 //Large negative and small positive case
	Expected = 32'b00000000000000000000000000000110;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000110", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 110; operandA = 32'h10000000; operandB = 32'hfffffff9; #1000000 //Same case, reverse order 
	Expected = 32'b00000000000000000000000000000110;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000110", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 110; operandA = 32'h70000000; operandB = 32'hffffffff; #1000000 //Large positive and small negative case
	Expected = 32'b00000000000000000000000000000000;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 110; operandA = 32'hffffffff; operandB = 32'h70000000; #1000000  //Same case, reverse order
	Expected = 32'b00000000000000000000000000000000;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 110; operandA = 32'h70000000; operandB = 32'h9fffffff; #1000000 //Large positive and large negative case
	Expected = 32'b00000000000000000000000000000000;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 110; operandA = 32'h9fffffff; operandB = 32'h70000000; #1000000  //Same case, reverse order
	Expected = 32'b00000000000000000000000000000000;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
  //$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
	//Testing doubles
	command = 111; operandA = 32'h00000000; operandB = 32'h00000000; #1000000 //All zero case
	Expected = 32'b00000000000000000000000000000000;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 111; operandA = 32'hffffffff; operandB = 32'hffffffff; #1000000 //Double negative case
	Expected = 32'b11111111111111111111111111111111;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 111; operandA = 32'h00000001; operandB = 32'h00000001; #1000000 //Double positive case
	Expected = 32'b00000000000000000000000000000001;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000001", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 111; operandA = 32'h9fffffff; operandB = 32'h9fffffff; #1000000 //Double negative with overflow posibility
	Expected = 32'b10011111111111111111111111111111;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 10011111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 111; operandA = 32'h70000000; operandB = 32'h70000000; #1000000 //Double positive with overflow posibility
	Expected = 32'b01110000000000000000000000000000;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 01110000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	//Testing cases with zeros
	command = 111; operandA = 32'h00000001; operandB = 32'h00000000; #1000000 //Positive and zero case
	Expected = 32'b00000000000000000000000000000001;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000001", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 111; operandA = 32'h00000000; operandB = 32'h00000001; #1000000 //Same case, reverse order
	Expected = 32'b00000000000000000000000000000001;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000001", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 111; operandA = 32'h00000000; operandB = 32'hffffffff; #1000000 //Negative and zero case
	Expected = 32'b11111111111111111111111111111111;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 111; operandA = 32'hffffffff; operandB = 32'h00000000; #1000000 //Same case, reverse order
	Expected = 32'b11111111111111111111111111111111;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	//Testing remaining cases
	command = 111; operandA = 32'hffffffff; operandB = 32'h00000001; #1000000 //Small negative and small positive case
	Expected = 32'b11111111111111111111111111111111;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 111; operandA = 32'h00000001; operandB = 32'hffffffff; #1000000 //Same case, reverse order
	Expected = 32'b11111111111111111111111111111111;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 111; operandA = 32'hfffffff9; operandB = 32'h00000001; #1000000 //Large negative and small positive case
	Expected = 32'b11111111111111111111111111111001;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111001", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 111; operandA = 32'h10000000; operandB = 32'hfffffff9; #1000000 //Same case, reverse order 
	Expected = 32'b11111111111111111111111111111001;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111001", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 111; operandA = 32'h70000000; operandB = 32'hffffffff; #1000000 //Large positive and small negative case
	Expected = 32'b11111111111111111111111111111111;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 111; operandA = 32'hffffffff; operandB = 32'h70000000; #1000000  //Same case, reverse order
	Expected = 32'b11111111111111111111111111111111;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 111; operandA = 32'h70000000; operandB = 32'h9fffffff; #1000000 //Large positive and large negative case
	Expected = 32'b11111111111111111111111111111111;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
	command = 111; operandA = 32'h9fffffff; operandB = 32'h70000000; #1000000  //Same case, reverse order
	Expected = 32'b11111111111111111111111111111111;
	if (result!=Expected) begin
		$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
		$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
		$display("Testing FAILED at above case!");
		$stop;
	end	
 $display("All tests PASSED!");
 $stop;
end
endmodule