`define Xor  xor  #20
`define And  and  #20
`define Nand nand #10
`define Nor  nor  #10
`define Or   or   #20
`define Not  not  #10
//Timing definitions

module xore
(
output reg carryout=0,
output reg overflow=0,
output[31:0] XorOut,
input [31:0] operandA,
input [31:0] operandB
);
// Handler for Xor gate function
genvar i;
for (i = 0; i < 32; i = i +1) begin
  `Xor(XorOut[i],operandA[i],operandB[i]); //Applies Xor to all 32 bits
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
// Handler for And gate function
genvar i;
for (i = 0; i < 32; i = i +1) begin
  `And(AndOut[i],operandA[i],operandB[i]); //Applies And to all 32 bits
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
// Handler for Nand gate function
genvar i;
for (i = 0; i < 32; i = i +1) begin
  `Nand(NandOut[i],operandA[i],operandB[i]); //Applies Nand to all 32 bits
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
// Handler for Nor gate function
genvar i;
for (i = 0; i < 32; i = i +1) begin
  `Nor(NorOut[i],operandA[i],operandB[i]); //Applies Nor to all 32 bits
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
// Handler for Or gate function
genvar i;
for (i = 0; i < 32; i = i +1) begin
  `Or(OrOut[i],operandA[i],operandB[i]); //Applies Or to all 32 bits
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
// Full adder module
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
// 32-bit adder module
wire pos2neg, neg2pos;
wire na31, nb31, ns31;
wire[31:0] Carry;
genvar i;
fulladder yoloswag(Carry[0], result[0], A[0], B[0], carry);
generate
    for(i=1; i<32; i=i+1)begin
      fulladder add32(Carry[i], result[i], A[i], B[i], Carry[i-1]); //Uses the adder to add all 32 bits
    end
endgenerate

//Determines Overflow 
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
// 32-bit subtracter
reg enable=1;
wire [31:0] newB;            
genvar j;
generate
    for (j=0; j<32; j=j+1) begin
      `Xor modB(newB[j], B[j], enable); //Inverts all the B values 
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
//32-bit Set-Less-Than module
wire [31:0] Sum;
wire over, carry;
genvar i;
sub getSLT(carry, over, Sum, A, B);
`Xor(result[0], over, Sum[31]); //Selects for highest bit and determines if A<B
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
// Alu module
wire[31:0] result0, result1, result2, result3, result4, result5, result6, result7;
wire of0, of1, of2, of3, of4, of5, of6, of7;
wire co0, co1, co2, co3, co4, co5, co6, co7;

//Runs each module and holds the values in independent wires
add added(co0, of0, result0, operandA, operandB, 0); 
sub subbed(co1, of1, result1, operandA, operandB);
xore xored(co2, of2, result2, operandA, operandB);
slt slted(co3, of3, result3, operandA, operandB);
ande anded(co4, of4, result4, operandA, operandB);
nande nanded(co5, of5, result5, operandA, operandB);
nore nored(co6, of6, result6, operandA, operandB);
ore ored(co7, of7, result7, operandA, operandB);

//MUX passes the desired result to the output with the command selector.\
always @ (command or operandA or operandB) begin
#11000 //Delay should be the longest time to completion for any one module in the ALU, most likely SLT
case (command) 
  0  : begin result = result0; carryout = co0; overflow = of0; end
  1  : begin result = result1; carryout = co1; overflow = of1; end
  2  : begin result = result2; carryout = co2; overflow = of2; end
  3  : begin result = result3; carryout = co3; overflow = of3; end
  4  : begin result = result4; carryout = co4; overflow = of4; end
  5  : begin result = result5; carryout = co5; overflow = of5; end
  6  : begin result = result6; carryout = co6; overflow = of6; end
  7  : begin result = result7; carryout = co7; overflow = of7; end
  default : $display("Error in ALU"); //Only triggers if command out of scope of ALU
endcase
end
`Nor zeronor(zero, result, overflow);    
endmodule

module testeverything; //Test Bench
wire[31:0] result, result0;
wire carryout, carry0, zero, overflow, overflow0;
reg[31:0] operandA, operandB;
reg[2:0] command;
reg carryin=0;

alu device(carryout, zero, overflow, result, operandA, operandB, command);
integer i;
initial begin //Test Bench display
$display("Structural ALU");
	$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
	//Testing doubles
	command = 000; operandA = 32'h00000000; operandB = 32'h00000000; #1000000 //All zero case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
	command = 000; operandA = 32'hffffffff; operandB = 32'hffffffff; #1000000 //Double negative case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111110", operandA, operandB, command, result, carryout, overflow, zero);
	command = 000; operandA = 32'h00000001; operandB = 32'h00000001; #1000000 //Double positive case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000010", operandA, operandB, command, result, carryout, overflow, zero);
	command = 000; operandA = 32'h9fffffff; operandB = 32'h9fffffff; #1000000 //Double negative with overflow posibility
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00111111111111111111111111111110", operandA, operandB, command, result, carryout, overflow, zero);
	command = 000; operandA = 32'h70000000; operandB = 32'h70000000; #1000000 //Double positive with overflow posibility
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 11100000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
	//Testing cases with zeros
	command = 000; operandA = 32'h00000001; operandB = 32'h00000000; #1000000 //Positive and zero case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000001", operandA, operandB, command, result, carryout, overflow, zero);
	command = 000; operandA = 32'h00000000; operandB = 32'h00000001; #1000000 //Same case, reverse order
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000001", operandA, operandB, command, result, carryout, overflow, zero);
	command = 000; operandA = 32'h00000000; operandB = 32'hffffffff; #1000000 //Negative and zero case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
	command = 000; operandA = 32'hffffffff; operandB = 32'h00000000; #1000000 //Same case, reverse order
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
	//Testing remaining cases
	command = 000; operandA = 32'hffffffff; operandB = 32'h00000001; #1000000 //Small negative and small positive case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
	command = 000; operandA = 32'h00000001; operandB = 32'hffffffff; #1000000 //Same case, reverse order
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
	command = 000; operandA = 32'hfffffff9; operandB = 32'h00000001; #1000000 //Large negative and small positive case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111010", operandA, operandB, command, result, carryout, overflow, zero);
	command = 000; operandA = 32'h10000000; operandB = 32'hfffffff9; #1000000 //Same case, reverse order 
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00001111111111111111111111111001", operandA, operandB, command, result, carryout, overflow, zero);
	command = 000; operandA = 32'h70000000; operandB = 32'hffffffff; #1000000 //Large positive and small negative case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 01101111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
	command = 000; operandA = 32'hffffffff; operandB = 32'h70000000; #1000000  //Same case, reverse order
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 01101111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
	command = 000; operandA = 32'h70000000; operandB = 32'h9fffffff; #1000000 //Large positive and large negative case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00001111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
	command = 000; operandA = 32'h9fffffff; operandB = 32'h70000000; #1000000  //Same case, reverse order
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00001111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
	//Testing doubles
	command = 001; operandA = 32'h00000000; operandB = 32'h00000000; #1000000 //All zero case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
	command = 001; operandA = 32'hffffffff; operandB = 32'hffffffff; #1000000 //Double negative case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
	command = 001; operandA = 32'h00000001; operandB = 32'h00000001; #1000000 //Double positive case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
	command = 001; operandA = 32'h9fffffff; operandB = 32'h9fffffff; #1000000 //Double negative with overflow posibility
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
	command = 001; operandA = 32'h70000000; operandB = 32'h70000000; #1000000 //Double positive with overflow posibility
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
	//Testing cases with zeros
	command = 001; operandA = 32'h00000001; operandB = 32'h00000000; #1000000 //Positive and zero case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000001", operandA, operandB, command, result, carryout, overflow, zero);
	command = 001; operandA = 32'h00000000; operandB = 32'h00000001; #1000000 //Same case, reverse order
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
	command = 001; operandA = 32'h00000000; operandB = 32'hffffffff; #1000000 //Negative and zero case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000001", operandA, operandB, command, result, carryout, overflow, zero);
	command = 001; operandA = 32'hffffffff; operandB = 32'h00000000; #1000000 //Same case, reverse order
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
	//Testing remaining cases
	command = 001; operandA = 32'hffffffff; operandB = 32'h00000001; #1000000 //Small negative and small positive case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111110", operandA, operandB, command, result, carryout, overflow, zero);
	command = 001; operandA = 32'h00000001; operandB = 32'hffffffff; #1000000 //Same case, reverse order
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000010", operandA, operandB, command, result, carryout, overflow, zero);
	command = 001; operandA = 32'hfffffff9; operandB = 32'h00000001; #1000000 //Large negative and small positive case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111000", operandA, operandB, command, result, carryout, overflow, zero);
	command = 001; operandA = 32'h10000000; operandB = 32'hfffffff9; #1000000 //Same case, reverse order 
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00010000000000000000000000000111", operandA, operandB, command, result, carryout, overflow, zero);
	command = 001; operandA = 32'h70000000; operandB = 32'hffffffff; #1000000 //Large positive and small negative case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 01110000000000000000000000000001", operandA, operandB, command, result, carryout, overflow, zero);
	command = 001; operandA = 32'hffffffff; operandB = 32'h70000000; #1000000  //Same case, reverse order
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 10001111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
	command = 001; operandA = 32'h70000000; operandB = 32'h9fffffff; #1000000 //Large positive and large negative case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 11010000000000000000000000000001", operandA, operandB, command, result, carryout, overflow, zero);
	command = 001; operandA = 32'h9fffffff; operandB = 32'h70000000; #1000000  //Same case, reverse order
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00101111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
  
$display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
	//Testing doubles
	command = 010; operandA = 32'h00000000; operandB = 32'h00000000; #1000000 //All zero case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
	command = 010; operandA = 32'hffffffff; operandB = 32'hffffffff; #1000000 //Double negative case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
	command = 010; operandA = 32'h00000001; operandB = 32'h00000001; #1000000 //Double positive case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
	command = 010; operandA = 32'h9fffffff; operandB = 32'h9fffffff; #1000000 //Double negative with overflow posibility
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
	command = 010; operandA = 32'h70000000; operandB = 32'h70000000; #1000000 //Double positive with overflow posibility
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
	//Testing cases with zeros
	command = 010; operandA = 32'h00000001; operandB = 32'h00000000; #1000000 //Positive and zero case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000001", operandA, operandB, command, result, carryout, overflow, zero);
	command = 010; operandA = 32'h00000000; operandB = 32'h00000001; #1000000 //Same case, reverse order
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000001", operandA, operandB, command, result, carryout, overflow, zero);
	command = 010; operandA = 32'h00000000; operandB = 32'hffffffff; #1000000 //Negative and zero case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
	command = 010; operandA = 32'hffffffff; operandB = 32'h00000000; #1000000 //Same case, reverse order
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
	//Testing remaining cases
	command = 010; operandA = 32'hffffffff; operandB = 32'h00000001; #1000000 //Small negative and small positive case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111110", operandA, operandB, command, result, carryout, overflow, zero);
	command = 010; operandA = 32'h00000001; operandB = 32'hffffffff; #1000000 //Same case, reverse order
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111110", operandA, operandB, command, result, carryout, overflow, zero);
	command = 010; operandA = 32'hfffffff9; operandB = 32'h00000001; #1000000 //Large negative and small positive case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 11101111111111111111111111111000", operandA, operandB, command, result, carryout, overflow, zero);
	command = 010; operandA = 32'h10000000; operandB = 32'hfffffff9; #1000000 //Same case, reverse order 
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 11101111111111111111111111111001", operandA, operandB, command, result, carryout, overflow, zero);
	command = 010; operandA = 32'h70000000; operandB = 32'hffffffff; #1000000 //Large positive and small negative case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 10001111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
	command = 010; operandA = 32'hffffffff; operandB = 32'h70000000; #1000000  //Same case, reverse order
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 10001111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
	command = 010; operandA = 32'h70000000; operandB = 32'h9fffffff; #1000000 //Large positive and large negative case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 11101111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
	command = 010; operandA = 32'h9fffffff; operandB = 32'h70000000; #1000000  //Same case, reverse order
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 11101111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
  $display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
	//Testing doubles
	command = 011; operandA = 32'h00000000; operandB = 32'h00000000; #1000000 //All zero case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
	command = 011; operandA = 32'hffffffff; operandB = 32'hffffffff; #1000000 //Double negative case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
	command = 011; operandA = 32'h00000001; operandB = 32'h00000001; #1000000 //Double positive case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
	command = 011; operandA = 32'h9fffffff; operandB = 32'h9fffffff; #1000000 //Double negative with overflow posibility
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
	command = 011; operandA = 32'h70000000; operandB = 32'h70000000; #1000000 //Double positive with overflow posibility
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
	//Testing cases with zeros
	command = 011; operandA = 32'h00000001; operandB = 32'h00000000; #1000000 //Positive and zero case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
	command = 011; operandA = 32'h00000000; operandB = 32'h00000001; #1000000 //Same case, reverse order
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000001", operandA, operandB, command, result, carryout, overflow, zero);
	command = 011; operandA = 32'h00000000; operandB = 32'hffffffff; #1000000 //Negative and zero case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
	command = 011; operandA = 32'hffffffff; operandB = 32'h00000000; #1000000 //Same case, reverse order
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000001", operandA, operandB, command, result, carryout, overflow, zero);
	//Testing remaining cases
	command = 011; operandA = 32'hffffffff; operandB = 32'h00000001; #1000000 //Small negative and small positive case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000001", operandA, operandB, command, result, carryout, overflow, zero);
	command = 011; operandA = 32'h00000001; operandB = 32'hffffffff; #1000000 //Same case, reverse order
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
	command = 011; operandA = 32'hfffffff9; operandB = 32'h00000001; #1000000 //Large negative and small positive case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000001", operandA, operandB, command, result, carryout, overflow, zero);
	command = 011; operandA = 32'h10000000; operandB = 32'hfffffff9; #1000000 //Same case, reverse order 
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
	command = 011; operandA = 32'h70000000; operandB = 32'hffffffff; #1000000 //Large positive and small negative case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
	command = 011; operandA = 32'hffffffff; operandB = 32'h70000000; #1000000  //Same case, reverse order
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000001", operandA, operandB, command, result, carryout, overflow, zero);
	command = 011; operandA = 32'h70000000; operandB = 32'h9fffffff; #1000000 //Large positive and large negative case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
	command = 011; operandA = 32'h9fffffff; operandB = 32'h70000000; #1000000  //Same case, reverse order
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000001", operandA, operandB, command, result, carryout, overflow, zero);
  $display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
	//Testing doubles
	command = 100; operandA = 32'h00000000; operandB = 32'h00000000; #1000000 //All zero case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
	command = 100; operandA = 32'hffffffff; operandB = 32'hffffffff; #1000000 //Double negative case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
	command = 100; operandA = 32'h00000001; operandB = 32'h00000001; #1000000 //Double positive case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000001", operandA, operandB, command, result, carryout, overflow, zero);
	command = 100; operandA = 32'h9fffffff; operandB = 32'h9fffffff; #1000000 //Double negative with overflow posibility
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 10011111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
	command = 100; operandA = 32'h70000000; operandB = 32'h70000000; #1000000 //Double positive with overflow posibility
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 01110000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
	//Testing cases with zeros
	command = 100; operandA = 32'h00000001; operandB = 32'h00000000; #1000000 //Positive and zero case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
	command = 100; operandA = 32'h00000000; operandB = 32'h00000001; #1000000 //Same case, reverse order
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
	command = 100; operandA = 32'h00000000; operandB = 32'hffffffff; #1000000 //Negative and zero case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
	command = 100; operandA = 32'hffffffff; operandB = 32'h00000000; #1000000 //Same case, reverse order
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
	//Testing remaining cases
	command = 100; operandA = 32'hffffffff; operandB = 32'h00000001; #1000000 //Small negative and small positive case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000001", operandA, operandB, command, result, carryout, overflow, zero);
	command = 100; operandA = 32'h00000001; operandB = 32'hffffffff; #1000000 //Same case, reverse order
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000001", operandA, operandB, command, result, carryout, overflow, zero);
	command = 100; operandA = 32'hfffffff9; operandB = 32'h00000001; #1000000 //Large negative and small positive case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000001", operandA, operandB, command, result, carryout, overflow, zero);
	command = 100; operandA = 32'h10000000; operandB = 32'hfffffff9; #1000000 //Same case, reverse order 
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00010000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
	command = 100; operandA = 32'h70000000; operandB = 32'hffffffff; #1000000 //Large positive and small negative case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 01110000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
	command = 100; operandA = 32'hffffffff; operandB = 32'h70000000; #1000000  //Same case, reverse order
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 01110000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
	command = 100; operandA = 32'h70000000; operandB = 32'h9fffffff; #1000000 //Large positive and large negative case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00010000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
	command = 100; operandA = 32'h9fffffff; operandB = 32'h70000000; #1000000  //Same case, reverse order
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00010000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
  $display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
	//Testing doubles
	command = 101; operandA = 32'h00000000; operandB = 32'h00000000; #1000000 //All zero case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
	command = 101; operandA = 32'hffffffff; operandB = 32'hffffffff; #1000000 //Double negative case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
	command = 101; operandA = 32'h00000001; operandB = 32'h00000001; #1000000 //Double positive case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111110", operandA, operandB, command, result, carryout, overflow, zero);
	command = 101; operandA = 32'h9fffffff; operandB = 32'h9fffffff; #1000000 //Double negative with overflow posibility
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 01100000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
	command = 101; operandA = 32'h70000000; operandB = 32'h70000000; #1000000 //Double positive with overflow posibility
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 10001111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
	//Testing cases with zeros
	command = 101; operandA = 32'h00000001; operandB = 32'h00000000; #1000000 //Positive and zero case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
	command = 101; operandA = 32'h00000000; operandB = 32'h00000001; #1000000 //Same case, reverse order
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
	command = 101; operandA = 32'h00000000; operandB = 32'hffffffff; #1000000 //Negative and zero case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
	command = 101; operandA = 32'hffffffff; operandB = 32'h00000000; #1000000 //Same case, reverse order
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
	//Testing remaining cases
	command = 101; operandA = 32'hffffffff; operandB = 32'h00000001; #1000000 //Small negative and small positive case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111110", operandA, operandB, command, result, carryout, overflow, zero);
	command = 101; operandA = 32'h00000001; operandB = 32'hffffffff; #1000000 //Same case, reverse order
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111110", operandA, operandB, command, result, carryout, overflow, zero);
	command = 101; operandA = 32'hfffffff9; operandB = 32'h00000001; #1000000 //Large negative and small positive case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111110", operandA, operandB, command, result, carryout, overflow, zero);
	command = 101; operandA = 32'h10000000; operandB = 32'hfffffff9; #1000000 //Same case, reverse order 
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 11101111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
	command = 101; operandA = 32'h70000000; operandB = 32'hffffffff; #1000000 //Large positive and small negative case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 10001111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
	command = 101; operandA = 32'hffffffff; operandB = 32'h70000000; #1000000  //Same case, reverse order
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 10001111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
	command = 101; operandA = 32'h70000000; operandB = 32'h9fffffff; #1000000 //Large positive and large negative case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 11101111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
	command = 101; operandA = 32'h9fffffff; operandB = 32'h70000000; #1000000  //Same case, reverse order
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 11101111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
  $display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
	//Testing doubles
	command = 110; operandA = 32'h00000000; operandB = 32'h00000000; #1000000 //All zero case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
	command = 110; operandA = 32'hffffffff; operandB = 32'hffffffff; #1000000 //Double negative case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
	command = 110; operandA = 32'h00000001; operandB = 32'h00000001; #1000000 //Double positive case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111110", operandA, operandB, command, result, carryout, overflow, zero);
	command = 110; operandA = 32'h9fffffff; operandB = 32'h9fffffff; #1000000 //Double negative with overflow posibility
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 01100000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
	command = 110; operandA = 32'h70000000; operandB = 32'h70000000; #1000000 //Double positive with overflow posibility
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 10001111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
	//Testing cases with zeros
	command = 110; operandA = 32'h00000001; operandB = 32'h00000000; #1000000 //Positive and zero case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111110", operandA, operandB, command, result, carryout, overflow, zero);
	command = 110; operandA = 32'h00000000; operandB = 32'h00000001; #1000000 //Same case, reverse order
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111110", operandA, operandB, command, result, carryout, overflow, zero);
	command = 110; operandA = 32'h00000000; operandB = 32'hffffffff; #1000000 //Negative and zero case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
	command = 110; operandA = 32'hffffffff; operandB = 32'h00000000; #1000000 //Same case, reverse order
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
	//Testing remaining cases
	command = 110; operandA = 32'hffffffff; operandB = 32'h00000001; #1000000 //Small negative and small positive case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
	command = 110; operandA = 32'h00000001; operandB = 32'hffffffff; #1000000 //Same case, reverse order
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
	command = 110; operandA = 32'hfffffff9; operandB = 32'h00000001; #1000000 //Large negative and small positive case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000110", operandA, operandB, command, result, carryout, overflow, zero);
	command = 110; operandA = 32'h10000000; operandB = 32'hfffffff9; #1000000 //Same case, reverse order 
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000110", operandA, operandB, command, result, carryout, overflow, zero);
	command = 110; operandA = 32'h70000000; operandB = 32'hffffffff; #1000000 //Large positive and small negative case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
	command = 110; operandA = 32'hffffffff; operandB = 32'h70000000; #1000000  //Same case, reverse order
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
	command = 110; operandA = 32'h70000000; operandB = 32'h9fffffff; #1000000 //Large positive and large negative case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
	command = 110; operandA = 32'h9fffffff; operandB = 32'h70000000; #1000000  //Same case, reverse order
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
  $display("            OperandA                          OperandB              COM ||               Result             ||  Co Of Zr | Expected Output");
	//Testing doubles
	command = 111; operandA = 32'h00000000; operandB = 32'h00000000; #1000000 //All zero case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
	command = 111; operandA = 32'hffffffff; operandB = 32'hffffffff; #1000000 //Double negative case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
	command = 111; operandA = 32'h00000001; operandB = 32'h00000001; #1000000 //Double positive case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000001", operandA, operandB, command, result, carryout, overflow, zero);
	command = 111; operandA = 32'h9fffffff; operandB = 32'h9fffffff; #1000000 //Double negative with overflow posibility
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 10011111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
	command = 111; operandA = 32'h70000000; operandB = 32'h70000000; #1000000 //Double positive with overflow posibility
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 01110000000000000000000000000000", operandA, operandB, command, result, carryout, overflow, zero);
	//Testing cases with zeros
	command = 111; operandA = 32'h00000001; operandB = 32'h00000000; #1000000 //Positive and zero case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000001", operandA, operandB, command, result, carryout, overflow, zero);
	command = 111; operandA = 32'h00000000; operandB = 32'h00000001; #1000000 //Same case, reverse order
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 00000000000000000000000000000001", operandA, operandB, command, result, carryout, overflow, zero);
	command = 111; operandA = 32'h00000000; operandB = 32'hffffffff; #1000000 //Negative and zero case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
	command = 111; operandA = 32'hffffffff; operandB = 32'h00000000; #1000000 //Same case, reverse order
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
	//Testing remaining cases
	command = 111; operandA = 32'hffffffff; operandB = 32'h00000001; #1000000 //Small negative and small positive case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
	command = 111; operandA = 32'h00000001; operandB = 32'hffffffff; #1000000 //Same case, reverse order
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
	command = 111; operandA = 32'hfffffff9; operandB = 32'h00000001; #1000000 //Large negative and small positive case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111001", operandA, operandB, command, result, carryout, overflow, zero);
	command = 111; operandA = 32'h10000000; operandB = 32'hfffffff9; #1000000 //Same case, reverse order 
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111001", operandA, operandB, command, result, carryout, overflow, zero);
	command = 111; operandA = 32'h70000000; operandB = 32'hffffffff; #1000000 //Large positive and small negative case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
	command = 111; operandA = 32'hffffffff; operandB = 32'h70000000; #1000000  //Same case, reverse order
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
	command = 111; operandA = 32'h70000000; operandB = 32'h9fffffff; #1000000 //Large positive and large negative case
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
	command = 111; operandA = 32'h9fffffff; operandB = 32'h70000000; #1000000  //Same case, reverse order
	$display("%b  %b  %b || %b ||  %b  %b  %b  | 11111111111111111111111111111111", operandA, operandB, command, result, carryout, overflow, zero);
 
end
endmodule