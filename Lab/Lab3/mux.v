module mux
(
output[31:0] 	selected,
input[31:0]		inputA,
input[31:0]		inputB,
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
