vlog -reportprogress 300 -work work midpoint.v shiftregister.v inputconditioner.v
vsim -voptargs="+acc" midpoint
run -all