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

