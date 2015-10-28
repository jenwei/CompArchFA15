// Single-bit D Flip-Flop with enable
// Positive edge triggered
module register
(
output reg	q,
input		d,
input		wrenable,
input		clk
);

    always @(posedge clk) begin
        if(wrenable) begin
            q = d;
        end
    end
endmodule

// module for a register made up of 32-bits worth of D flip flops
module register32 (q,d,wrenable,clk);
output wire[31:0] q;
input[31:0] d;
input wrenable;
input clk;

// using a loop to generate 32 1-bit registers
genvar index;
generate
for (index=0; index<32; index=index+1)begin
register OneBitRegister(q[index],d[index],wrenable,clk);
end
endgenerate
endmodule

// module that always outputs 0
module register32zero(q,d,wrenable,clk);
output reg[31:0] q;
input[31:0] d;
input wrenable;
input clk;

// using a loop to set all bits of q to 0
genvar index;
generate
for (index=0; index<32; index=index+1)begin
always @* begin
	q[index]=0;
end
end
endgenerate
endmodule
