//------------------------------------------------------------------------
// SPI Memory
//------------------------------------------------------------------------

module spiMemory
(
    input           clk,        // FPGA clock
    input           sclk_pin,   // SPI clock
    input           cs_pin,     // SPI chip select
    output          miso_pin,   // SPI master in slave out
    input           mosi_pin,   // SPI master out slave in
    input           fault_pin,  // For fault injection testing
    output [3:0]    leds        // LEDs for debugging
)

wire[7:0] parallelDataOut, parallelDataIn;
wire conditioned3, rising3, falling3;
wire conditioned2, rising2, falling2;
wire conditioned1, rising1, falling1;
wire conditioned0, rising0, falling0;
wire serialDatOut;

reg[7:0] AddrLat;

reg SerialOutFF;


inputconditioner ipc0(.clk(clk),
    			 .noisysignal(mosi_pin),
			 .conditioned(conditioned0),
			 .positiveedge(rising0),
			 .negativeedge(falling0));

inputconditioner ipc1(.clk(clk),
    			 .noisysignal(sclk_pin),
			 .conditioned(conditioned1),
			 .positiveedge(rising1),
			 .negativeedge(falling1));

inputconditioner ipc2(.clk(clk),
    			 .noisysignal(cs_pin),
			 .conditioned(conditioned2),
			 .positiveedge(rising2),
			 .negativeedge(falling2));

shiftregister #(8) shr(.clk(clk), 
    		           .peripheralClkEdge(rising1),
    		           .parallelLoad(##WRITE FSM##), 
    		           .parallelDataIn(parallelDataIn), 
    		           .serialDataIn(conditioned0), 
    		           .parallelDataOut(parallelDataOut), 
    		           .serialDataOut(serialDataOut));

datamemory dtmm(.clk(clk),
			.dataIn(parallelDataOut),
			.address(AddrLat),
			.writeEnable(##WRITE FSM##),
			.dataOut(parallelDataIn));


always @(posedge clk) begin
        if(##WRITE FSM##) begin // This is the Address latch
            AddrLat <= parallelDataOut;
	end
	if (falling1) begin //This is the DFF for the Serial Out
	    SerialOutFF <= serialDataOut;
	end
	if (##WRITE FSM##) begin //This is the buffer for Serial write out
	    miso_pin <= SerialOutFF;
	end
    end





endmodule
   
