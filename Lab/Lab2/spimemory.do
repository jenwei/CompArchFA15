vlog -reportprogress 300 -work work spimemory.v datamemory.v finitestatemachine.v shiftregister.v inputconditioner.v spimemory.t.v
vsim -voptargs="+acc" testspimemory

add wave -position insertpoint \
sim:/testspimemory/clk \
sim:/testspimemory/sclk_pin \
sim:/testspimemory/cs_pin \
sim:/testspimemory/miso_pin \
sim:/testspimemory/fault_pin \
sim:/testspimemory/mosi_pin

run -all
wave zoom full