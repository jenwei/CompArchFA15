`define Xor  xor  #20
`define And  and  #20
`define Nand nand #10
`define Nor  nor  #10
`define Or   or   #20
`define Not  not  #10

`define ADD  3'd0
`define SUB  3'd1
`define XOR  3'd2
`define SLT  3'd3
`define AND  3'd4
`define NAND 3'd5
`define NOR  3'd6
`define OR   3'd7

module ALU(result,carryout,zero,overflow,operandA,operandB,command);

output reg[31:0]	result;
output          carryout;
output          zero;
output          overflow;
input[31:0]     operandA;
input[31:0]     operandB;
input[2:0]      command;

wire[7:0] out;

structuralDecoder decode(out, command);



wire[31:0] AddOut,SubOut,XorOut,SLTOut,AndOut,NandOut,NorOut,OrOut;

Adder32bit add(AddOut,carryout,overflow,operandA,operandB);
Subtracter32bit sub(SubOut,carryout,overflow,operandA,operandB);

genvar i;

for (i = 0; i < 32; i = i +1) begin
  `Xor(XorOut[i],operandA[i],operandB[i]);
end


SLT32bit slt(SLTOut,operandA,operandB);
for (i = 0; i < 32; i = i +1) begin
  `And(AndOut[i],operandA[i],operandB[i]);
end
for (i = 0; i < 32; i = i +1) begin
  `Nand(NandOut[i],operandA[i],operandB[i]);
end
for (i = 0; i < 32; i = i +1) begin
  `Nor(NorOut[i],operandA[i],operandB[i]);
end
for (i = 0; i < 32; i = i +1) begin
  `Or(OrOut[i],operandA[i],operandB[i]);
end

  always @(command) begin
    case (command)
	3'd0 : begin assign result = AddOut;	end
 	3'd1 : begin assign result = SubOut;	end
	3'd2 : begin assign result = XorOut;	end
 	3'd3 : begin assign result = SLTOut;	end
	3'd4 : begin assign result = AndOut;	end
 	3'd5 : begin assign result = NandOut;	end
	3'd6 : begin assign result = NorOut;	end
 	3'd7 : begin assign result = OrOut;	end
    endcase
  end

endmodule

module structuralDecoder(out, addr);
output[7:0] out;
input[2:0] addr;

wire[2:0] naddr;

wire[31:0] AdderOut,SubOut,XorOut,SLTOut,AndOut,Nandout,NorOut,OrOut;


`Not n0(naddr[0], addr[0]);
`Not n1(naddr[1], addr[1]);
`Not n2(naddr[2], addr[2]);

`And ag0(out[0],naddr[0],naddr[1],naddr[2]);
`And ag1(out[1],addr[0],naddr[1],naddr[2]);
`And ag2(out[2],naddr[0],addr[1],naddr[2]);
`And ag3(out[3],addr[0],addr[1],naddr[2]);
`And ag4(out[4],naddr[0],naddr[1],addr[2]);
`And ag5(out[5],addr[0],naddr[1],addr[2]);
`And ag6(out[6],naddr[0],addr[1],addr[2]);
`And ag7(out[7],addr[0],addr[1],addr[2]);
endmodule

module SLTbit(out,seto,A,B,seti);
output 		out;
output		seto;
input		A;
input		B;
input		seti;

wire nA;
`Not notA(nA,A);
`And SLTout(out,seti,nA,B);
`Xor set(seto,nA,B);

endmodule

module Adder(out,carryout,a,b,carryin);
output out, carryout;
input a, b, carryin;

wire axorb;
wire ab, nanb;
wire two;
`And andab(ab, a, b); 		//ab
`Not invab(nanb, ab); 		//a nor b
`Xor xorg(axorb, a, b); 	//a xor b
`And and2(two, carryin, axorb);
`Or or2(carryout, two, ab);
`Xor xor1(out, axorb, carryin);
endmodule

module Subtracter(out,carryout,a,b,carryin);
output out, carryout;
input a, b, carryin;

wire xb;
`Xor xorB(xb,b,1);

Adder add(out, carryout, a, xb, carryin);

endmodule

module Adder32bit(sum,carryout,overflow,a,b);
  output[31:0] sum;  // 2's complement sum of a and b
  output carryout;  // Carry out of the summation of a and b
  output overflow;  // True if the calculation resulted in an overflow
  input[31:0] a;     // First operand in 2's complement format
  input[31:0] b;      // Second operand in 2's complement format

genvar i;

wire midcarry;
Adder addbit0(sum[0],midcarry,a[0],b[0],0);
for (i = 0; i < 32; i = i +1) begin
Adder addbit(sum[i],midcarry,a[i],b[i],midcarry);
end
wire pos2neg, neg2pos;
wire na31, nb31, ns31;
`Not notA31(na31, a[31]);
`Not notB31(nb31, b[31]);
`Not notS31(ns31, sum[31]);
`And pos(pos2neg, a[31], b[31], ns31);
`And neg(neg2pos, na3, nb31, sum[31]);
`Or over(overflow, pos2neg, neg2pos);
endmodule



module Subtracter32bit(sum,carryout,overflow,a,b);
  output[31:0] sum;  // 2's complement sum of a and b
  output carryout;  // Carry out of the summation of a and b
  output overflow;  // True if the calculation resulted in an overflow
  input[31:0] a;     // First operand in 2's complement format
  input[31:0] b;      // Second operand in 2's complement format

genvar i;

wire midcarry;
Subtracter subbit0(sum[0],midcarry,a[0],b[0],1);
for (i = 0; i < 32; i = i +1) begin
Subtracter subbit(sum[i],midcarry,a[i],b[i],midcarry);
end
wire pos2neg, neg2pos;
wire na31, nb31, ns31;
`Not notA31(na31, a[31]);
`Not notB31(nb31, b[31]);
`Not notS31(ns31, sum[31]);
`And pos(pos2neg, a[31], b[31], ns31);
`And neg(neg2pos, na3, nb31, sum[31]);
`Or over(overflow, pos2neg, neg2pos);
endmodule

module SLT32bit(result,a,b);
  output[31:0] result;
  input[31:0] a;
  input[31:0] b;

genvar i;

wire setcarry;
wire[31:0] outcarry;
SLTbit slt1(outcarry[0],setcarry,b[0],a[0],1);
for (i = 0; i < 32; i = i +1) begin
SLTbit slt(outcarry[i],setcarry,b[i],a[i],setcarry);
end

`Or resor(result[0],outcarry);

endmodule

module testALU; 
wire[31:0] result;
wire 		carryout;
wire 		zero;
wire 		overflow;
reg[2:0] 	command;
reg[31:0]	operandA;
reg[31:0]	operandB;
ALU alu(result,carryout,zero,overflow,operandA,operandB,command);

integer i;

initial begin
  $display("Structural ALU");
  for (i = 0; i < 8; i = i +1) begin
	$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
	//Testing doubles
	command = i; operandA = 32'h00000000; operandB = 32'h00000000; #10000 //All zero case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | All false", operandA, operandB, command, result, carryout, overflow, zero);
	command = i; operandA = 32'hffffffff; operandB = 32'hffffffff; #10000 //Double negative case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | All false", operandA, operandB, command, result, carryout, overflow, zero);
	command = i; operandA = 32'h00000001; operandB = 32'h00000001; #10000 //Double positive case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | All false", operandA, operandB, command, result, carryout, overflow, zero);
	command = i; operandA = 32'h9fffffff; operandB = 32'h9fffffff; #10000 //Double negative with overflow posibility
	$display("%b  %b  %b || %b ||  %b  %b  %b  | All false", operandA, operandB, command, result, carryout, overflow, zero);
	command = i; operandA = 32'h70000000; operandB = 32'h70000000; #10000 //Double positive with overflow posibility
	$display("%b  %b  %b || %b ||  %b  %b  %b  | All false", operandA, operandB, command, result, carryout, overflow, zero);
	//Testing cases with zeros
	command = i; operandA = 32'h00000001; operandB = 32'h00000000; #10000 //Positive and zero case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | All false", operandA, operandB, command, result, carryout, overflow, zero);
	command = i; operandA = 32'h00000000; operandB = 32'h00000001; #10000 //Same case, reverse order
	$display("%b  %b  %b || %b ||  %b  %b  %b  | All false", operandA, operandB, command, result, carryout, overflow, zero);
	command = i; operandA = 32'h00000000; operandB = 32'hffffffff; #10000 //Negative and zero case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | All false", operandA, operandB, command, result, carryout, overflow, zero);
	command = i; operandA = 32'hffffffff; operandB = 32'h00000000; #10000 //Same case, reverse order
	$display("%b  %b  %b || %b ||  %b  %b  %b  | All false", operandA, operandB, command, result, carryout, overflow, zero);
	//Testing remaining cases
	command = i; operandA = 32'hffffffff; operandB = 32'h00000001; #10000 //Small negative and small positive case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | All false", operandA, operandB, command, result, carryout, overflow, zero);
	command = i; operandA = 32'h00000001; operandB = 32'hffffffff; #10000 //Same case, reverse order
	$display("%b  %b  %b || %b ||  %b  %b  %b  | All false", operandA, operandB, command, result, carryout, overflow, zero);
	command = i; operandA = 32'hfffffff9; operandB = 32'h00000001; #10000 //Large negative and small positive case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | All false", operandA, operandB, command, result, carryout, overflow, zero);
	command = i; operandA = 32'h10000000; operandB = 32'hfffffff9; #10000 //Same case, reverse order 
	$display("%b  %b  %b || %b ||  %b  %b  %b  | All false", operandA, operandB, command, result, carryout, overflow, zero);
	command = i; operandA = 32'h70000000; operandB = 32'hffffffff; #10000 //Large positive and small negative case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | All false", operandA, operandB, command, result, carryout, overflow, zero);
	command = i; operandA = 32'hffffffff; operandB = 32'h70000000; #10000  //Same case, reverse order
	$display("%b  %b  %b || %b ||  %b  %b  %b  | All false", operandA, operandB, command, result, carryout, overflow, zero);
	command = i; operandA = 32'h70000000; operandB = 32'h9fffffff; #10000 //Large positive and large negative case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | All false", operandA, operandB, command, result, carryout, overflow, zero);
	command = i; operandA = 32'h9fffffff; operandB = 32'h70000000; #10000  //Same case, reverse order
	$display("%b  %b  %b || %b ||  %b  %b  %b  | All false", operandA, operandB, command, result, carryout, overflow, zero);
  end
end
endmodule
