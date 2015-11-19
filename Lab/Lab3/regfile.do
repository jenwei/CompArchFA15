vlog -reportprogress 300 -work work regfile.t.v regfile.v
vsim -voptargs="+acc" testREGFILE

add wave -position insertpoint  \
sim:/testREGFILE/ReadData1 \
sim:/testREGFILE/ReadData2 \
sim:/testREGFILE/WriteData \
sim:/testREGFILE/ReadRegister1 \
sim:/testREGFILE/ReadRegister2 \
sim:/testREGFILE/WriteRegister \
sim:/testREGFILE/RegWrite \
sim:/testREGFILE/Clk \
sim:/testREGFILE/begintest \
sim:/testREGFILE/endtest \
sim:/testREGFILE/dutpassed \
sim:/testREGFILE/DUT/RegOut2 \
sim:/testREGFILE/DUT/DecodeOut \
sim:/testREGFILE/DUT/reg2/q \
sim:/testREGFILE/DUT/reg2/d \
sim:/testREGFILE/DUT/reg2/wrenable
run -all

wave zoom full