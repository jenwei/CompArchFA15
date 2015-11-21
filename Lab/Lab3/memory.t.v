module testMEMORY;
reg clk, regWE;
reg[9:0] DataAddr; //InstrAddr;
reg[31:0] DataIn;
wire[31:0]  DataOut; //InstrOut;

memory swagswag(
.clk(clk),
.regWE(regWE),
.DataAddr(DataAddr),
.DataIn(DataIn),
.DataOut(DataOut)
);

initial begin
regWE=0; 
DataAddr=10'b0000000000; 
//InstrAddr=10'b0000000000; 
DataIn= 32'habcdef98; #100
clk = 1; #100
clk = 0; #100
$display("yolo swag swag %b %h", DataAddr, DataOut); #100
#100

regWE=0; 
DataAddr=10'b0000000100; 
//InstrAddr=10'b0000000000; 
DataIn= 32'habcdef98; #100
clk = 1; #100
clk = 0; #100
$display("yolo swag swag %b %h", DataAddr, DataOut); #100
#100
$stop;
end
endmodule

