module signextend
(
output[32:0]	imm32,
input[15:0]	imm16
);
// Extends the sign of the immediate
genvar i;
assign imm32[15:0] = imm16;
for (i=16;i<32;i=i+1) begin
	assign imm32[i] = imm16[15]; 
end
endmodule
