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
    // Your code here
endmodule

module structuralDecoder(out, addr, enable);
output[7:0] out;
input[2:0] addr;
input enable;

wire[2:0] naddr;

`Not n0(naddr[0], addr[0]);
`Not n1(naddr[1], addr[1]);
`Not n2(naddr[2], addr[2]);

`And ag0(out[0],naddr[0],naddr[1],naddr[2],enable);
`And ag1(out[1],addr[0],naddr[1],naddr[2], enable);
`And ag2(out[2],naddr[0],addr[1],naddr[2], enable);
`And ag3(out[3],addr[0],addr[1],naddr[2], enable);
`And ag4(out[4],naddr[0],naddr[1],addr[2], enable);
`And ag5(out[5],addr[0],naddr[1],addr[2], enable);
`And ag6(out[6],naddr[0],addr[1],addr[2], enable);
`And ag7(out[7],addr[0],addr[1],addr[2], enable);
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

//wire midcarry;
//Adder addbit0(sum[0],midcarry,a[0],b[0],0);
//for (i = 1; i < 31; i = i +1) begin
//Adder addbit(sum[i],midcarry,a[i],b[i],midcarry);
//end
//wire pos2neg, neg2pos;
//wire na31, nb31, ns31;
//`Not notA31(na31, a[31]);
//`Not notB31(nb31, b[31]);
//`Not notS31(ns31, sum[31]);
//`And pos(pos2neg, a[31], b[31], ns31);
//`And neg(neg2pos, na3, nb31, sum[31]);
//`Or over(overflow, pos2neg, neg2pos);
//endmodule

//module Subtracter32bit(sum,carryout,overflow,a,b);
//  output[31:0] sum;  // 2's complement sum of a and b
//  output carryout;  // Carry out of the summation of a and b
//  output overflow;  // True if the calculation resulted in an overflow
//  input[31:0] a;     // First operand in 2's complement format
//  input[31:0] b;      // Second operand in 2's complement format
//
//wire midcarry;
//Subtracter subbit0(sum[0],midcarry,a[0],b[0],1);
//for (i = 1; i < 31; i = i +1) begin
//Subtracter subbit1(sum[i],midcarry,a[i],b[i],midcarry);
//end
//wire pos2neg, neg2pos;
//wire na31, nb31, ns31;
//`Not notA31(na31, a[31]);
//`Not notB31(nb31, b[31]);
//`Not notS31(ns31, sum[31]);
//`And pos(pos2neg, a[31], b[31], ns31);
//`And neg(neg2pos, na3, nb31, sum[31]);
//`Or over(overflow, pos2neg, neg2pos);
//endmodule

module SLT32bit(result,a,b);
  output[31:0] result;
  input[31:0] a;
  input[31:0] b;

//wire setcarry;
//wire[31:0] outcarry;
//SLT slt1(outcarry[0],setcarry,b[0],a[0],1);
//for (i = 1; i < 31; i = i +1) begin
//SLT slt(outcarry[i],setcarry,b[i],a[i],setcarry);
//end
//wire res;
//`Or resor(result[0],outcarry);
//endmodule

module testDecoder; 
reg addr[2:0];
reg enable;
wire out[7:0];
structuralDecoder decoder(out,addr,enable);
initial begin
$display("Structural Decoder");
$display("En A0 A1|| O0 O1 O2 O3 | Expected Output");
enable=0;addr[0]=0;addr[1]=0; addr[2]=0; #1000 
$display("%b  %b  %b %b ||  %b  %b  %b  %b %b  %b  %b  %b | All false", enable, addr[0], addr[1], addr[2], out[0], out[1], out[2], out[3], out[4], out[5], out[6], out[7]);
enable=0;addr[0]=0;addr[1]=0; addr[2]=0; #1000 
$display("%b  %b  %b %b ||  %b  %b  %b  %b %b  %b  %b  %b | All false", enable, addr[0], addr[1], addr[2], out[0], out[1], out[2], out[3], out[4], out[5], out[6], out[7]);
enable=0;addr[0]=0;addr[1]=0; addr[2]=0; #1000 
$display("%b  %b  %b %b ||  %b  %b  %b  %b %b  %b  %b  %b | All false", enable, addr[0], addr[1], addr[2], out[0], out[1], out[2], out[3], out[4], out[5], out[6], out[7]);
enable=0;addr[0]=0;addr[1]=0; addr[2]=0; #1000 
$display("%b  %b  %b %b ||  %b  %b  %b  %b %b  %b  %b  %b | All false", enable, addr[0], addr[1], addr[2], out[0], out[1], out[2], out[3], out[4], out[5], out[6], out[7]);
end
endmodule