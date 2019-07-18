#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/uio.h>
#include <unistd.h>
#include <math.h>
#include <limits.h>

void itobxbit(int x, char *buf,int width)
{
  unsigned char *ptr = (unsigned char *)&x;
  int pos = 0;
  for (int i = sizeof(int) - 1; i >= 0; i--)
    for (int j = CHAR_BIT - 1; j >= 0; j--)
      {
         buf[pos++] = '0' + !!(ptr[i] & 1U << j);
      }
  buf[pos] = '\0';

  // trim leading 0s
  int totrim = pos - width ;
  if (pos>0) {
    strcpy(buf,&buf[totrim]);
  }

}

void itob4bit(int x, char *buf, int width)
{
  unsigned char *ptr = (unsigned char *)&x;
  int pos = 0;
  for (int i = 1 - 1; i >= 0; i--)
    for (int j = width - 1; j >= 0; j--)
      buf[pos++] = '0' + !!(ptr[i] & 1U << j);
  buf[pos] = '\0';
}

void itob8bit(int x, char *buf, int width)
{
  unsigned char *ptr = (unsigned char *)&x;
  int pos = 0;
  for (int i = 1 - 1; i >= 0; i--)
    for (int j = width - 1; j >= 0; j--)
      buf[pos++] = '0' + !!(ptr[i] & 1U << j);
  buf[pos] = '\0';
}
void itob(int x, char *buf, int width) {
if (width==4) {
  itob4bit(x, buf, width);
}
else {
  itob8bit(x, buf, width);
}
}

void write_vhdl_prefix(FILE *out,char *name,int bitsq, int bitsa) 
{
	fprintf(out,"library IEEE;\n");
	fprintf(out,"use IEEE.STD_LOGIC_1164.all;\n");
	fprintf(out,"use IEEE.STD_LOGIC_ARITH.all;\n");
	fprintf(out,"use IEEE.STD_LOGIC_UNSIGNED.all;\n");
	fprintf(out,"ENTITY %s IS\n",name);
	fprintf(out,"PORT\n");
        fprintf(out,"(\n");
        fprintf(out,"\taddress         : IN STD_LOGIC_VECTOR (%d DOWNTO 0);\n",bitsa-1);
        fprintf(out,"\tclock           : IN STD_LOGIC  := '1';\n");
        fprintf(out,"\tq               : OUT STD_LOGIC_VECTOR (%d DOWNTO 0)\n",bitsq-1);
        fprintf(out,");\n");
	fprintf(out,"END %s; \n",name);
	fprintf(out,"ARCHITECTURE SYN OF %s IS	\n",name);
        fprintf(out,"signal qq : STD_LOGIC_VECTOR (%d DOWNTO 0);\n",bitsq-1);
        fprintf(out,"begin\n");
        fprintf(out,"q<=qq;\n");
        fprintf(out,"PROCESS (address)\n");
        fprintf(out,"begin\n");
        fprintf(out,"CASE address IS \n");
}
void write_vhdl_suffix(FILE *out,char *name)
{
        //fprintf(out,"\twhen others => qq <= 'X';\n");
	fprintf(out,"END CASE; \n");
	fprintf(out,"END PROCESS; \n");
	fprintf(out,"END SYN; \n");

}

void write_prefix(FILE *out,char *name,int bitsq, int bitsa)
{
	fprintf(out,"module %s(input clock,\n",name);
	fprintf(out,"\tinput [%d:0] address,\n",bitsa-1);
	fprintf(out,"\toutput [%d:0] q\n",bitsq-1);
	fprintf(out,"\t);\n\n");
	fprintf(out,"\treg [%d:0] qq;\n",bitsq-1);
	fprintf(out,"always @(posedge clk )\n");
  	fprintf(out,"\t\tcase (address)\n");
}
void write_suffix(FILE *out,char *name)
{
	fprintf(out,"\t\tendcase\n\n");
	fprintf(out,"\tassign q = qq;\n");
	fprintf(out,"\tendmodule // rom %s\n",name);
}

void dump_vhdl_roms(char *name, char *outputname,int bits) 
{
	char fname[4096];
	int i, f, r;
        int size;
        unsigned char *data;
	struct stat st;
	stat(name, &st);
	size = st.st_size;

	sprintf(fname,"%s.vhd",outputname);
        printf("%s is of size %d\n",name,size);

        data = (unsigned char *)calloc(size,1);

	f = open(name, O_RDONLY);
	if (f < 0) perror(name);
	r = read(f, data, size);
	close(f);

	FILE *out = fopen(fname,"w");

	int bitsa = log2(size);
        printf("bitsa: %d - size %d\n",bitsa,size);


	write_vhdl_prefix(out,outputname,bits,bitsa);
               char buffer[4096];
               char addrbuf[4096];
	for (i = 0; i < size; i++) {
               itob (data[i],buffer,bits);
		itobxbit(i, addrbuf,bitsa);

		//fprintf(out,"\twhen x\"%02x\" => qq <= x\"%02x\"; -- 0x%03x\n", i, data[i], i);
		//fprintf(out,"\twhen x\"%02x\" => qq <= \"%s\"; -- 0x%03x\n", i, buffer, i);
		fprintf(out,"\twhen \"%s\" => qq <= \"%s\"; -- 0x%03x\n", addrbuf, buffer, i);
	}
        itob (0,buffer,bits);
        fprintf(out,"\twhen others => qq <= \"%s\";\n",buffer);
	write_vhdl_suffix(out,outputname);
        fclose(out);

        free(data);
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
		fprintf(out,"\t13'h%03x: qq = 8'h%02x; // 0x%03x\n", i, data[i], i);
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
	dump_vhdl_roms(argv[1],argv[2],atoi(argv[3]));

	exit(0);
}
