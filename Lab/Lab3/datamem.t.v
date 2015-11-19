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
		#40;
	//$display("Address: %d | DataIn: %d | DataOut: %d",addr,dIn,dOut);
		if (dOut != dIn) begin
			$display("DUT Failed! Values were: wrEn: %b | Address: %d | DataIn: %d | DataOut: %d",wrEn,addr,dIn,dOut);
			$stop;
		end
	end
	
	wrEn=0;

	for(i=0;i<31;i=i+1)begin
		addr = 2;
		dIn = i; 
		#40;
		if (dOut != 30) begin
			$display("DUT Failed! Values were: wrEn: %b | Address: %d | DataIn: %d | DataOut: %d",wrEn,addr,dIn,dOut);
			$stop;
		end
	//$display("Address: %d | DataIn: %d | DataOut: %d",addr,dIn,dOut);
	end

	for(i=0;i<31;i=i+1)begin
		addr = i;
		dIn = i; 
		#20;
		if (dOut == dIn) begin
			$display("DUT Failed! Values were: wrEn: %b | Address: %d | DataIn: %d | DataOut: %d",wrEn,addr,dIn,dOut);
			$stop;
		end
	//$display("Address: %d | DataIn: %d | DataOut: %d",addr,dIn,dOut);
	end
	
	wrEn = 1;

	for(i=0;i<31;i=i+1)begin
		addr = i**2;
		dIn = i; 
		#40;
		if (dOut != dIn) begin
			$display("DUT Failed! Values were: wrEn: %b | Address: %d | DataIn: %d | DataOut: %d",wrEn,addr,dIn,dOut);
			$stop;
		end
	//$display("Address: %d | DataIn: %d | DataOut: %d",addr,dIn,dOut);
	end
	#100
	$display("All Tests PASEED!");
	$stop;

end
endmodule
