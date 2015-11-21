vlog -reportprogress 300 -work work cpu.v ifu.v instrdec.v lut.v regfile.v signextend.v mux.v alu.v 
vsim -voptargs="+acc" cpu

run -all