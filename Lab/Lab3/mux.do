vlog -reportprogress 300 -work work mux.v
vsim -voptargs="+acc" mux
run -all