`define Xor  xor  #20
`define And  and  #20
`define Nand nand #10
`define Nor  nor  #10
`define Or   or   #20
`define Not  not  #10

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

wire[32:0] Carry;
genvar i;
assign {Carry[0]} = carry;

generate
begin: add_it_up
for(i=0; i<32; i=i+1)
fulladder yoloswag(Carry[i+1], Sum[i], A[i], B[i], Carry[i]);
end
endgenerate

assign {carryout} = Carry[32];
`Not notA31(na31, A[31]);
`Not notB31(nb31, B[31]);
`Not notS31(ns31, Sum[31]);
`And pos(pos2neg, A[31], B[31], ns31);
`And neg(neg2pos, na31, nb31, Sum[31]);
`Or over(overflow, pos2neg, neg2pos);
endmodule

module subtract32(carryout, overflow, Sum, A, B, enable);
input[31:0] A, B;
input enable;
output[31:0] Sum;
output carryout, overflow;
reg carry=1;
wire [31:0] newB;            
genvar j;
for (j=0; j<32; j=j+1) begin
`Xor modB(tempB[j], B[j], enable);
end
// TODO - DO ADDER32 WITH 1 AND TEMPB
// adder plusOne(carryout, overflow, newB, one, tempB, carry);
adder32 subToAdd(carryout, overflow, Sum, A, newB, carry);
endmodule

//module subtract32(yolo, A, B, enable);
//input[31:0] A, B;
//input enable;
//output[31:0] Sum;
//output carryout, overflow;
//wire[31:0] newB;            
//output[31:0] yolo;
//reg carry=1;
//genvar j;
//for (j=0; j<32; j=j+1) begin
//`Xor modB(yolo[j], B[j], enable);
//end
//adder32 subToAdd(carryout, overflow, Sum, A, newB, carry);
//assign {yolo} = newB;
//endmodule

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
reg enable = 0;
wire[31:0] Sum, SumTest, Dif, DifTest;
wire aco, acoT, aof, aofT, sco, scoT, sof, sofT;
integer i, j;

//adder32 adder(aco, aof, Sum, A, B, enable);
//behavioraladder32 testadder(acoT, aofT, SumTest, A, B);
subtract32 subtract(sco, sof, Dif, A, B, enable);
//behavioralsubtracter32 testsub(scoT, sofT, DifTest, A, B, enable);

initial begin: yolo
A=32'b00000000000000000000000000000000; B=32'b00000000000000000000000000000000;
// TO DO: TEST THAT ADDER32 WORKS FOR NEGATIVES
for (i=0; i<32; i=i+5) begin: swag
for (j=0; j<32; j=j+7) begin
A[i]=1; B[j]=1; #1000
$display("Test Sub | %b", Dif);
//$display("Test Add | %b", Sum);
end
end
end
endmodule
