vlog -reportprogress 300 -work work finitestatemachine.v finitestatemachine.t.v
vsim -voptargs="+acc" testFSM
run -all