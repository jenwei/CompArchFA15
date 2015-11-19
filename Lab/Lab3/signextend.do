vlog -reportprogress 300 -work work signextend.v signextend.t.v
vsim -voptargs="+acc" testSIGNEXTEND
run -all