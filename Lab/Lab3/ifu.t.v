module testIFU;
wire[31:0] instr;
reg[25:0] targetInstr;
reg[15:0] imm16;
reg clk;
reg zero;
reg branch;
reg jump;
reg dutpassed;

ifu DUT
  (
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

// test pc+4
branch = 0;	
zero = 0;
jump = 0;
imm16 = 16'b0;
targetInstr = 26'b0;
#20 
clk = 1;
#20
clk = 0;

if(instr != 32'd4) begin
	$display("BROKEN - PC+4 failed");
	dutpassed = 0;
end
else begin 
	$display("WORKS - PC+4 worked");
end

// test branch
branch = 1;
imm16 = 16'd56;
zero = 1;
#10 
clk = 1; 
#20 
clk = 0;
if(instr != 32'd60) begin
	$display("BROKEN - branch failed");
	dutpassed = 0;
end
else begin
	$display("WORKS - branch worked");
end

// test jump
branch = 0;
jump = 1;
targetInstr = 26'd150;
#10 
clk = 1; 
#20 
clk = 0;
if(instr != 26'd150) begin
	$display("BROKEN - jump failed");
	dutpassed = 0;
end
else begin
	$display("WORKS - jump worked");
end

$display("DUT Passed? %b", dutpassed);

end

endmodule

