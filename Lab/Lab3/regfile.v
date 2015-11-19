//------------------------------------------------------------------------------
// MIPS register file
//   width: 32 bits
//   depth: 32 words (reg[0] is static zero register)
//   2 asynchronous read ports
//   1 synchronous, positive edge triggered write port
//------------------------------------------------------------------------------

module regfile
(
output[31:0]	ReadData1,	// Contents of first register read
output[31:0]	ReadData2,	// Contents of second register read
input[31:0]	WriteData,	// Contents to write to register
input[4:0]	ReadRegister1,	// Address of first register to read
input[4:0]	ReadRegister2,	// Address of second register to read
input[4:0]	WriteRegister,	// Address of register to write
input		RegWrite,	// Enable writing of register when High
input		Clk		// Clock (Positive Edge Triggered)
);

  // These two lines are clearly wrong.  They are included to showcase how the 
  // test harness works. Delete them after you understand the testing process, 
  // and replace them with your actual code.
  // assign ReadData1 = 42;
  // assign ReadData2 = 42;
wire[31:0] DecodeOut;
wire [31:0] RegOut0,RegOut1,RegOut2,RegOut3,RegOut4,RegOut5,RegOut6,RegOut7,RegOut8,RegOut9,RegOut10,RegOut11,RegOut12,RegOut13,RegOut14,RegOut15,RegOut16,RegOut17,RegOut18,RegOut19,RegOut20,RegOut21,RegOut22,RegOut23,RegOut24,RegOut25,RegOut26,RegOut27,RegOut28,RegOut29,RegOut30,RegOut31;

// implementing the verilog version of the register file structure provided in the readme

// decoder setup
decoder1to32 decode(DecodeOut,RegWrite,WriteRegister);

// register setup
register32zero register0(RegOut0,WriteData,DecodeOut[0],Clk);
register32 reg1(RegOut1,WriteData,DecodeOut[1],Clk);
register32 reg2(RegOut2,WriteData,DecodeOut[2],Clk);
register32 reg3(RegOut3,WriteData,DecodeOut[3],Clk);
register32 reg4(RegOut4,WriteData,DecodeOut[4],Clk);
register32 reg5(RegOut5,WriteData,DecodeOut[5],Clk);
register32 reg6(RegOut6,WriteData,DecodeOut[6],Clk);
register32 reg7(RegOut7,WriteData,DecodeOut[7],Clk);
register32 reg8(RegOut8,WriteData,DecodeOut[8],Clk);
register32 reg9(RegOut9,WriteData,DecodeOut[9],Clk);
register32 reg10(RegOut10,WriteData,DecodeOut[10],Clk);
register32 reg11(RegOut11,WriteData,DecodeOut[11],Clk);
register32 reg12(RegOut12,WriteData,DecodeOut[12],Clk);
register32 reg13(RegOut13,WriteData,DecodeOut[13],Clk);
register32 reg14(RegOut14,WriteData,DecodeOut[14],Clk);
register32 reg15(RegOut15,WriteData,DecodeOut[15],Clk);
register32 reg16(RegOut16,WriteData,DecodeOut[16],Clk);
register32 reg17(RegOut17,WriteData,DecodeOut[17],Clk);
register32 reg18(RegOut18,WriteData,DecodeOut[18],Clk);
register32 reg19(RegOut19,WriteData,DecodeOut[19],Clk);
register32 reg20(RegOut20,WriteData,DecodeOut[20],Clk);
register32 reg21(RegOut21,WriteData,DecodeOut[21],Clk);
register32 reg22(RegOut22,WriteData,DecodeOut[22],Clk);
register32 reg23(RegOut23,WriteData,DecodeOut[23],Clk);
register32 reg24(RegOut24,WriteData,DecodeOut[24],Clk);
register32 reg25(RegOut25,WriteData,DecodeOut[25],Clk);
register32 reg26(RegOut26,WriteData,DecodeOut[26],Clk);
register32 reg27(RegOut27,WriteData,DecodeOut[27],Clk);
register32 reg28(RegOut28,WriteData,DecodeOut[28],Clk);
register32 reg29(RegOut29,WriteData,DecodeOut[29],Clk);
register32 reg30(RegOut30,WriteData,DecodeOut[30],Clk);
register32 reg31(RegOut31,WriteData,DecodeOut[31],Clk);

// setting up the muxes
mux32to1by32 mux1(ReadData1,ReadRegister1,RegOut0,RegOut1,RegOut2,RegOut3,RegOut4,RegOut5,RegOut6,RegOut7,RegOut8,RegOut9,RegOut10,RegOut11,RegOut12,RegOut13,RegOut14,RegOut15,RegOut16,RegOut17,RegOut18,RegOut19,RegOut20,RegOut21,RegOut22,RegOut23,RegOut24,RegOut25,RegOut26,RegOut27,RegOut28,RegOut29,RegOut30,RegOut31);
mux32to1by32 mux2(ReadData2,ReadRegister2,RegOut0,RegOut1,RegOut2,RegOut3,RegOut4,RegOut5,RegOut6,RegOut7,RegOut8,RegOut9,RegOut10,RegOut11,RegOut12,RegOut13,RegOut14,RegOut15,RegOut16,RegOut17,RegOut18,RegOut19,RegOut20,RegOut21,RegOut22,RegOut23,RegOut24,RegOut25,RegOut26,RegOut27,RegOut28,RegOut29,RegOut30,RegOut31);

endmodule

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

// module for 32:1 multiplexer 
// this module uses the `deliverable5script` python script to generate the 32 inputs
module mux32to1by1(out,address,inputs);
output out;
input[4:0] address;
input[31:0] inputs;

assign out=inputs[address];
endmodule

// module for 32 input 32:1 multiplexer
module mux32to1by32(out,address,input0,input1,input2,input3,input4,input5,input6,input7,input8,input9,input10,input11,input12,input13,input14,input15,input16,input17,input18,input19,input20,input21,input22,input23,input24,input25,input26,input27,input28,input29,input30,input31);
output[31:0] out;

input[4:0] address;

input[31:0] input0;
input[31:0] input1;
input[31:0] input2;
input[31:0] input3;
input[31:0] input4;
input[31:0] input5;
input[31:0] input6;
input[31:0] input7;
input[31:0] input8;
input[31:0] input9;
input[31:0] input10;
input[31:0] input11;
input[31:0] input12;
input[31:0] input13;
input[31:0] input14;
input[31:0] input15;
input[31:0] input16;
input[31:0] input17;
input[31:0] input18;
input[31:0] input19;
input[31:0] input20;
input[31:0] input21;
input[31:0] input22;
input[31:0] input23;
input[31:0] input24;
input[31:0] input25;
input[31:0] input26;
input[31:0] input27;
input[31:0] input28;
input[31:0] input29;
input[31:0] input30;
input[31:0] input31;

// Create a 2D array of wires
wire[31:0] mux[31:0]; 

// Connect the sources of the array 32 times (not the most efficient method, but it works)
assign mux[0] = input0; 
assign mux[1] = input1;
assign mux[2] = input2;
assign mux[3] = input3;
assign mux[4] = input4;
assign mux[5] = input5;
assign mux[6] = input6;
assign mux[7] = input7;
assign mux[8] = input8;
assign mux[9] = input9;
assign mux[10] = input10;
assign mux[11] = input11;
assign mux[12] = input12;
assign mux[13] = input13;
assign mux[14] = input14;
assign mux[15] = input15;
assign mux[16] = input16;
assign mux[17] = input17;
assign mux[18] = input18;
assign mux[19] = input19;
assign mux[20] = input20;
assign mux[21] = input21;
assign mux[22] = input22;
assign mux[23] = input23;
assign mux[24] = input24;
assign mux[25] = input25;
assign mux[26] = input26;
assign mux[27] = input27;
assign mux[28] = input28;
assign mux[29] = input29;
assign mux[30] = input30;
assign mux[31] = input31;

// Connect the output of the array
assign out = mux[address]; 
endmodule

// 32 bit decoder with enable signal
//   enable=0: all output bits are 0
//   enable=1: out[address] is 1, all other outputs are 0
module decoder1to32
(
output[31:0]	out,
input		enable,
input[4:0]	address
);

    assign out = enable<<address; 

endmodule
