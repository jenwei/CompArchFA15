// Midpoint Check In
// mux2     >> Two-input MUX
// midpoint >> Uses 3 input conditioners to smooth out button and switches, then connects outputs to a shift register.
// -----------------

module mux2 #( parameter W = 1 )
(
    input[W-1:0]    in0,
    input[W-1:0]    in1,
    input           sel,
    output[W-1:0]   out
);
    assign out = (sel) ? in1 : in0;
endmodule

module midpoint
(
input 	     clk,
input  [3:0] sw, //Switches as input "noisy signal" to input conditioners
input  [3:0] btn,//Button as input "noisy signal" to input conditioners
output[3:0] led
);

wire[7:0] parallelDataOut;
wire conditioned3, rising3, falling3;
wire conditioned2, rising2, falling2;
wire conditioned1, rising1, falling1;
wire conditioned0, rising0, falling0;
wire serialDatOut;

//Condition signals from button[0], switch[0:3]
//Wire out conditioned signal, posedge, negedge
inputconditioner ipc0(.clk(clk),
    			 .noisysignal(btn[0]),
			 .conditioned(conditioned0),
			 .positiveedge(rising0),
			 .negativeedge(falling0));

inputconditioner ipc1(.clk(clk),
    			 .noisysignal(sw[0]),
			 .conditioned(conditioned1),
			 .positiveedge(rising1),
			 .negativeedge(falling1));

inputconditioner ipc2(.clk(clk),
    			 .noisysignal(sw[1]),
			 .conditioned(conditioned2),
			 .positiveedge(rising2),
			 .negativeedge(falling2));

inputconditioner ipc3(.clk(clk),
    			 .noisysignal(sw[2]),
			 .conditioned(conditioned3),
			 .positiveedge(rising3),
			 .negativeedge(falling3));

//connect appropriate rising/falling edges, and conditioned  signal from switch[0]
shiftregister #(8) shr(.clk(clk), 
    		           .peripheralClkEdge(rising2),
    		           .parallelLoad(falling0), 
    		           .parallelDataIn(8'hA5), 
    		           .serialDataIn(conditioned1), 
    		           .parallelDataOut(parallelDataOut), 
    		           .serialDataOut(serialDataOut));
//Use mux to select a subset of bits to display
mux2 #(4) output_select(.in0(parallelDataOut[3:0]), .in1(parallelDataOut[7:4]), .sel(conditioned3), .out(led));

endmodule
