vlog -reportprogress 300 -work work teststruggs.v
vsim -voptargs="+acc" testest
run -all