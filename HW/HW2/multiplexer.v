// define gates with delays
`define AND and #50
`define OR or #50
`define NOT not #50

module behavioralMultiplexer(out, address0,address1, in0,in1,in2,in3);
output out;
input address0, address1;
input in0, in1, in2, in3;
wire[3:0] inputs = {in3, in2, in1, in0};
wire[1:0] address = {address1, address0};
assign out = inputs[address];
endmodule

module structuralMultiplexer(out, address0,address1, in0,in1,in2,in3);
output out;
input address0, address1;
input in0, in1, in2, in3;

// nAddress1
wire nAddress1;
`NOT notAddress1(nAddress1, address1);

// nAddress0
wire nAddress0;
`NOT notAddress0(nAddress0, address0);

// AND Gates
wire and0,and1,and2,and3;
`AND andgate0(and0, in0, nAddress1, nAddress0);
`AND andgate1(and1, in1, nAddress1, address0);
`AND andgate2(and2, in2, address1, nAddress0);
`AND andgate3(and3, in3, address1, address0);

// OR Gate
`OR orgate0(out, and0, and1, and2, and3);

endmodule

module testMultiplexer;
reg addr0, addr1;
reg in0, in1, in2, in3;
wire out;
behavioralMultiplexer multiplexer (out, addr0, addr1, in0, in1, in2, in3);
// structuralMultiplexer multiplexer (out, addr0, addr1, in0, in1, in2, in3); // Swap after testing

initial begin
$display("S1 S0  | I0 I1 I2 I3 | Out | Expected Output");
addr1=0;addr0=0;in0=0;in1=1'bX;in2=1'bX;in3=1'bX; #800 
$display(" %b  %b  |  %b  %b  %b  %b |  %b  | 0", addr1, addr0, in0, in1, in2, in3, out);
addr1=0;addr0=0;in0=1;in1=1'bX;in2=1'bX;in3=1'bX; #800 
$display(" %b  %b  |  %b  %b  %b  %b |  %b  | 1", addr1, addr0, in0, in1, in2, in3, out);
addr1=0;addr0=1;in0=1'bX;in1=0;in2=1'bX;in3=1'bX; #800  
$display(" %b  %b  |  %b  %b  %b  %b |  %b  | 0", addr1, addr0, in0, in1, in2, in3, out);
addr1=0;addr0=1;in0=1'bX;in1=1;in2=1'bX;in3=1'bX; #800 
$display(" %b  %b  |  %b  %b  %b  %b |  %b  | 1", addr1, addr0, in0, in1, in2, in3, out);
addr1=1;addr0=0;in0=1'bX;in1=1'bX;in2=0;in3=1'bX; #800 
$display(" %b  %b  |  %b  %b  %b  %b |  %b  | 0", addr1, addr0, in0, in1, in2, in3, out);
addr1=1;addr0=0;in0=1'bX;in1=1'bX;in2=1;in3=1'bX; #800 
$display(" %b  %b  |  %b  %b  %b  %b |  %b  | 1", addr1, addr0, in0, in1, in2, in3, out);
addr1=1;addr0=1;in0=1'bX;in1=1'bX;in2=1'bX;in3=0; #800 
$display(" %b  %b  |  %b  %b  %b  %b |  %b  | 0", addr1, addr0, in0, in1, in2, in3, out);
addr1=1;addr0=1;in0=1'bX;in1=1'bX;in2=0;in3=1; #800 
$display(" %b  %b  |  %b  %b  %b  %b |  %b  | 1", addr1, addr0, in0, in1, in2, in3, out);
end

endmodule
