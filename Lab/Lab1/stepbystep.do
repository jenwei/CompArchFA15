vlog -reportprogress 300 -work work alu.v
vsim -voptargs="+acc" testeverything
run -all