module mux32(selected,inputA,inputB,select);
output[31:0] selected;
input select;
input[31:0] inputA;
input[31:0] inputB;

wire[31:0] m[1:0];

assign m[0] = inputA;
assign m[1] = inputB;

assign selected = m[select];
endmodule

module mux5(selected, inputA, inputB, select);
output[4:0] selected;
input select;
input[4:0] inputA;
input[4:0] inputB;

wire[4:0] m[1:0];

assign m[0] = inputA;
assign m[1] = inputB;

assign selected = m[select];
endmodule
