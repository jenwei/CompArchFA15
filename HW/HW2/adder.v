// define gates with delays
`define AND and #50
`define OR or #50
`define NOT not #50
`define XOR xor #50

module behavioralFullAdder(sum, carryout, a, b, carryin);
output sum, carryout;
input a, b, carryin;
assign {carryout, sum}=a+b+carryin;
endmodule

module structuralFullAdder(out, carryout, a, b, carryin);
output out, carryout;
input a, b, carryin;


// Wires
wire aXORb, aANDb, aXORb_and_carryin;

// Sum Gates
`XOR xorgate0(aXORb, a, b);
`XOR xorgate1(out, aXORb, carryin);

// Carryout Gates
`AND andgate0(aXORb_and_carryin, aXORb, carryin);
`AND andgate1(aANDb, a, b);
`OR orgate0(carryout, aXORb_and_carryin, aANDb);

endmodule

module testFullAdder;
reg a, b, carryin;
wire sum, carryout;
// behavioralFullAdder adder (sum, carryout, a, b, carryin);
structuralFullAdder adder (sum, carryout, a, b, carryin); // Swap after testing
initial begin
$display("A B C_in|  S  C_out | Expected Output");
a=0;b=0;carryin=0; #1000 
$display("%b  %b  %b |  %b   %b    | Both False", a, b, carryin, sum, carryout);
a=0;b=0;carryin=1; #1000 
$display("%b  %b  %b |  %b   %b    | Sum Only", a, b, carryin, sum, carryout);
a=0;b=1;carryin=0; #1000 
$display("%b  %b  %b |  %b   %b    | Sum Only", a, b, carryin, sum, carryout);
a=0;b=1;carryin=1; #1000 
$display("%b  %b  %b |  %b   %b    | Carryout Only", a, b, carryin, sum, carryout);
a=1;b=0;carryin=0; #1000 
$display("%b  %b  %b |  %b   %b    | Sum Only", a, b, carryin, sum, carryout);
a=1;b=0;carryin=1; #1000 
$display("%b  %b  %b |  %b   %b    | Carryout Only", a, b, carryin, sum, carryout);
a=1;b=1;carryin=0; #1000 
$display("%b  %b  %b |  %b   %b    | Carryout Only", a, b, carryin, sum, carryout);
a=1;b=1;carryin=1; #1000 
$display("%b  %b  %b |  %b   %b    | Both True", a, b, carryin, sum, carryout);
end
endmodule
