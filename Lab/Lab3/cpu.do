vlog -reportprogress 300 -work work cpu.v ifu.v instrdec.v lut.v regfile.v signextend.v mux.v alu.v memory.v
vsim -voptargs="+acc" cpu

add wave -position insertpoint \
sim:/cpu/WriteData
run -all
wave zoom full