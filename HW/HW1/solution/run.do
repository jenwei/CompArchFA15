vlog -reportprogress 300 -work work demorgan.t.v
vsim -voptargs="+acc" demorgan_test
run 5000
