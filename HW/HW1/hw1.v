module hw1test;
// Inputs
reg A; 
reg B;

// Wires
wire nA; 
wire nB; 
wire n_AandB; 
wire nAornB; 
wire n_AorB; 
wire nAandnB;

// nA
not Ainv(nA, A);

// nB
not Binv(nB, B);

// 1 n_AandB
and andgate1(AandB, A, B);
not inv1(n_AandB, AandB);

// 2 nAornB
or orgate2(nAornB, nA, nB);

// 3 n_AorB
or orgate3(AorB, A, B);
not inv3(n_AorB, AorB);

// 4 nAandnB
and andgate4(nAandnB, nA, nB);

initial begin
$display("Hello, CompArch!");
$display("A B | ~A ~B | ~(AB) ~A+~B | ~(A+B) ~A~B"); // Prints header for truth table
A=0; B=0; #1 // Set A and B, wait for update(#1)
$display("%b %b |  %b  %b |    %b    %b   |     %b     %b", A, B, nA, nB, n_AandB, nAornB, n_AorB, nAandnB);
A=0; B=1; #1 // Set A and B, wait for update(#1)
$display("%b %b |  %b  %b |    %b    %b   |     %b     %b", A, B, nA, nB, n_AandB, nAornB, n_AorB, nAandnB);
A=1; B=0; #1 // Set A and B, wait for update(#1)
$display("%b %b |  %b  %b |    %b    %b   |     %b     %b", A, B, nA, nB, n_AandB, nAornB, n_AorB, nAandnB);
A=1; B=1; #1 // Set A and B, wait for update(#1)
$display("%b %b |  %b  %b |    %b    %b   |     %b     %b", A, B, nA, nB, n_AandB, nAornB, n_AorB, nAandnB);
end

endmodule
