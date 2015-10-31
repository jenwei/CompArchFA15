vlog -reportprogress 300 -work work inputconditioner.v inputconditioner.t.v
vsim -voptargs="+acc" testConditioner

add wave -position insertpoint  \
sim:/testConditioner/clk \
sim:/testConditioner/pin \
sim:/testConditioner/conditioned \
sim:/testConditioner/rising \
sim:/testConditioner/falling
run -all

wave zoom full