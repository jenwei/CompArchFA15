vlog -reportprogress 300 -work work alu.v
vsim -voptargs="+acc" testDecoder
run -all