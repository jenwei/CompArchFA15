//------------------------------------------------------------------------
// Shift Register test bench
//------------------------------------------------------------------------

module testspimemory();
    reg          clk;        // FPGA clock
    reg          sclk_pin;   // SPI clock
    reg          cs_pin;     // SPI chip select
    wire         miso_pin;   // SPI master in slave out // output
    reg          mosi_pin;   // SPI master out slave in
    reg          fault_pin;  // For fault injection testing
    wire [3:0]   leds;       // LEDs for debugging
    wire	 res;
    
    
    spiMemory dut(.clk(clk), 
    		           .sclk_pin(sclk_pin),
    		           .cs_pin(cs_pin), 
    		           .miso_pin(miso_pin), 
    		           .mosi_pin(mosi_pin), 
    		           .fault_pin(fault_pin), 
    		           .leds(leds),
			   .r(res));

  // Generate clocks
    initial clk <= 0;
    initial sclk_pin <= 0;
    always begin
	#100 sclk_pin <= !sclk_pin; //25MHz Clock
    end

    always begin
	#10 clk <=!clk;     // 50MHz Clock
    end

integer i;

    initial begin
	// TEST CASE 1: Write enable
	cs_pin = 1;
	#60
	for(i=0;i<6;i=i+1) begin
	    cs_pin = 0;
	    mosi_pin = 0;
	    #280;
	end
	for(i=0;i<7;i=i+1) begin
	    cs_pin = 0;
	    mosi_pin = !mosi_pin;
	    #200;
	end
	#100;
	cs_pin = 1;
	#100
        cs_pin = 0;
	// TEST CASE 2: Read enable
	for(i=0;i<6;i=i+1) begin
	    mosi_pin = 0;
	    #240;
	end
	mosi_pin = 1;
	#2000;
	cs_pin = 1;
	#400;
	$stop;
    end

endmodule
