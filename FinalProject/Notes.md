##Notes!
---
######Here are the notes from all the readings/resources we go through
---
- Hardware Secrets <http://www.hardwaresecrets.com/inside-the-intel-sandy-bridge-microarchitecture/>

#####Background
- Sandy Bridge --> Intel CPU microarchitecture from 2011 evolved from the Nehalem microarchitecture 
that builds off Core architecture, tweaked with the addition of an integrated memory controller, and
Core is built off Pentium M

#####Pentium M
- Pentium M is different from Pentium 4 M and Pentium III M
- Works like Pentium 4 - Transfers 4 data per clock cycle (Quad Data Rate) and makes the local bus have 
a performance four times its actual clock rate
- Two 32KB L1 memory caches (one for data one for instructions)
- L2 memory caches up to 512 KB
- Support for SSE2 instructions
- Redesigned and improved branch prediction
- Micro-ops fusion for instruction decoder (saves energy and improves performance)
- Enhanced SpeedStep Technology --> allows CPU to reduce clock while idle to save battery
- Pipeline not disclosed - similar to Pentium III but with more stages
![](http://www.hardwaresecrets.com/wp-content/uploads/270_011.gif)
- x86 instructions don't have fixed length
- Memory Cache and Fetch Unit
![](http://www.hardwaresecrets.com/wp-content/uploads/270_021.gif)
- Instruction Decoder and Register Renaming
- CISC x86 instructions = "instructions, while internal RISC instructions = "microinstructions" or "micro-ops"
![](http://www.hardwaresecrets.com/wp-content/uploads/270_031.gif)
- Reorder Buffer
![](http://www.hardwaresecrets.com/wp-content/uploads/270_041.gif)
- Reservation Station and Execution Units
![](http://www.hardwaresecrets.com/wp-content/uploads/270_051.gif)
- Enhanced SpeedStep Technology allows CPU to switch between multiple clock and voltage configurations by 
monitoring specific MSRs (Model Specific Registers) from the CPU called Performance Counters such that 
increasing CPU usage increases voltage/clock and vice versa

