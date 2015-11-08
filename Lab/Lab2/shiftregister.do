vlog -reportprogress 600 -work work shiftregister.v shiftregister.t.v
vsim -voptargs="+acc" testshiftregister

add wave -position insertpoint \
sim:/testshiftregister/clk \
sim:/testshiftregister/peripheralClkEdge \
sim:/testshiftregister/parallelLoad \
sim:/testshiftregister/parallelDataIn \
sim:/testshiftregister/serialDataIn \
sim:/testshiftregister/parallelDataOut \
sim:/testshiftregister/serialDataOut

run -all
wave zoom full