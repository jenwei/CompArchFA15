vlog -reportprogress 300 -work work cpu.v ifu.v instrdec.v lut.v regfile.v signextend.v mux.v alu.v memory.v cpu.t.v
vsim -voptargs="+acc" testCPU

add wave -position insertpoint \
sim:/testCPU/c/clk \
sim:/testCPU/c/ReadData1 \
sim:/testCPU/c/ReadData2 \
sim:/testCPU/c/WriteData \
sim:/testCPU/c/imm32 \
sim:/testCPU/c/imm16 \
sim:/testCPU/c/memINI/mem \
sim:/testCPU/c/ayylou/result \
sim:/testCPU/c/memINI/DataOut \
sim:/testCPU/c/memINI/DataIn
run -all
wave zoom full