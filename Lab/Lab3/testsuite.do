vlog -reportprogress 300 -work work regfile.t.v regfile.v signextend.v signextend.t.v lut.t.v lut.v instrdec.v instrdec.t.v ifu.t.v ifu.v datamem.v datamem.t.v alu.v alu.t.v
vsim -voptargs="+acc" testREGFILE testSIGNEXTEND testLUT testINSTRDEC testIFU testDATAMEM testALU
run -all
