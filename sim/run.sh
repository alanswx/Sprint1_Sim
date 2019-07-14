mkdir -p altera_mf
mkdir -p work
GHDL=~/Documents/development/verilog/ghdl-llvm/bin/ghdl
gcc -c ghdl_access.c -o ghdl_access_c.o
${GHDL} -a -g --std=08 --work=altera_mf --workdir=altera_mf --ieee=synopsys altera_*.vhd
${GHDL} -a -g --std=08 --workdir=work -Paltera_mf --ieee=synopsys ../src/Altera/*.vhd ../roms/Altera/*.vhd 
${GHDL} -a -g --std=08 --workdir=work -Paltera_mf --ieee=synopsys ../src/T65/T65_Pack.vhd ../src/T65/T65_ALU.vhd	../src/T65/T65_MCode.vhd \
	../src/T65/T65.vhd ../src/gearshift.vhd ../src/sync.vhd ../src/deltasigma.vhd ../src/screech.vhd ../src/EngineSound.vhd ../src/sprint1_sound.vhd ../src/*.vhd ghdl_access.vhdl sprint_sim.vhd
${GHDL} -m -g -Pwork -Paltera_mf  --std=08 --ieee=synopsys --workdir=work --ieee=synopsys -Wl,ghdl_access_c.o -Wl,-lSDL2 top 
#${GHDL} -e -g -Pwork -Paltera_mf --std=08 --ieee=synopsys --workdir=work --ieee=synopsys -Wl,ghdl_access_c.o -Wl,-lSDL2 top 
