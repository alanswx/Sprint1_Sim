#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/uio.h>
#include <unistd.h>
#include <math.h>


void write_prefix(FILE *out,char *name,int bitsq, int bitsa)
{
	fprintf(out,"module %s(input clk,\n",name);
	fprintf(out,"\tinput        reset,\n");
	fprintf(out,"\tinput [%d:0] a,\n",bitsa-1);
	fprintf(out,"\toutput [%d:0] dout,\n",bitsq-1);
	fprintf(out,"\tinput        cs_n);\n\n");
	fprintf(out,"\treg [%d:0] q;\n",bitsq-1);
	fprintf(out,"always @(posedge clk or posedge reset)\n");
	fprintf(out,"\tif (reset)\n");
	fprintf(out,"\t\ttq = 0;\n");
	fprintf(out,"\telse\n");
  	fprintf(out,"\t\tcase (a)\n");
}
void write_suffix(FILE *out,char *name)
{
	fprintf(out,"\t\tendcase\n\n");
	fprintf(out,"\tassign dout = q;\n");
	fprintf(out,"\t`ifdef debug_rom\n");
	fprintf(out,"\talways @(a)\n");
	fprintf(out,"\tif (cs_n == 0)\n");
	fprintf(out,"\t$display(\"rom: rom[%%x] -> %%x\", a, q);\n");
	fprintf(out,"\t`endif\n");
	fprintf(out,"\tendmodule // rom %s\n",name);
}

void dump_roms(char *name, char *outputname,int bits) 
{
	char fname[4096];
	int i, f, r;
        int size;
        unsigned char *data;
	struct stat st;
	stat(name, &st);
	size = st.st_size;

	sprintf(fname,"%s.v",outputname);
        printf("%s is of size %d\n",name,size);

        data = (unsigned char *)calloc(size,1);

	f = open(name, O_RDONLY);
	if (f < 0) perror(name);
	r = read(f, data, size);
	close(f);

	FILE *out = fopen(fname,"w");

	int bitsa = log2(size);
        printf("bitsa: %d - size %d\n",bitsa,size);

	write_prefix(out,outputname,bits,bitsa);
	for (i = 0; i < size; i++) {
		fprintf(out,"\t13'h%03x: q = 8'h%02x; // 0x%03x\n", i, data[i], i);
	}
	write_suffix(out,outputname);
        fclose(out);

        free(data);
}


int main(int argc, char *argv[])
{
	int i, j;


	if (argc < 4) {
		printf("usage: %s <inputfile> <outputfile> <bits>\n",argv[0]);
		exit(0);
	}
	dump_roms(argv[1],argv[2],atoi(argv[3]));

	exit(0);
}
