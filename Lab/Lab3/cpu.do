vlog -reportprogress 300 -work work cpu.v cpu.t.v
vsim -voptargs="+acc" testCPU
run -all