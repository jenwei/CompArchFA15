vlog -reportprogress 300 -work work spimemory.v datamemory.v finitestatemachine.v shiftregister.v inputconditioner.v
vsim -voptargs="+acc" finitestatemachine
run -all