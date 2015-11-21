module testIFU;
wire[31:0] instr;
reg[25:0] targetInstr;
reg[15:0] imm16;
reg clk;
reg zero;
reg branch;
reg jump;
reg dutpassed;

ifu DUT(
	.instr(instr),
	.targetInstr(targetInstr),
	.imm16(imm16),
	.clk(clk),
	.zero(zero),
	.branch(branch),
	.jump(jump)
);

initial begin
dutpassed = 1;
clk = 0;
// instr = 32'b0;

// TEST #1: PC+4
branch = 0;	
zero = 0;
jump = 0;
imm16 = 16'b0;
targetInstr = 26'b0;
#10
clk = 1;
#10
clk = 0;

$display("TEST 1: EXPECTED OUTPUT - d4");

if(instr != 32'd4) begin
	$display("PC+4 failed - OUTPUT %b",instr);
	dutpassed = 0;
end
else begin 
	$display("PC+4 worked - OUTPUT %b",instr);
end

// TEST #2: Branch from PC+4
branch = 1;
imm16 = 16'd3;
zero = 1;
#10
clk = 1; 
#10
clk = 0;

$display("TEST 2: INPUT - d3 EXPECTED OUTPUT - d20(d3*4+4 << 2)");

if(instr != 32'd20) begin
	$display("branch failed - OUTPUT %b",instr);
	dutpassed = 0;
end
else begin
	$display("branch worked - OUTPUT %b",instr);
end

// TEST #3: Jump from Branch
branch = 0;
jump = 1;
targetInstr = 26'd8;
#10
clk = 1; 
#10
clk = 0;

$display("TEST 3: INPUT - d8 EXPECTED OUTPUT - d32(d8 << 2)");
if(instr != 26'd32) begin
	$display("jump failed - OUTPUT %b",instr);
	dutpassed = 0;
end
else begin
	$display("jump worked - OUTPUT %b",instr);
end


// TEST #4: Branch from Jump
jump = 0;
branch = 1;
imm16 = 16'd16;
zero = 1;
#10
clk = 1; 
#10
clk = 0;
$display("TEST 4: INPUT - d16 EXPECTED OUTPUT - d100(d8+1+d16 << 2)");
if(instr != 32'd100) begin
	$display("branch failed - OUTPUT %b",instr);
	dutpassed = 0;
end
else begin
	$display("branch worked - OUTPUT %b",instr);
end

// TEST #5: PC + 4 from Branch
branch = 0;	
zero = 0;
jump = 0;
imm16 = 16'b0;
targetInstr = 26'b0;
#10
clk = 1;
#10
clk = 0;

$display("TEST 5: EXPECTED OUTPUT - d104");

if(instr != 32'd104) begin
	$display("BROKEN - PC+4 failed - OUTPUT %b",instr);
	dutpassed = 0;
end
else begin 
	$display("WORKS - PC+4 worked - OUTPUT %b",instr);
end

// FINAL DISPLAY
$display("DUT Passed? %b", dutpassed);
end

endmodule

