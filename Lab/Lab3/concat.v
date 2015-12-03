module concat(imm16,targetAddr,clk,Rt,Rs,Rd,Shamt,Funct);
output[15:0] imm16;
output[31:0] targetAddr;

input clk, Rt, Rs, Rd, Shamt, Funct;

assign imm16 = {rd,Shamt,Funct};
assign targetInstr = {Rt, Rs, Rd, Shamt, Funct};

endmodule
