vlog -reportprogress 300 -work work register.v
vsim -voptargs="+acc" register
run -all
