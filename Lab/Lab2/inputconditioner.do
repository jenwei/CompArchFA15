vlog -reportprogress 300 -work work inputconditioner.v inputconditioner.t.v
vsim -voptargs="+acc" testconditioner

add wave -position insertpoint  \
sim:/testconditioner/clk \
sim:/testconditioner/pin \
sim:/testconditioner/conditioned \
sim:/testconditioner/rising \ 
sim:/testconditioner/falling 
run -all

wave zoom full