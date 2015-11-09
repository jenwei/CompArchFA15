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
input   clk,
input 	sclkEdge, // Runs on the posedge of sclk from SPI
input 	chipSel, // Hard reset for the FSM
input 	shiftRegOut0
);

reg[2:0] curState = 3'b000; //tracks what state you're in
reg[2:0] curCount = 3'b000; //tracks how long you've been in a state

always @(posedge clk) begin
	MISO_buf <= 0; //default cases
	dataMem_WE <= 0;
	addr_WE <= 0;
	shiftReg_WE <= 0;
	if (chipSel) begin //only resets on CS high
		curState <= 3'b000; //reset means setting state, count to zero
		curCount <= 0;
	end
	else begin
	case(curState)
		3'b000 : //Get
			if (curCount == 7 && sclkEdge) begin
				curState <= curState + 1;
			end 
			else if(sclkEdge) begin //stay in Get until you have all 8 bits
				curCount = curCount + 1; 
			end
		3'b001 : //Got
			if (shiftRegOut0) begin
				curState <= curState + 1; //go to Read1
				curCount <= 0;
				addr_WE <=1;
			end
			else begin
				curState <= curState + 4; //go to Write1
				curCount <= 0;
				addr_WE <=1;
			end
		3'b010 : //Read1
			begin
				curState <= curState + 1;
			end
		3'b011 : //Read2
			begin
				curState <= curState + 1;
				shiftReg_WE <= 1;
			end
		3'b100 : //Read3
			if (curCount == 7 && sclkEdge) begin
				curState <= curState + 3;
				MISO_buf <= 1;
			end
			else if (sclkEdge) begin //stay in Read3 until you have all 8 bits
				MISO_buf <= 1;
				curCount = curCount + 1;
			end
		3'b101 : //Write1
			if (curCount == 7 && sclkEdge) begin
				curState <= curState + 1;
			end
			else if(sclkEdge) begin //stay in Write1 until you have all 8 bits
				curCount = curCount + 1;
			end
		3'b110 : //Write2
			begin
				curState <= curState + 1;
				dataMem_WE <= 1;
			end
		3'b111 : //Done
			begin 
				curCount <= 0;
			end
	endcase
	end //Won't restart cases from 3b'000 "Get" until CS high
end

endmodule
