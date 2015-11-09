//------------------------------------------------------------------------
// SPI Memory
//------------------------------------------------------------------------

module spiMemory
(
    input           clk,        // FPGA clock
    input           sclk_pin,   // SPI clock
    input           cs_pin,     // SPI chip select
    output reg      miso_pin,   // SPI master in slave out
    input           mosi_pin,   // SPI master out slave in
    input           fault_pin,  // For fault injection testing
    output [3:0]    leds        // LEDs for debugging
);

wire[7:0] parallelDataOut, parallelDataIn;
wire conditioned3, rising3, falling3;
wire conditioned2, rising2, falling2;
wire conditioned1, rising1, falling1;
wire conditioned0, rising0, falling0;
wire serialDatOut;

wire dm_WE, addr_WE, sr_WE;

reg[6:0] AddrLat;

reg SerialOutFF;


inputconditioner ipc0(.clk(clk),
    			 .noisysignal(mosi_pin),
			 .conditioned(conditioned0),
			 .positiveedge(rising0),
			 .negativeedge(falling0));

inputconditioner_breaking ipc1(.clk(clk),
    			 .noisysignal(sclk_pin),
			 .conditioned(conditioned1),
			 .positiveedge(rising1),
			 .negativeedge(falling1),
			 .fault_pin(fault_pin));

inputconditioner ipc2(.clk(clk),
    			 .noisysignal(cs_pin),
			 .conditioned(conditioned2),
			 .positiveedge(rising2),
			 .negativeedge(falling2));

shiftregister #(8) shr(.clk(clk), 
    		           .peripheralClkEdge(rising1),
    		           .parallelLoad(sr_WE), 
    		           .parallelDataIn(parallelDataIn), 
    		           .serialDataIn(conditioned0), 
    		           .parallelDataOut(parallelDataOut), 
    		           .serialDataOut(serialDataOut));

datamemory dtmm(.clk(clk),
			.dataIn(parallelDataOut),
			.address(AddrLat),
			.writeEnable(dm_WE),
			.dataOut(parallelDataIn));

finitestatemachine fsm(.MISO_buf(misoBuf),
			.dataMem_WE(dm_WE),
			.addr_WE(addr_WE),
			.shiftReg_WE(sr_WE),
			.clk(clk),
			.sclkEdge(rising1),
			.chipSel(conditioned2),
			.shiftRegOut0(parallelDataOut[0]));


always @(posedge clk) begin
        if(addr_WE) begin // This is the Address latch
            AddrLat <= parallelDataOut[7:1];
	end
	if (falling1) begin //This is the DFF for the Serial Out
	    SerialOutFF <= serialDataOut;
	end
	if (misoBuf) begin
	    miso_pin <= SerialOutFF;
	end
	else if (!conditioned1)begin
		miso_pin <=1'bx;
	end
end
endmodule
   
