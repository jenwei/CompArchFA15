//------------------------------------------------------------------------------
// TestREGFILE harness is the test bench for the regfile in HW4 that validates hw4testbench by connecting it to various functional 
// or broken register files, and verifying that it correctly identifies each
//------------------------------------------------------------------------------

module testREGFILE;

  wire[31:0]	ReadData1;	// Data from first register read
  wire[31:0]	ReadData2;	// Data from second register read
  wire[31:0]	WriteData;	// Data to write to register
  wire[4:0]	ReadRegister1;	// Address of first register to read
  wire[4:0]	ReadRegister2;	// Address of second register to read
  wire[4:0]	WriteRegister;  // Address of register to write
  wire		RegWrite;	// Enable writing of register when High
  wire		Clk;		// Clock (Positive Edge Triggered)

  reg		begintest;	// Set High to begin testing register file
  wire		dutpassed;	// Indicates whether register file passed tests

  // Instantiate the register file being tested.  DUT = Device Under Test
  regfile DUT
  (
    .ReadData1(ReadData1),
    .ReadData2(ReadData2),
    .WriteData(WriteData),
    .ReadRegister1(ReadRegister1),
    .ReadRegister2(ReadRegister2),
    .WriteRegister(WriteRegister),
    .RegWrite(RegWrite),
    .Clk(Clk)
  );

  // Instantiate test bench to test the DUT
  hw4testbench tester
  (
    .begintest(begintest),
    .endtest(endtest), 
    .dutpassed(dutpassed),
    .ReadData1(ReadData1),
    .ReadData2(ReadData2),
    .WriteData(WriteData), 
    .ReadRegister1(ReadRegister1), 
    .ReadRegister2(ReadRegister2),
    .WriteRegister(WriteRegister),
    .RegWrite(RegWrite), 
    .Clk(Clk)
  );

  // Test harness asserts 'begintest' for 1000 time steps, starting at time 10
  initial begin
    begintest=0;
    #10;
    begintest=1;
    #1000;
  end

  // Display test results ('dutpassed' signal) once 'endtest' goes high
  always @(posedge endtest) begin
    $display("DUT passed?: %b", dutpassed);
  end

endmodule


//------------------------------------------------------------------------------
// Your HW4 test bench
//   Generates signals to drive register file and passes them back up one
//   layer to the test harness. This lets us plug in various working and
//   broken register files to test.
//
//   Once 'begintest' is asserted, begin testing the register file.
//   Once your test is conclusive, set 'dutpassed' appropriately and then
//   raise 'endtest'.
//------------------------------------------------------------------------------

module hw4testbench
(
// Test bench driver signal connections
input	   		begintest,	// Triggers start of testing
output reg 		endtest,	// Raise once test completes
output reg 		dutpassed,	// Signal test result

// Register File DUT connections
input[31:0]		ReadData1,
input[31:0]		ReadData2,
output reg[31:0]	WriteData,
output reg[4:0]		ReadRegister1,
output reg[4:0]		ReadRegister2,
output reg[4:0]		WriteRegister,
output reg		RegWrite,
output reg		Clk
);

  // Initialize register driver signals
  initial begin
    WriteData=32'd0;
    ReadRegister1=5'd0;
    ReadRegister2=5'd0;
    WriteRegister=5'd0;
    RegWrite=0;
    Clk=0;
  end

  // Once 'begintest' is asserted, start running test cases
  always @(posedge begintest) begin
    endtest = 0;
    dutpassed = 1;
    #10

  // Test Case 1: 
  // Write '42' to register 2, verify with Read Ports 1 and 2
  // (Passes because example register file is hardwired to return 42)
  WriteRegister = 5'd2;
  WriteData = 32'd42;
  RegWrite = 1;
  ReadRegister1 = 5'd2;
  ReadRegister2 = 5'd2;
  #5 Clk=1; #5 Clk=0;	// Generate single clock pulse

  // Verify expectations and report test result
  if((ReadData1 != 42) || (ReadData2 != 42)) begin
    dutpassed = 0;	// Set to 'false' on failure
    $display("ReadData -- BROKEN -- Test Case 1 Failed");
  end
  else begin
    $display("ReadData -- WORKS -- Test Case 1 Passed");
  end

  // Test Case 2: 
  // Write '15' to register 2, verify with Read Ports 1 and 2
  // (Fails with example register file, but should pass with yours)
  WriteRegister = 5'd2;
  WriteData = 32'd15;
  RegWrite = 1;
  ReadRegister1 = 5'd2;
  ReadRegister2 = 5'd2;
  #5 Clk=1; #5 Clk=0;

  if((ReadData1 != 15) || (ReadData2 != 15)) begin
    dutpassed = 0;
    $display("ReadData -- BROKEN -- Test Case 2 Failed");
  end
  else begin
    $display("ReadData -- WORKS -- Test Case 2 Passed");
  end

// Test Case 3:
//   Check that write/enable is broken by setting write/enable off and seeing if the new data was stored (if it does -> broken, else -> works)
  WriteRegister = 5'd2; // same register as test case 2
  WriteData = 32'd5;
  RegWrite = 0; // enable is off
  ReadRegister1 = 5'd2;
  ReadRegister2 = 5'd2;
  #5 Clk=1; #5 Clk=0;

  if((ReadData1 == 5) || (ReadData2 == 5))
    begin
      dutpassed = 0;
      $display("Write Enable -- BROKEN -- Test Case 3 Failed");
    end	
  else begin
    $display("Write Enable -- WORKS -- Test Case 3 Passed");
  end

// Test Case 4:
// Checks to see if all registers are written to when decoder is broken (if it does -> broken, else -> works)

  WriteRegister = 5'd2; // Arbitrary register chosen from Test Case 2
  WriteData = 32'd25; // Arbitrary value chosen different from previous test cases
  RegWrite = 1;
  ReadRegister1 = 5'd15; // Arbitrary first register to read
  ReadRegister2 = 5'd20; // Arbitrary second register to read 
  #5 Clk=1; #5 Clk=0;

  // Check that the data read wasn't stored in other registers 
  if((ReadData1 == 25) || (ReadData2 == 25)) begin
    dutpassed = 0;
    $display("Decoder -- BROKEN -- Test Case 4 Failed");
  end
  else begin
    $display("Decoder -- WORKS -- Test Case 4 Passed");
  end

// Test Case 5:
// Checks if register zero is actually a register instead of the constant value zero (if it is -> broken, else -> works)
  WriteRegister = 5'd0;
  WriteData = 32'd22; // Attempt to write '22' to register 0
  RegWrite = 1;
  ReadRegister1 = 5'd0;
  ReadRegister2 = 5'd0;
  #5 Clk=1; #5 Clk=0;

  if ((ReadData1 != 0) || (ReadData2 != 0)) begin
    dutpassed = 0;
    $display("Register0 -- BROKEN -- Test Case 5 Failed");
  end
  else begin
    $display("Register0 -- WORKS -- Test Case 5 Passed");
  end


// Test Case 6:
// Checks if Port 2 broken and always reads register 17 (if it does -> broken, else -> works)  
  WriteRegister = 5'd2; // Writing to arbitrarily to Register 2
  WriteData = 32'd500;
  RegWrite = 1;
  ReadRegister1 = 5'd2;
  ReadRegister2 = 5'd2;
  #5 Clk=1; #5 Clk=0;

  WriteRegister = 5'd17; // Writing to Register 17
  WriteData = 32'd1200; // Choosing an arbitrary value of '1200' which is different from the value above and from other test cases
  RegWrite = 1;
  ReadRegister1 = 5'd2;
  ReadRegister2 = 5'd17;
  #5 Clk=1; #5 Clk=0;

  if(ReadData1 == ReadData2) begin
    dutpassed = 0;
    $display("Port 2 -- BROKEN -- Test Case 6 Failed");
  end
  else begin
    $display("Port 2 -- WORKS -- Test Case 6 Passed");
  end

  // All done!  Wait a moment and signal test completion.
  #5
  endtest = 1;

end

endmodule
