`define Xor  xor  #20
`define And  and  #20
`define Nand nand #10
`define Nor  nor  #10
`define Or   or   #20
`define Not  not  #10


module xore
(
output reg carryout=0,
output reg overflow=0,
output[31:0] XorOut,
input [31:0] operandA,
input [31:0] operandB
);
genvar i;
for (i = 0; i < 32; i = i +1) begin
  `Xor(XorOut[i],operandA[i],operandB[i]);
end
endmodule

module ande
(
output reg carryout=0,
output reg overflow=0,
output[31:0] AndOut,
input [31:0] operandA,
input [31:0] operandB
);
genvar i;
for (i = 0; i < 32; i = i +1) begin
  `And(AndOut[i],operandA[i],operandB[i]);
end
endmodule

module nande
(
output reg carryout=0,
output reg overflow=0,
output[31:0] NandOut,
input [31:0] operandA,
input [31:0] operandB
);
genvar i;
for (i = 0; i < 32; i = i +1) begin
  `Nand(NandOut[i],operandA[i],operandB[i]);
end
endmodule

module nore
(
output reg carryout=0,
output reg overflow=0,
output[31:0] NorOut,
input [31:0] operandA,
input [31:0] operandB
);
genvar i;
for (i = 0; i < 32; i = i +1) begin
  `Nor(NorOut[i],operandA[i],operandB[i]);
end
endmodule

module ore
(
output reg carryout=0,
output reg overflow=0,
output[31:0] OrOut,
input [31:0] operandA,
input [31:0] operandB
);
genvar i;
for (i = 0; i < 32; i = i +1) begin
  `Or(OrOut[i],operandA[i],operandB[i]);
end
endmodule

module fulladder
(
output carryout, 
output sum, 
input a, 
input b, 
input carryin
);
wire axorb;
wire ab, nanb;
wire two;
`And andab(ab, a, b); //ab
`Xor xorg(axorb, a, b); //a xor b
`And and2(two, carryin, axorb);
`Or or2(carryout, two, ab);
`Xor xor1(sum, axorb, carryin);
endmodule

module add
(
output carryout,
output overflow,
output[31:0] result, 
input[31:0] A,
input[31:0] B,
input carry
);
wire pos2neg, neg2pos;
wire na31, nb31, ns31;
wire[31:0] Carry;
genvar i;
fulladder yoloswag(Carry[0], result[0], A[0], B[0], carry);
generate
    for(i=1; i<32; i=i+1)begin
      fulladder yoloswag(Carry[i], result[i], A[i], B[i], Carry[i-1]);
    end
endgenerate
assign {carryout} = Carry[31];
`Not notA31(na31, A[31]);
`Not notB31(nb31, B[31]);
`Not notS31(ns31, result[31]);
`And pos(pos2neg, A[31], B[31], ns31);
`And neg(neg2pos, na31, nb31, result[31]);
`Or over(overflow, pos2neg, neg2pos);
endmodule

module sub
(
output carryout,
output overflow,
output[31:0] result, 
input[31:0] A,
input[31:0] B
);
reg enable=1;
wire [31:0] newB;            
genvar j;
generate
    for (j=0; j<32; j=j+1) begin
      `Xor modB(newB[j], B[j], enable);
    end
endgenerate
add subToAdd(carryout, overflow, result, newB, A, enable);
endmodule



module slt
(
output reg carryout=0,
output reg overflow=0,
output[31:0] result,
input[31:0] A, 
input[31:0] B
);
wire [31:0] Sum;
wire deadover, deadcarry;
genvar i;
sub getSLT(deadcarry, deadover, Sum, A, B);
`Xor(result[0], deadover, Sum[31]);
generate
for(i=1;i<32;i=i+1) begin
  assign {result[i]} = 0;
end
endgenerate
endmodule

module alu
(
output reg	carryout, 
output		zero, 
output reg	overflow,
output reg[31:0]result,
input[31:0] 	operandA, 
input[31:0] 	operandB, 
input [2:0] 	command
);
//reg overflow, zero, carryout;
reg addcarry=0;
wire[31:0] result0; 
wire[31:0] result1, result2, result3, result4, result5, result6, result7;
wire of0, of1, of2, of3, of4, of5, of6, of7;
wire co0, co1, co2, co3, co4, co5, co6, co7;
genvar i;

add yolo(co0, of0, result0, operandA, operandB, addcarry);
sub swag(co1, of1, result1, operandA, operandB);
xore basic(co2, of2, result2, operandA, operandB);
slt swole(co3, of3, result3, operandA, operandB);
ande hash(co4, of4, result4, operandA, operandB);
nande tag(co5, of5, result5, operandA, operandB);
nore yekko(co6, of6, result6, operandA, operandB);
ore gains(co7, of7, result7, operandA, operandB);

always @ (command or operandA or operandB) begin
#11000
case (command) 
  0  : begin result = result0; carryout = co0; overflow = of0; end
  1  : begin result = result1; carryout = co1; overflow = of1; end
  2  : begin result = result2; carryout = co2; overflow = of2; end
  3  : begin result = result3; carryout = co3; overflow = of3; end
  4  : begin result = result4; carryout = co4; overflow = of4; end
  5  : begin result = result5; carryout = co5; overflow = of5; end
  6  : begin result = result6; carryout = co6; overflow = of6; end
  7  : begin result = result7; carryout = co7; overflow = of7; end
  default : $display("Error in ALU"); 
endcase
end
`Nor zeronor(zero, result, overflow, carryout);  
//result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7], result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15], result[16], result[17], result[18], result[19], result[20], result[21], result[22], result[23], result[24], result[25], result[26], result[27], result[28], result[29], result[30], result[31],  
endmodule

module testeverything;
wire[31:0] result, result0;
wire carryout, carry0, zero, overflow, overflow0;
reg[31:0] operandA, operandB;
reg[2:0] command;
reg carryin=0;

alu swagswag(carryout, zero, overflow, result, operandA, operandB, command);
//add yoloyolo(carry0, overflow0, result0, A, B, carryin);
integer i;
initial begin
//A=32'b10011101111100001000010111101000; B=32'b10000101111100001000010111110000;
//command = 3'b001; #100000000
//$display("Test ALU | %b %b %b %b", carry, zero, overflow, result);
//$display("Test ADD | %b %b %b", carry0, overflow0, result0);

$display("Structural ALU");
  for (i = 0; i < 8; i = i +1) begin
	$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
	//Testing doubles
	command = i; operandA = 32'h00000000; operandB = 32'h00000000; #1000000 //All zero case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | %b", operandA, operandB, command, result, carryout, overflow, zero, result);
	command = i; operandA = 32'hffffffff; operandB = 32'hffffffff; #1000000 //Double negative case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | %b", operandA, operandB, command, result, carryout, overflow, zero, result);
	command = i; operandA = 32'h00000001; operandB = 32'h00000001; #1000000 //Double positive case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | %b", operandA, operandB, command, result, carryout, overflow, zero, result);
	command = i; operandA = 32'h9fffffff; operandB = 32'h9fffffff; #1000000 //Double negative with overflow posibility
	$display("%b  %b  %b || %b ||  %b  %b  %b  | %b", operandA, operandB, command, result, carryout, overflow, zero, result);
	command = i; operandA = 32'h70000000; operandB = 32'h70000000; #1000000 //Double positive with overflow posibility
	$display("%b  %b  %b || %b ||  %b  %b  %b  | %b", operandA, operandB, command, result, carryout, overflow, zero, result);
	//Testing cases with zeros
	command = i; operandA = 32'h00000001; operandB = 32'h00000000; #1000000 //Positive and zero case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | %b", operandA, operandB, command, result, carryout, overflow, zero, result);
	command = i; operandA = 32'h00000000; operandB = 32'h00000001; #1000000 //Same case, reverse order
	$display("%b  %b  %b || %b ||  %b  %b  %b  | %b", operandA, operandB, command, result, carryout, overflow, zero, result);
	command = i; operandA = 32'h00000000; operandB = 32'hffffffff; #1000000 //Negative and zero case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | %b", operandA, operandB, command, result, carryout, overflow, zero, result);
	command = i; operandA = 32'hffffffff; operandB = 32'h00000000; #1000000 //Same case, reverse order
	$display("%b  %b  %b || %b ||  %b  %b  %b  | %b", operandA, operandB, command, result, carryout, overflow, zero, result);
	//Testing remaining cases
	command = i; operandA = 32'hffffffff; operandB = 32'h00000001; #1000000 //Small negative and small positive case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | %b", operandA, operandB, command, result, carryout, overflow, zero, result);
	command = i; operandA = 32'h00000001; operandB = 32'hffffffff; #1000000 //Same case, reverse order
	$display("%b  %b  %b || %b ||  %b  %b  %b  | %b", operandA, operandB, command, result, carryout, overflow, zero, result);
	command = i; operandA = 32'hfffffff9; operandB = 32'h00000001; #1000000 //Large negative and small positive case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | %b", operandA, operandB, command, result, carryout, overflow, zero, result);
	command = i; operandA = 32'h10000000; operandB = 32'hfffffff9; #1000000 //Same case, reverse order 
	$display("%b  %b  %b || %b ||  %b  %b  %b  | %b", operandA, operandB, command, result, carryout, overflow, zero, result);
	command = i; operandA = 32'h70000000; operandB = 32'hffffffff; #1000000 //Large positive and small negative case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | %b", operandA, operandB, command, result, carryout, overflow, zero, result);
	command = i; operandA = 32'hffffffff; operandB = 32'h70000000; #1000000  //Same case, reverse order
	$display("%b  %b  %b || %b ||  %b  %b  %b  | %b", operandA, operandB, command, result, carryout, overflow, zero, result);
	command = i; operandA = 32'h70000000; operandB = 32'h9fffffff; #1000000 //Large positive and large negative case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | %b", operandA, operandB, command, result, carryout, overflow, zero, result);
	command = i; operandA = 32'h9fffffff; operandB = 32'h70000000; #1000000  //Same case, reverse order
	$display("%b  %b  %b || %b ||  %b  %b  %b  | %b", operandA, operandB, command, result, carryout, overflow, zero, result);
  end

end
endmodule