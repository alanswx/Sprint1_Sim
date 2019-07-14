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

V_SRC = \
	centipede_verilator.v \
	../roms/Altera/Char_LSB.vhd \
	../roms/Altera/Char_MSB.vhd \
	../roms/Altera/addec_prom.vhd \
	../roms/Altera/j6_prom.vhd \
	../roms/Altera/k6_prom.vhd \
	../roms/Altera/prog_rom1.vhd \
	../roms/Altera/prog_rom2.vhd \
	../roms/Altera/prog_rom3.vhd \
	../roms/Altera/prog_rom4.vhd \
	../roms/Altera/sync_prom.vhd \
	$(RTL)/T65/T65_Pack.vhd  \
	$(RTL)/T65/T65_MCode.vhd \
	$(RTL)/T65/T65_ALU.vhd \
	$(RTL)/T65/T65.vhd \
	$(RTL)/EngineSound.vhd \
	$(RTL)/Inputs.vhd \
	$(RTL)/collision.vhd \
	$(RTL)/Altera/ram1k_dp.vhd \
	$(RTL)/cpu_mem.vhd \
	$(RTL)/deltasigma.vhd \
	$(RTL)/gearshift.vhd \
	$(RTL)/motion.vhd \
	$(RTL)/playfield.vhd \
	$(RTL)/screech.vhd \
	$(RTL)/sync.vhd \
	$(RTL)/sprint1.vhd \
	$(RTL)/sprint1_sound.vhd \
	$(RTL)/Altera/clk_pll.vhd \
	$(RTL)/sprint1.vhd  

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