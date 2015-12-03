vlog -reportprogress 300 -work work memory.t.v memory.v
vsim -voptargs="+acc" testMEMORY
run -all