vlog -reportprogress 300 -work work ifu.t.v ifu.v signextend.t.v signextend.v
vsim -voptargs="+acc" testIFU
run -all