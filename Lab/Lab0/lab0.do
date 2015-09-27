vlog -reportprogress 300 -work work adder.v
vsim -voptargs="+acc" testFullAdder4bit
add wave -position insertpoint  \
sim:/testFullAdder4bit/a \
sim:/testFullAdder4bit/b \
sim:/testFullAdder4bit/sum \
sim:/testFullAdder4bit/carryout \
sim:/testFullAdder4bit/overflow
run -all
wave zoom full