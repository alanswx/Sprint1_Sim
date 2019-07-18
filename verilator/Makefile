#
#
#

V = verilator
#V = /usr/local/bin/verilator
#V = /usr/local/src/verilator-3.876/bin/verilator

TOP = --top-module centipede_verilator
RTL = ../src
CPU = ../6502/bc
ROM = ../roms/v3
INC = +incdir+$(RTL) +incdir+$(CPU) +incdir+$(ROM)

DEFINE = +define+debug=1 +define+SIMULATION=1 
LDFLAGS = "-L../../sim/lib6502 -lSDL2 -lpthread -l6502"
EXE = ./tmp/Vcentipede_verilator
OPT = -O2 
CFLAGS = "-O -DCOSIM=0 -I../../emu/famec"

#V_SRC = \
#	centipede_verilator.v \
#	$(RTL)/centipede.v $(RTL)/p6502.v $(RTL)/pokey.v \
#	$(RTL)/ram.v $(RTL)/rom.v \
#	$(RTL)/color_ram.v $(RTL)/pf_ram.v $(RTL)/pf_rom.v \
#	$(RTL)/pf_ram_dp.v \
#	$(RTL)/vprom.v $(RTL)/hs_ram.v


#V_SRC = \
#	../roms/Altera/Char_LSB.vhd 

V_SRC = \
	../vreplace/Char_LSB.vhd \
	../vreplace/Char_MSB.vhd \
	../vreplace/addec_prom.vhd \
	../vreplace/j6_prom.vhd \
	../vreplace/k6_prom.vhd \
	../vreplace/prog_rom1.vhd \
	../vreplace/prog_rom2.vhd \
	../vreplace/prog_rom3.vhd \
	../vreplace/prog_rom4.vhd \
	../vreplace/ram.v \
	../vreplace/sync_prom.vhd \
	$(RTL)/T65/T65_Pack.vhd  \
	$(RTL)/T65/T65_MCode.vhd \
	$(RTL)/T65/T65_ALU.vhd \
	$(RTL)/T65/T65.vhd \
	$(RTL)/EngineSound.vhd \
	$(RTL)/Inputs.vhd \
	$(RTL)/collision.vhd \
	$(RTL)/cpu_mem.vhd \
	$(RTL)/deltasigma.vhd \
	$(RTL)/gearshift.vhd \
	$(RTL)/motion.vhd \
	$(RTL)/playfield.vhd \
	$(RTL)/screech.vhd \
	$(RTL)/sync.vhd \
	$(RTL)/sprint1.vhd \
	$(RTL)/sprint1_sound.vhd \
	$(RTL)/sprint1.vhd   \
	centipede_verilator.v 

C_SRC = \
	centipede_verilator.cpp vga.cpp cosim.cpp

VOUT = tmp/Vcentipede_verilator.cpp

all: $(EXE)

$(VOUT): $(V_SRC)  Makefile
	$V -cc $(OPT) -LDFLAGS $(LDFLAGS) -exe --Mdir ./tmp $(DEFINE) $(INC) $(TOP) -CFLAGS $(CFLAGS) $(V_SRC) $(C_SRC)

$(EXE): $(VOUT) $(C_SRC)
	(cd tmp; make -f Vcentipede_verilator.mk)

clean:
	rm -f tmp/*
