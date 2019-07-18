#mkdir -p altera_mf
#mkdir -p work
#GHDL=~/Documents/development/verilog/ghdl-llvm/bin/ghdl
#gcc -c ghdl_access.c -o ghdl_access_c.o
#nvc  -a  --relax=prefer-explicit ../roms/Altera/*.vhd ../src/Altera/ram1k_dp.vhd ../src/T65/T65_Pack.vhd ../src/T65/T65_ALU.vhd	../src/T65/T65_MCode.vhd \
nvc  -a  --relax=prefer-explicit ../vreplace/*.vhd  ../src/T65/T65_Pack.vhd ../src/T65/T65_ALU.vhd	../src/T65/T65_MCode.vhd \
	../src/T65/T65.vhd ../src/gearshift.vhd ../src/sync.vhd ../src/deltasigma.vhd ../src/screech.vhd ../src/EngineSound.vhd ../src/sprint1_sound.vhd ../src/*.vhd  sprint_sim.vhd   --dump-json out.json
