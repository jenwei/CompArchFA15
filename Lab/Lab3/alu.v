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
  xor(XorOut[i],operandA[i],operandB[i]); //Applies Xor to all 32 bits
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
  and(AndOut[i],operandA[i],operandB[i]); //Applies And to all 32 bits
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
  nand(NandOut[i],operandA[i],operandB[i]); //Applies Nand to all 32 bits
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
  nor(NorOut[i],operandA[i],operandB[i]); //Applies Nor to all 32 bits
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
  or(OrOut[i],operandA[i],operandB[i]); //Applies Or to all 32 bits
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
and andab(ab, a, b); //ab
xor xorg(axorb, a, b); //a xor b
and and2(two, carryin, axorb);
or or2(carryout, two, ab);
xor xor1(sum, axorb, carryin);
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
not notA31(na31, A[31]);
not notB31(nb31, B[31]);
not notS31(ns31, result[31]);
and pos(pos2neg, A[31], B[31], ns31);
and neg(neg2pos, na31, nb31, result[31]);
or over(overflow, pos2neg, neg2pos);
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
      xor modB(newB[j], B[j], enable); //Inverts all the B values 
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
xor(result[0], over, Sum[31]); //Selects for highest bit and determines if A<B
generate
for(i=1;i<32;i=i+1) begin
  assign {result[i]} = 0;
end
endgenerate
endmodule

module alu
(
output reg	carryout, 
output reg	zero, 
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
wire zeroadd, zeroslt, zerosub;

//Runs each module and holds the values in independent wires
add added(co0, of0, result0, operandA, operandB, 1'b0); 
nor zero0(zeroadd, result0, of0);

sub subbed(co1, of1, result1, operandA, operandB);
nor zero1(zerosub, result1, of1);

xore xored(co2, of2, result2, operandA, operandB);

slt slted(co3, of3, result3, operandA, operandB);
nor zero3(zeroslt, result3, of3);

ande anded(co4, of4, result4, operandA, operandB);

nande nanded(co5, of5, result5, operandA, operandB);

nore nored(co6, of6, result6, operandA, operandB);

ore ored(co7, of7, result7, operandA, operandB);

//MUX passes the desired result to the output with the command selector.\
always @ (command or operandA or operandB) begin
#100 //Delay should be the longest time to completion for any one module in the ALU, most likely SLT
case (command) 
  0  : begin result = result0; carryout = co0; overflow = of0; zero = zeroadd; end
  1  : begin result = result1; carryout = co1; overflow = of1; zero = zerosub; end
  2  : begin result = result2; carryout = 0; overflow = 0; zero = 0; end
  3  : begin result = result3; carryout = co3; overflow = of3; zero = zeroslt; end
  4  : begin result = result4; carryout = 0; overflow = 0; zero = 0; end
  5  : begin result = result5; carryout = 0; overflow = 0; zero = 0; end
  6  : begin result = result6; carryout = 0; overflow = 0; zero = 0; end
  7  : begin result = result7; carryout = 0; overflow = 0; zero = 0; end
  default : $display("Error in ALU"); //Only triggers if command out of scope of ALU
endcase
end 
endmodule

