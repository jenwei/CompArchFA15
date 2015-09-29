//adder.v
module FullAdder(out,carryout,a,b,carryin);
//Define gates with delays
`define And and #50
`define Or or #50
`define Nand nand #50
`define Not not #50
`define Xor xor #50
`define Nor nor #50
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
module FullAdder4bit(sum,carryout,overflow,a,b);
  output[3:0] sum;  // 2's complement sum of a and b
  output carryout;  // Carry out of the summation of a and b
  output overflow;  // True if the calculation resulted in an overflow
  input[3:0] a;     // First operand in 2's complement format
  input[3:0] b;      // Second operand in 2's complement format
`define And and #50
`define Or or #50
`define Nand nand #50
`define Not not #50
`define Xor xor #50
`define Nor nor #50
wire midcarry1, midcarry2, midcarry3;
wire pos2neg, neg2pos;
wire na3, nb3, ns3;

FullAdder addbit0(sum[0],midcarry1,a[0],b[0],0);
FullAdder addbit1(sum[1],midcarry2,a[1],b[1],midcarry1);
FullAdder addbit2(sum[2],midcarry3,a[2],b[2],midcarry2);
FullAdder addbit3(sum[3],carryout,a[3],b[3],midcarry3);
`Not notA3(na3, a[3]);
`Not notB3(nb3, b[3]);
`Not notS3(ns3, sum[3]);
`And pos(pos2neg, a[3], b[3], ns3);
`And neg(neg2pos, na3, nb3, sum[3]);
`Or over(overflow, pos2neg, neg2pos);
endmodule

module testFullAdder4bit;
reg[3:0] a;
reg[3:0] b;
wire[3:0] sum;
wire carryout, overflow;
FullAdder4bit adder(sum,carryout,overflow,a,b);
initial begin
$display("FullAdder4bit");
$display("a  | b  || sum | carryout | overflow || expected");
$display("Zero identities: no overflow");
a=4'b0000;b=4'b0000;#1000
$display(" %b %b || %b %b %b || 0000 0 0", a,b,sum,carryout,overflow);
a=4'b0000;b=4'b0001;#1000
$display(" %b %b || %b %b %b || 0001 0 0", a,b,sum,carryout,overflow);
a=4'b0000;b=4'b1111;#1000
$display(" %b %b || %b %b %b || 1111 0 0", a,b,sum,carryout,overflow);

$display("Pos+Pos");
a=4'b0100;b=4'b0011;#1000
$display(" %b %b || %b %b %b || 0111 0 0", a,b,sum,carryout,overflow);
a=4'b0111;b=4'b0111;#1000
$display(" %b %b || %b %b %b || 1110 0 1", a,b,sum,carryout,overflow);
a=4'b0101;b=4'b0001;#1000
$display(" %b %b || %b %b %b || 0110 0 0", a,b,sum,carryout,overflow);

$display("Pos+Neg: No overflow");
a=4'b0101;b=4'b1111;#1000
$display(" %b %b || %b %b %b || 0100 1 0", a,b,sum,carryout,overflow);
a=4'b1101;b=4'b0001;#1000
$display(" %b %b || %b %b %b || 1110 0 0", a,b,sum,carryout,overflow);
a=4'b0011;b=4'b1101;#1000
$display(" %b %b || %b %b %b || 0000 1 0", a,b,sum,carryout,overflow);

$display("Neg+Neg");
a=4'b1111;b=4'b1111;#1000
$display(" %b %b || %b %b %b || 1110 1 0", a,b,sum,carryout,overflow);
a=4'b1000;b=4'b1000;#1000
$display(" %b %b || %b %b %b || 0000 1 1", a,b,sum,carryout,overflow);
a=4'b1100;b=4'b1101;#1000
$display(" %b %b || %b %b %b || 1001 1 0", a,b,sum,carryout,overflow);
a=4'b1101;b=4'b1011;#1000
$display(" %b %b || %b %b %b || 1000 1 0", a,b,sum,carryout,overflow);

$display("Overflow");
a=4'b0101;b=4'b0111;#1000
$display(" %b %b || %b %b %b || 1100 0 1", a,b,sum,carryout,overflow);
a=4'b1000;b=4'b1111;#1000
$display(" %b %b || %b %b %b || 0111 1 1", a,b,sum,carryout,overflow);
a=4'b1001;b=4'b1010;#1000
$display(" %b %b || %b %b %b || 0011 1 1", a,b,sum,carryout,overflow);
end
endmodule
