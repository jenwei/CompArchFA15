module mux
(
output[31:0] 	yolo,
input[31:0]	inputA,
input[31:0]	inputB,
input		select
);
// General 32-bit 2-select MUX
if(select == 0) begin
assign yolo = inputA;
end
if(select == 1) begin
assign yolo = inputB;
end
endmodule
