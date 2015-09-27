//----------------------------------------------------------------------------
// Module used to compute DeMorgan's theorem terms
// Author: Ben Hill
//
// Inputs:  A and B
// Outputs: all four DeMorgan terms
//----------------------------------------------------------------------------

// [NOTE] This module is completely structural - it consists solely of
// gates wired together. You could draw the module on paper easily.

// [STYLE] Listing inputs and outputs one-per-line like this can be really
// helpful when combined with version control. When you add/remove an I/O,
// it will be immediately obvious in the diff.
module demorgan
(
  input  Ain,       // Single bit inputs, used to generate DeMorgan terms
  input  Bin,
  output _AorB,     // ~(A+B)
  output _Aand_B,   // (~A)*(~B)
  output _AandB,    // ~(A*B)
  output _Aor_B     // (~A)+(~B)
);

  // Compute negated versions of the inputs
  wire _A;    // ~A
  wire _B;    // ~B
  not invA(_A, Ain);
  not invB(_B, Bin);

  // Compute intermediate terms
  wire AorB;     // A+B
  wire AandB;    // A*B
  or or0(AorB, Ain, Bin);
  and and0(AandB, Ain, Bin);

  // Compute DeMorgan terms, which will be the module outputs
  not inv0(_AorB, AorB);
  and and1(_Aand_B, _A, _B);
  not inv1(_AandB, AandB);
  or or1(_Aor_B, _A, _B);

endmodule
