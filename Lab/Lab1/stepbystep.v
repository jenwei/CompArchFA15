`define Xor  xor  #20
`define And  and  #20
`define Nand nand #10
`define Nor  nor  #10
`define Or   or   #20
`define Not  not  #10

module decoder(Out, Addr);
output[7:0] Out;
input[2:0] Addr;
wire[2:0] nAddr;
genvar j;
for (j=0; j<3; j=j+1) begin
`Not notyolo(nAddr[j], Addr[j]);
end

`And and0(Out[0], nAddr[2], nAddr[1], nAddr[0]);
`And and1(Out[1], nAddr[2], nAddr[1], Addr[0]);
`And and2(Out[2], nAddr[2], Addr[1], nAddr[0]);
`And and3(Out[3], nAddr[2], Addr[1], Addr[0]);
`And and4(Out[4], Addr[2], nAddr[1], nAddr[0]);
`And and5(Out[5], Addr[2], nAddr[1], Addr[0]);
`And and6(Out[6], Addr[2], Addr[1], nAddr[0]);
`And and7(Out[7], Addr[2], Addr[1], Addr[0]);

endmodule

module fulladder(carryout, sum, a, b, carryin);
input a, b, carryin;
output carryout, sum;

wire axorb;
wire ab, nanb;
wire two;

`And andab(ab, a, b); //ab
`Xor xorg(axorb, a, b); //a xor b

`And and2(two, carryin, axorb);
`Or or2(carryout, two, ab);
`Xor xor1(sum, axorb, carryin);
endmodule

module adder32(carryout, overflow, Sum, A, B, carry);
input[31:0] A, B;
output[31:0] Sum;
input carry;
output carryout, overflow;

wire pos2neg, neg2pos;
wire na31, nb31, ns31;

wire[31:0] Carry;
genvar i;
fulladder yoloswag(Carry[0], Sum[0], A[0], B[0], carry);
generate
begin: add_it_up
for(i=1; i<32; i=i+1)
fulladder yoloswag(Carry[i], Sum[i], A[i], B[i], Carry[i-1]);
end
endgenerate

assign {carryout} = Carry[31];
`Not notA31(na31, A[31]);
`Not notB31(nb31, B[31]);
`Not notS31(ns31, Sum[31]);
`And pos(pos2neg, A[31], B[31], ns31);
`And neg(neg2pos, na31, nb31, Sum[31]);
`Or over(overflow, pos2neg, neg2pos);
endmodule

module subtract32(carryout, overflow, Sum, A, B);
input[31:0] A, B;
output[31:0] Sum;
output carryout, overflow;
reg enable=1;
reg carry=1;

wire [31:0] newB;            
genvar j;

for (j=0; j<32; j=j+1) begin
`Xor modB(newB[j], B[j], enable);
end

adder32 subToAdd(carryout, overflow, Sum, A, newB, carry);

endmodule

module slt (carryout, A, B);
input [31:0] A, B;
output carryout;
wire [31:0] Sum;
wire overflow;
subtract32 getSLT(carryout, overflow, Sum, A, B);
endmodule


module behavioraladder32(carryout, overflow, Sum, A, B);
input [31:0] A, B;
output[31:0] Sum, overflow;
output carryout;
assign {carryout, Sum}=A+B;
assign overflow = (Sum[31] != carryout);
endmodule

module behavioralsubtracter32(carryout, Dif, A, B);
input[31:0] A,B;
output[31:0] Dif;
output carryout;
assign {Dif} = A-B;
assign {carryout} = A>B;
endmodule

module behavioralslt(out, A, B);
input[31:0] A,B;
output out;
assign {out} = (A<B);
endmodule

module behavioraldecoder(out, in);
input[3:0] in;
output[7:0] out;
genvar i;
for (i=0; i<8; i=i+1) begin
assign {out[i]}= (i == in);
end
endmodule

module testeverything;
reg[31:0] A, B;
wire[31:0] Sum, SumTest, Dif, DifTest;
reg[2:0] Addr;
wire[7:0] Out;
wire aco, acoT, aof, aofT, sco, scoT, sof, sofT;
integer i, j;

decoder DCD(Out, Addr);
//adder32 adder(aco, aof, Sum, A, B, enable);
//behavioraladder32 testadder(acoT, aofT, SumTest, A, B);
//slt leq(out, A, B);
//subtract32 subit(carryout, overflow, Dif, A, B);
//behavioralsubtracter32 testsub(scoT, sofT, DifTest, A, B, enable);

initial begin: yolo
//A=32'b11110000000000000000000000000000; B=32'b11110000000000000000000000000000;
Addr = 3'b000;
//for (i=0; i<32; i=i+5) begin: swag
for (j=0; j<3; j=j+1) begin
Addr[j] = 1; #500
//A[j]=1; B[j]=1; #100000
//$display("Test Sub | %b %b %b %b %b", out, carryout, out==carryout, aco, Dif);
$display("Test Add | %b", Out);
//end
end
end
endmodule
