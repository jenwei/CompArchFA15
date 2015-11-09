//------------------------------------------------------------------------
// Shift Register
//   Parameterized width (in bits)
//   Shift register can operate in two modes:
//      - serial in, parallel out
//      - parallel in, serial out
//------------------------------------------------------------------------

module shiftregister
#(parameter width = 8)
(
input               clk,                // FPGA Clock
input               peripheralClkEdge,  // Edge indicator
input               parallelLoad,       // 1 = Load shift reg with parallelDataIn
input  [width-1:0]  parallelDataIn,     // Load shift reg in parallel (if parallelLoad = 1)
input               serialDataIn,       // Load shift reg serially (if parallelLoad = 0)
output [width-1:0]  parallelDataOut,    // Shift reg data contents
output              serialDataOut       // Positive edge synchronized
);
    reg [width-1:0] shiftregistermem;

    always @(posedge clk) begin 
	if (peripheralClkEdge && (!parallelLoad)) begin //loads from serialDataIn
		shiftregistermem <= {shiftregistermem[width-2:0],serialDataIn};
	end
	if (parallelLoad) begin //loads from parallelDataIn
		shiftregistermem <= parallelDataIn; 
	end
    end
assign serialDataOut = shiftregistermem[width-1];
assign parallelDataOut = shiftregistermem;
endmodule
