//------------------------------------------------------------------------
// Input Conditioner
//    1) Synchronizes input to clock domain
//    2) Debounces input
//    3) Creates pulses at edge transitions
//------------------------------------------------------------------------

module inputconditioner
(
input 	    clk,            // Clock domain to synchronize input to
input	    noisysignal,    // (Potentially) noisy input signal
output reg  conditioned,    // Conditioned output signal
output reg  positiveedge,   // 1 clk pulse at rising edge of conditioned
output reg  negativeedge    // 1 clk pulse at falling edge of conditioned
);

    parameter counterwidth = 3; // Counter size, in bits, >= log2(waittime)
    parameter waittime = 3;     // Debounce delay, in clock cycles
    
    reg[counterwidth-1:0] counter = 0;
    reg synchronizer0 = 0;
    reg synchronizer1 = 0;

    always @(posedge clk ) begin
        if(conditioned == synchronizer1)
            counter <= 0;
        else begin
            if( counter == waittime) begin
                counter <= 0;
                conditioned <= synchronizer1; // output is set to synchronizer1
		positiveedge <= synchronizer1; // positiveedge is set high if synchronizer1 is high and low if not
		negativeedge <= !synchronizer1; // negativeedge is set high if synchronizer1 is low and high if not  
            end
            else 
                counter <= counter+1;
        end
        synchronizer0 <= noisysignal; // set synchronizer0 to the noisysignal
        synchronizer1 <= synchronizer0; // set synchronizer to synchronizer0
	
	// If positiveedge or negativeedge are high, reset to 0 (since we only want them to be around for one clock cycle)	
	if (positiveedge || negativeedge) begin
		positiveedge <= 0;
		negativeedge <= 0;
	end
	
    end
endmodule


module inputconditioner_breaking
(
input 	    clk,            // Clock domain to synchronize input to
input	    noisysignal,    // (Potentially) noisy input signal
output reg  conditioned,    // Conditioned output signal
output reg  positiveedge,   // 1 clk pulse at rising edge of conditioned
output reg  negativeedge,   // 1 clk pulse at falling edge of conditioned
input	    fault_pin	    // Fault pin used to break the SPI code
);

    parameter counterwidth = 3; // Counter size, in bits, >= log2(waittime)
    parameter waittime = 3;     // Debounce delay, in clock cycles
    
    reg[counterwidth-1:0] counter = 0;
    reg synchronizer0 = 0;
    reg synchronizer1 = 0;

    always @(posedge clk ) begin
	if (fault_pin) begin
		synchronizer1  <= 0;
	end
	else begin
        if(conditioned == synchronizer1)
             counter <= 0;
        else begin
            if( counter == waittime) begin
                counter <= 0;
                conditioned <= synchronizer1; // output is set to synchronizer1
		positiveedge <= synchronizer1; // positiveedge is set high if synchronizer1 is high and low if not
		negativeedge <= !synchronizer1; // negativeedge is set high if synchronizer1 is low and high if not  
            end
            else 
                counter <= counter+1;
        end
        synchronizer0 <= noisysignal; // set synchronizer0 to the noisysignal
        synchronizer1 <= synchronizer0; // set synchronizer to synchronizer0
	end
	// If positiveedge or negativeedge are high, reset to 0 (since we only want them to be around for one clock cycle)	
	if (positiveedge || negativeedge) begin
		positiveedge <= 0;
		negativeedge <= 0;
	end	
    end
endmodule
