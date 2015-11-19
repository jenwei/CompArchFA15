vlog -reportprogress 300 -work work datamem.v datamem.t.v
vsim -voptargs="+acc" testDATAMEM

add wave -position insertpoint  \
sim:/testDATAMEM/clk \
sim:/testDATAMEM/dOut \
sim:/testDATAMEM/addr \
sim:/testDATAMEM/wrEn \
sim:/testDATAMEM/dIn
run -all

wave zoom full