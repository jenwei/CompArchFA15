//------------------------------------------------------------------------
// Finite State Machine
//   Positive edge triggered
//   Sends control signals based on the current state of the module.
//   Stays at Done after one complete state run. 
//   Only resets completely on CS high
//------------------------------------------------------------------------

module finitestatemachine
(
output reg	MISO_buf,
output reg	dataMem_WE,
output reg	addr_WE,
output reg	shiftReg_WE,
input 	clkEdge,
input 	chipSel,
input 	shiftRegOut0
);

reg[2:0] curState = 3'b000;
reg[2:0] curCount = 3'b000;
reg reset_Counter = 0;

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
			if (curCount == 8) begin
				curState <= curState + 1;
			end 
			else begin
				curCount = curCount + 1;
			end
		3'b001 : 
			if (shiftRegOut0) begin
				curState <= curState + 1;
				reset_Counter <= 1;
				addr_WE <=1;
			end
			else begin
				curState <= curState + 4;
				reset_Counter <= 1;
				addr_WE <=1;
			end
		3'b010 : 
			curState <= curState + 1;
		3'b011 : 
			begin
				curState <= curState + 1;
				shiftReg_WE <= 1;
			end
		3'b100 : 
			
			if (curCount == 8) begin
				curState <= curState + 3;
				MISO_buf <= 1;
			end
			else begin
				MISO_buf <= 1;
				curCount = curCount + 1;
			end
		3'b101 : 
			if (curCount == 8) begin
				curState <= curState + 1;
			end
			else begin
				curCount = curCount + 1;
			end
		3'b110 : 
			begin
				curState <= curState + 1;
				dataMem_WE <= 1;
			end
		3'b111 : 
			reset_Counter <= 1;
	endcase
	if (reset_Counter) begin
		curCount <= 0;
		reset_Counter <=0;
	end
end

endmodule
