./dumpcode 6396-01.p4 Char_LSB 4
./dumpcode 6397-01.r4 Char_MSB 4
./dumpcode 6401-01.e2 addec_prom 8
./dumpcode 6399-01.j6 j6_prom 4
./dumpcode 6398-01.k6 k6_prom 4
./dumpcode 6290-01.b1 prog_rom1 8
./dumpcode 6291-01.c1 prog_rom2 8
./dumpcode 6442-01.d1 prog_rom3 8
./dumpcode 6443-01.e1 prog_rom4 8
./dumpcode 6400-01.m2 sync_prom 4

mv *.v ../vreplace/
mv *.vhd ../vreplace/
