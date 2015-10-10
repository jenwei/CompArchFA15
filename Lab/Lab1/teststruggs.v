`define Xor  xor  #20
`define And  and  #20
`define Nand nand #10
`define Nor  nor  #10
`define Or   or   #20
`define Not  not  #10

module behavioral(testout, in);
output[3:0] testout;
input[3:0] in;
assign testout[0]=in[0]+1;
assign testout[1]=in[1]+1;
assign testout[2]=in[2]+1;
assign testout[3]=in[3]+1;
endmodule

module struggle(swag, yolo);
input[3:0] yolo;
output[3:0] swag;

not n0(swag[0], yolo[0]);
not n1(swag[1], yolo[1]);
not n2(swag[2], yolo[2]);
not n3(swag[3], yolo[3]);

endmodule


module testest;
reg[3:0] in;
wire[3:0] out;
wire[3:0] testout;
integer i, j, k, l;
struggle andahalf(out, in);
behavioral basic(testout, in);
initial begin:yolo

for (i = 0; i < 2; i = i + 1) begin:yolo0
in[0] = i;#50
for (j = 0; j < 2; j = j + 1) begin:yolo1
in[1]=j;#50
for (k = 0; k < 2; k = k + 1) begin:yolo2
in[2]=k;#50
for (l = 0; l < 2; l = l + 1) begin:yolo3
in[3]= l;#1000
$display (out==testout);
end //yolo3
end //yolo2
end //yolo1
end //yolo0
end //yolo
endmodule
