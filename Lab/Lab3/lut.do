vlog -reportprogress 300 -work work lut.t.v lut.v
vsim -voptargs="+acc" testLUT
run -all