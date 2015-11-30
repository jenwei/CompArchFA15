module testCPU();
	reg clk=1; 
	cpu c(clk);
	always begin #1000 clk=!clk;
	end
endmodule
