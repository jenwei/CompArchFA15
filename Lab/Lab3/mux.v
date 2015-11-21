module mux
#(
    parameter width	= 32
)
(
output[width-1:0] 	selected,
input[width-1:0]		inputA,
input[width-1:0]		inputB,
input			select
);
// General 32-bit 2-select MUX
if (select) begin
	assign selected = inputB;
end
else begin
	assign selected = inputA;
end

endmodule
