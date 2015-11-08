//------------------------------------------------------------------------
// Shift Register test bench
//------------------------------------------------------------------------

module testshiftregister();

    reg             clk;
    reg             peripheralClkEdge;
    reg             parallelLoad;
    wire[7:0]       parallelDataOut;
    wire            serialDataOut;
    reg[7:0]        parallelDataIn;
    reg             serialDataIn; 
    
    // Instantiate with parameter width = 8
    shiftregister #(8) dut(.clk(clk), 
    		           .peripheralClkEdge(peripheralClkEdge),
    		           .parallelLoad(parallelLoad), 
    		           .parallelDataIn(parallelDataIn), 
    		           .serialDataIn(serialDataIn), 
    		           .parallelDataOut(parallelDataOut), 
    		           .serialDataOut(serialDataOut));

  // Generate clock (50MHz)
    initial clk=0;
    always #10 clk=!clk;    // 50MHz Clock
    
    initial begin
	// Set inputs
    	peripheralClkEdge = 0;
	parallelLoad = 1;
	parallelDataIn = 8'd0;
	serialDataIn = 0;
	#100;

	// TEST CASE 1: serial input (parallelLoad = 0)
	parallelLoad = 0;
	#100;
	peripheralClkEdge = 1;
	#10;
	serialDataIn = 1;
	#10;
	peripheralClkEdge = 0;
	#10;
	serialDataIn = 0;
	#10
	peripheralClkEdge = 1;
	#20;
	peripheralClkEdge = 0;
	serialDataIn = 1;
	#100;
	serialDataIn = 1;
	#100;
	serialDataIn = 0;
	#100;
	
	// TEST CASE 2: parallel input (parallelLoad = 1)
	parallelLoad = 1;
	#100;
	peripheralClkEdge = 1;
	#10;
	parallelDataIn = 8'd12;
	#10;
	peripheralClkEdge = 0;
	#10;
	peripheralClkEdge = 1;
	#20;
	parallelDataIn = 8'd32;
	peripheralClkEdge = 0;
	parallelDataIn = 8'd5;
	#100;
	parallelDataIn = 8'd40;
	#100;
	parallelDataIn = 8'd2;
	#100;

	// TEST CASE 3: serial input (parallelLoad = 0)
	parallelLoad = 0;
	#100;
	peripheralClkEdge = 1;
	#10;
	serialDataIn = 1;
	#10;
	peripheralClkEdge = 0;
	#20;
	peripheralClkEdge = 1;
	#20;
	peripheralClkEdge = 0;
	#20;
	peripheralClkEdge = 1;
	#20;
	peripheralClkEdge = 0;
	#20;
	peripheralClkEdge = 1;
	#20;
	peripheralClkEdge = 0;
	#20;
	peripheralClkEdge = 1;
	#20;
	peripheralClkEdge = 0;
	#20;
	peripheralClkEdge = 1;
	#20;
	peripheralClkEdge = 0;
	#20;
	peripheralClkEdge = 1;
	#20;
	peripheralClkEdge = 0;
	#20;
	peripheralClkEdge = 1;
	#20;

	#100
	$stop;

    end

endmodule

