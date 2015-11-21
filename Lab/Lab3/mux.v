module mux
#(
    parameter width	= 32
)
(
output reg[width-1:0] 	selected,
input[width-1:0]	inputA,
input[width-1:0]	inputB,
input			select
);
// General 32-bit 2-select MUX
always @(inputA or inputB or select) begin
	case(select)
		1: begin
		selected <= inputB;
		end
		0: begin
		selected <= inputA;
		end
endcase
end

endmodule
