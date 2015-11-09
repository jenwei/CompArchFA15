//------------------------------------------------------------------------
// Input Conditioner test bench
//------------------------------------------------------------------------

module testConditioner();

    reg clk;
    reg pin;
    wire conditioned;
    wire rising;
    wire falling;
    
    inputconditioner dut(.clk(clk),
    			 .noisysignal(pin),
			 .conditioned(conditioned),
			 .positiveedge(rising),
			 .negativeedge(falling));


    // Generate clock (50MHz)
    initial clk=0;
    initial pin=0;
    always #10 clk=!clk;    // 50MHz Clock
    always #80 pin=!pin;
    
    initial begin
    // Be sure to test each of the three conditioner functions:
    // Synchronize, Clean, Preprocess (edge finding)
    // We looked at the waveforms to determine the success of our testing
    // TEST CASE 0: Clean positive switch 
    	pin = 0;
    	#100;
    	pin = 1;
    	#500;
    // TEST CASE 1: Clean negative switch 
    	pin = 0;
    	#500;
    // TEST CASE 2: noisy low: shouldn't switch high
    	pin = 0;
    	#15;
    	pin = 1;
    	#15;
    	pin = 0;
    	#12;
    	pin = 1;
    	#18;
    	pin = 0;
    	#7;
    	pin = 1;
    	#9;
    	pin = 0; #500;
    // TEST CASE 3: noisy high: shouldn't switch low
    	pin = 1;
    	#500;
    	pin = 0;
    	#15;
    	pin = 1;
    	#15;
    	pin = 0;
    	#12;
    	pin = 1;
    	#18;
	pin = 0;
	#7;
	pin = 1;
	#9;
	pin = 0; #500;
    	$stop;
	#400;
    	$stop;
    end

endmodule
