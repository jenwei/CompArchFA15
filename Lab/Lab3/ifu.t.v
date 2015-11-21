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

// test pc+4
branch = 0;	
zero = 0;
jump = 0;
imm16 = 16'b0;
targetInstr = 26'b0;
#1000
clk = 1;
#1000
clk = 0;

if(instr != 32'd4) begin
	$display("BROKEN - PC+4 failed - OUTPUT %b",instr);
	dutpassed = 0;
end
else begin 
	$display("WORKS - PC+4 worked - OUTPUT %b",instr);
end

// test branch
branch = 1;
imm16 = 16'd16;
zero = 1;
#1000
clk = 1; 
#1000
clk = 0;
if(instr != 32'd20) begin
	$display("BROKEN - branch failed - OUTPUT %b",instr);
	dutpassed = 0;
end
else begin
	$display("WORKS - branch worked - OUTPUT %b",instr);
end

// test jump
branch = 0;
jump = 1;
targetInstr = 26'd400;
#10000
clk = 1; 
#10000
clk = 0;
if(instr != 26'd150) begin
	$display("BROKEN - jump failed - OUTPUT %b",instr);
	dutpassed = 0;
end
else begin
	$display("WORKS - jump worked - OUTPUT %b",instr);
end

$display("DUT Passed? %b", dutpassed);

end

endmodule

