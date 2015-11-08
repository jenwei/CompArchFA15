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
	#400;
    	$stop;
    end

endmodule
