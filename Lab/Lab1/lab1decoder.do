vlog -reportprogress 300 -work work Test_alu.v
vsim -voptargs="+acc" testALU
run -all