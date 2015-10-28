vlog -reportprogress 300 -work work regfile.t.v decoders.v multiplexer.v register.v regfile.v
vsim -voptargs="+acc" hw4testbenchharness 

add wave -position insertpoint  \
sim:/hw4testbenchharness/ReadData1 \
sim:/hw4testbenchharness/ReadData2 \
sim:/hw4testbenchharness/WriteData \
sim:/hw4testbenchharness/ReadRegister1 \
sim:/hw4testbenchharness/ReadRegister2 \
sim:/hw4testbenchharness/WriteRegister \
sim:/hw4testbenchharness/RegWrite \
sim:/hw4testbenchharness/Clk \
sim:/hw4testbenchharness/begintest \
sim:/hw4testbenchharness/endtest \
sim:/hw4testbenchharness/dutpassed \
sim:/hw4testbenchharness/DUT/RegOut2 \
sim:/hw4testbenchharness/DUT/DecodeOut \
sim:/hw4testbenchharness/DUT/reg2/q \
sim:/hw4testbenchharness/DUT/reg2/d \
sim:/hw4testbenchharness/DUT/reg2/wrenable
run -all

wave zoom full