`define Xor  xor  #20
`define And  and  #20
`define Nand nand #10
`define Nor  nor  #10
`define Or   or   #20
`define Not  not  #10

module ALU(result,carryout,zero,overflow,operandA,operandB,command);

output[31:0]    result;
output          carryout;
output          zero;
output          overflow;
input[31:0]     operandA;
input[31:0]     operandB;
input[2:0]      command;

wire[7:0] out;

structrualDecoder decode(out, command);

genvar i;

if (out[0] == 1)
  Adder32bit(result,carryout,overflow,operandA,operandB);
if (out[1] == 1)
  Subtracter32bit(result,carryout,overflow,operandA,operandB);
if (out[2] == 1)
  for (i = 1; i < 31; i = i +1) begin
    `Xor(result[i],operandA[i],operandB[i]);
  end
if (out[3] == 1)
  SLT32bit(result,operandA,operandB);
if (out[4] == 1)
  for (i = 1; i < 31; i = i +1) begin
    `And(result[i],operandA[i],operandB[i]);
  end
if (out[5] == 1)
  for (i = 1; i < 31; i = i +1) begin
    `Nand(result[i],operandA[i],operandB[i]);
  end
if (out[6] == 1)
  for (i = 1; i < 31; i = i +1) begin
    `Nor(result[i],operandA[i],operandB[i]);
  end
if (out[7] == 1)
  for (i = 1; i < 31; i = i +1) begin
    `Or(result[i],operandA[i],operandB[i]);
  end

endmodule

module structuralDecoder(out, addr);
output[7:0] out;
input[2:0] addr;

wire[2:0] naddr;

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


module STL(out,seto,A,B,seti);
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
for (i = 1; i < 31; i = i +1) begin
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
for (i = 1; i < 31; i = i +1) begin
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
SLT slt1(outcarry[0],setcarry,b[0],a[0],1);
for (i = 1; i < 31; i = i +1) begin
SLT slt(outcarry[i],setcarry,b[i],a[i],setcarry);
end

`Or resor(result[0],outcarry);

endmodule

module testDecoder; 
wire[31:0] result;
wire 		carryout;
wire 		zero;
wire 		overflow;
reg[2:0] 	command;
reg[31:0]	operandA;
reg[31:0]	operandB;
ALU alu(result,carryout,zero,overflow,operandA,operandB,command);
initial begin
$display("Structural Decoder");
$display("OPA OPB COM || RES || Co Of Zr | Expected Output");
command = 3'b000; operandA = 8'h00000000; operandB = 8'h00000000; #1000 
$display("%b  %b  %b || %b ||  %b  %b  %b  | All false", operandA, operandB, command, result, carryout, overflow, zero);
end
endmodule
