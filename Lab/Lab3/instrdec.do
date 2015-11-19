vlog -reportprogress 300 -work work instrdec.v instrdec.t.v
vsim -voptargs="+acc" testINSTRDEC
run -all