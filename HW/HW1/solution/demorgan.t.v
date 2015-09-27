//----------------------------------------------------------------------------
// DeMorgan's theorem test bench
// Author: Ben Hill
//
// Exhaustively tests 'demorgan' module and proves DeMorgan's Laws
//----------------------------------------------------------------------------

`include "demorgan.v"

// [STYLE] Wrapped a repetitive block of code in a `define macro. This
// macro is very fragile/specific to this test bench below (e.g. variable
// names), but you can also imagine writing more general macros.

`define DEMORGAN_TEST_CASE( a_val, b_val, delay )			\
  A = (a_val); B = (b_val); #delay					\
  /* $write is like $display, but with no newline */			\
  $write("%b %b |    %b       %b     |    %b       %b", 		\
           A, B, nAorB, nAandnB, nAandB, nAornB);			\
  /* Automatically compute pass/fail conditions for the test */		\
  if ( (nAorB == nAandnB) && (nAandB == nAornB) )			\
    begin								\
      $display("     [ pass ]");					\
    end									\
  else									\
    begin								\
      $display("     [ FAIL ]");					\
      /* Add a '$finish' to die on the first failure */			\
    end									


// Test bench module

// [NOTE] This test bench is completely behavioral and has no real logic,
// apart from the 'demorgan' module it instantiates. If you were to 
// synthesize it you would get nothing - $display's don't correspond to
// any real hardware.

module demorgan_test ();
  // [STYLE] We use a module parameter to set the delay for each test case
  // so that it is easy to change later.
  parameter TEST_DELAY = 500;

  // Instantiate device/module under test
  reg A, B;				// Primary test inputs
  wire nAorB, nAandnB, nAandB, nAornB;	// Test outputs

  // [Style] This method of module instantiation uses "connection by name".
  // It uses the format: 
  //     .module_io_name (local_name)
  // This method is less error prone than the ordered method because the
  // connections are explicit.
  // See: http://www.asic-world.com/verilog/syntax2.html 

  demorgan dut
  (
    .Ain	(A),
    .Bin	(B),
    ._AorB	(nAorB),
    ._Aand_B	(nAandnB),
    ._AandB	(nAandB),
    ._Aor_B	(nAornB)
  );
 

  // Run sequence of test stimuli
  initial begin
    // Print header
    $display("A B | ~(A+B) (~A)*(~B) | ~(A*B) (~A)+(~B)");
    $display("-----------------------------------------");

    // Run individual test cases to generate truth table
    `DEMORGAN_TEST_CASE( 1'b0, 1'b0 , TEST_DELAY )
    `DEMORGAN_TEST_CASE( 1'b0, 1'b1 , TEST_DELAY )
    `DEMORGAN_TEST_CASE( 1'b1, 1'b0 , TEST_DELAY )
    `DEMORGAN_TEST_CASE( 1'b1, 1'b1 , TEST_DELAY )
  end

endmodule	// End demorgan_test


