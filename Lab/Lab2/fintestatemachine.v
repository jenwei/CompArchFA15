//------------------------------------------------------------------------
// Finite State Machine
//   Positive edge triggered
//   Sends control signals based on the current state of the module.
//   Stays at Done after one complete state run. 
//   Only resets completely on CS high
//------------------------------------------------------------------------

module finitestatemachine
(
output 	MISO_buf,
output 	dataMem_WE,
output 	addr_WE,
output 	shiftReg_WE,
input 	clkEdge,
input 	chipSel,
input 	shiftRegOut0
);

reg[2:0] curState = 3'b000;
reg[2:0] curCount = 3'b000;
wire reset_Counter = 0;

always @(posedge clkEdge) begin
	MISO_buf <= 0;
	dataMem_WE <= 0;
	addr_WE <= 0;
	shiftReg_WE <= 0;
	reset_Counter <= 0;
	if (chipSel) begin
		curState <= 3'b000;
		reset_Counter <= 1;
	end
	case(curState)
		3'b000 : 
			curCount = curCount + 1;
			if (curCount == 8) begin
				curState <= curState + 1;
			end 
		3'b001 : 
			if (serialRegOut0) begin
				curState <= curState + 1;
			end
			else begin
				curState <= curState + 4;
			end
			reset_Counter <= 1;
			addr_WE <=1;
		3'b010 : 
			curState <= curState + 1;
		3'b011 : 
			curState <= curState + 1;
			shiftReg_WE <= 1
		3'b100 : 
			curCount = curCount + 1;
			if (curCount == 8) begin
				curState <= curState + 3;
			end
			MISO_buf <= 1;
		3'b101 : 
			curCount = curCount + 1;
			if (curCount == 8) begin
				curState <= curState + 1;
			end
		3'b110 : 
			curState <= curState + 1;
			dataMem_WE <= 1;
		3'b111 : 
			reset_Counter <= 1;
	endcase
	if (reset_Counter) begin
		curCount <= 0;
		reset_Counter <=0;
	end

endmodule
