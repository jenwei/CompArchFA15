module testSIGNEXTEND;
wire[31:0]	imm32;
reg[15:0]	imm16;
reg		i;

signextend yolo(imm32, imm16);

initial begin


imm16 = 16'habcd;
#20
$display("%b %b", imm16, imm32); 
imm16 = 16'h7bcd;
#20
$display("%b %b", imm16, imm32); 
imm16 = 16'h8bc3;
#20
$display("%b %b", imm16, imm32); 
imm16 = 16'ha0cd;
#20
$display("%b %b", imm16, imm32); 
imm16 = 16'habc2;
#20
$display("%b %b", imm16, imm32); 
imm16 = 16'habc5;
#20
$display("%b %b", imm16, imm32); 
imm16 = 16'habcd;
#20
$display("%b %b", imm16, imm32); 
imm16 = 16'h0bcd;
#20
$display("%b %b", imm16, imm32); 
imm16 = 16'habc1;
#20
$display("%b %b", imm16, imm32); 
imm16 = 16'hafcd;
#20
$display("%b %b", imm16, imm32); 
imm16 = 16'h9bc1;
#20
$display("%b %b", imm16, imm32); 


$stop;
end
endmodule
