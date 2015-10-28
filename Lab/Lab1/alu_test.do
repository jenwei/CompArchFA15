vlog -reportprogress 300 -work work alu_test.v
vsim -voptargs="+acc" alu_test
sim:/testAdder32bit/a \
sim:/testAdder32bit/b \
sim:/testAdder32bit/sum \
sim:/testAdder32bit/carryout \
sim:/testAdder32bit/overflow
run -all