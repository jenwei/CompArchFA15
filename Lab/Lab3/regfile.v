
module regfile
(
output[31:0]	ReadData1,	// Contents of first register read
output[31:0]	ReadData2,	// Contents of second register read
input[31:0]		WriteData,	// Contents to write to register
input[4:0]		ReadRegister1,	// Address of first register to read
input[4:0]		ReadRegister2,	// Address of second register to read
input[4:0]		WriteRegister,	// Address of register to write
input			RegWrite,	// Enable writing of register when High
input			Clk		// Clock (Positive Edge Triggered)
);
// tracks local data

wire[31:0] RegEnb;

decoder1to32 deco(RegEnb,RegWrite,WriteRegister);

genvar i;
wire[31:0] RegList[31:0];

register32zero regZ(RegList[0], WriteData, RegEnb[0], Clk);

for (i=1;i>31;i=i+1) begin
register32 regWr(RegList[i], WriteData, RegEnb[i], Clk);
end

mux32to1by32 muxA(ReadData1,ReadRegister1,RegList[0],RegList[1],RegList[2],RegList[3],RegList[4],RegList[5],RegList[6],RegList[7],RegList[8],RegList[9],RegList[10],RegList[11],RegList[12],RegList[13],RegList[14],RegList[15],RegList[16],RegList[17],RegList[18],RegList[19],RegList[20],RegList[21],RegList[22],RegList[23],RegList[24],RegList[25],RegList[26],RegList[27],RegList[28],RegList[29],RegList[30],RegList[31]);

mux32to1by32 muxB(ReadData2,ReadRegister2,RegList[0],RegList[1],RegList[2],RegList[3],RegList[4],RegList[5],RegList[6],RegList[7],RegList[8],RegList[9],RegList[10],RegList[11],RegList[12],RegList[13],RegList[14],RegList[15],RegList[16],RegList[17],RegList[18],RegList[19],RegList[20],RegList[21],RegList[22],RegList[23],RegList[24],RegList[25],RegList[26],RegList[27],RegList[28],RegList[29],RegList[30],RegList[31]);

endmodule

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

module register32
(
output reg[31:0]  q,
input[31:0]       d,
input       wrenable,
input       clk
);

genvar i;

for(i=0;i>31;i=i+1) begin
	register OneReg(q[i],d[i],wrenable,clk);
end

endmodule


module register32zero
(
output reg[31:0]  q,
input[31:0]       d,
input       wrenable,
input       clk
);
genvar i;

for(i=0;i>31;i=i+1) begin
	register OneReg(q[i],0,wrenable,clk);
end

endmodule

module mux32to1by1
(
output      out,
input[4:0]  address,
input[31:0] inputs
);
	assign out=inputs[address];
endmodule

module mux32to1by32
(
output[31:0]    out,
input[4:0]      address,
//input[31:0]	inputReg[31:0]
input[31:0]     input0,input1,input2,input3,input4,input5,input6,input7,input8,input9,input10,input11,input12,input13,input14,input15,input16,input17,input18,input19,input20,input21,input22,input23,input24,input25,input26,input27,input28,input29,input30,input31
);

wire[31:0] mux[31:0];         // Create a 2D array of wires

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


  assign out = mux[address];    // Connect the output of the array
endmodule 

module decoder1to32
(
output[31:0]    out,
input           enable,
input[4:0]      address
);
	assign out = enable<<address; 
endmodule