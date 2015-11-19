module testDATAMEM;

reg 		clk;
wire[31:0] 	dOut;
reg[31:0] 	addr;
reg	 	wrEn;
reg[31:0] 	dIn;

datamem DUT(clk,dOut,addr,wrEn,dIn);

integer i;


initial clk=0;
initial wrEn=1;
always #10 clk=!clk;

initial begin
	for(i=0;i<31;i=i+1)begin
		addr = 2;
		dIn = i; 
		#20;
	$display("Address: %d | DataIn: %d | DataOut: %d",addr,dIn,dOut);
	end
	
	wrEn=0;

	for(i=0;i<31;i=i+1)begin
		addr = 2;
		dIn = i; 
		#20;
	$display("Address: %d | DataIn: %d | DataOut: %d",addr,dIn,dOut);
	end
	#100
	$stop;

end
endmodule
