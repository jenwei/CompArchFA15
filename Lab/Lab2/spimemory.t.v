//------------------------------------------------------------------------
// Shift Register test bench
//------------------------------------------------------------------------

module testspimemory();
    reg[6:0] addr,
    reg          clk,        // FPGA clock
    reg          sclk_pin,   // SPI clock
    reg          cs_pin,     // SPI chip select
    wire          miso_pin,   // SPI master in slave out // output
    reg          mosi_pin,   // SPI master out slave in
    reg          fault_pin,  // For fault injection testing
    reg [3:0]    leds        // LEDs for debugging
    
    
    spiMemory dut(.clk(clk), 
    		           .sclk_pin(sclk_pin),
    		           .cs_pin(cs_pin), 
    		           .miso_pin(miso_pin), 
    		           .mosi_pin(mosi_pin), 
    		           .fault_pin(fault_pin), 
    		           .leds(leds));

  // Generate clocks
    initial clk=0;
    always begin
	#10 clk=!clk;    // 50MHz Clock
	#20 sclk_pin=!sclk_pin; //25MHz Clock
    end
    
    initial begin
	// TEST CASE 1: Write enable
	for(i=0;i<16;i=i+1) begin
	    miso_pin=0
	    #100
	end
	#200
	$display("MOSI: %b", mosi_pin)
	// TEST CASE 2: Read enable
	for(i=0;i<15;i=i+1) begin
	    miso_pin=0
	    #100
	end
	miso_pin=1
	#100
	$display("MOSI: %b", mosi_pin)
	$stop;
    end

endmodule
