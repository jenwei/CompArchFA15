vlog -reportprogress 300 -work work alu.v alu.t.v
vsim -voptargs="+acc" testALU
run -all