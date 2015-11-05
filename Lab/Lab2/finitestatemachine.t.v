// finitestatemachine.t.v
module testFSM();

wire	MISO_buf;
wire	dataMem_WE;
wire	addr_WE;
wire	shiftReg_WE;
reg 	clkEdge; // Runs on the posedge of sclk fro spi
reg 	chipSel; // Hard reset for the FSM
reg 	shiftRegOut0;


    finitestatemachine dut(.MISO_buf(MISO_buf),
    			 .dataMem_WE(dataMem_WE),
			 .addr_WE(addr_WE),
			 .shiftReg_WE(shiftReg_WE),
			 .clkEdge(clkEdge),
			 .chipSel(chipSel),
			 .shiftRegOut0(shiftRegOut0));

reg[7:0]	yolo;
    initial begin

    // Your Test Code
    // Be sure to test each of the three conditioner functions:
    // Synchronize, Clean, Preprocess (edge finding)
    // TEST CASE 1: Run the whole shebang 
	chipSel = 0;
	shiftRegOut0 = 1;
	$display("TEST 1: MISO || dataMem || addrWE || ShiftRegWE");
	for (yolo=0; yolo<40; yolo=yolo+1) begin
		clkEdge = 1; 
		#30 
		clkEdge=0;
		$display("%b %b %b %b", MISO_buf, dataMem_WE, addr_WE, shiftReg_WE);
		#500;
	end
	chipSel = 1;
	clkEdge = 1;
	#30
	clkEdge = 0;
	chipSel = 0;
	shiftRegOut0 = 0;
	$display("TEST 2: MISO || dataMem || addrWE || ShiftRegWE");
	for (yolo=0; yolo<40; yolo=yolo+1) begin
		clkEdge = 1; 
		#30 
		clkEdge=0;
		$display("%b %b %b %b", MISO_buf, dataMem_WE, addr_WE, shiftReg_WE);
		#500;
	end
    end

endmodule
