vlog -reportprogress 300 -work work stepbystep.v
vsim -voptargs="+acc" testeverything
run -all