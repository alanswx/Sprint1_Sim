module addec_prom(input clock,
	input [4:0] address,
	output [7:0] q
	);

	reg [7:0] qq;
always @(posedge clk )
		case (address)
	13'h000: qq = 8'h11; // 0x000
	13'h001: qq = 8'h11; // 0x001
	13'h002: qq = 8'h01; // 0x002
	13'h003: qq = 8'h01; // 0x003
	13'h004: qq = 8'h41; // 0x004
	13'h005: qq = 8'h41; // 0x005
	13'h006: qq = 8'h81; // 0x006
	13'h007: qq = 8'h81; // 0x007
	13'h008: qq = 8'hc1; // 0x008
	13'h009: qq = 8'hc1; // 0x009
	13'h00a: qq = 8'h21; // 0x00a
	13'h00b: qq = 8'h21; // 0x00b
	13'h00c: qq = 8'he1; // 0x00c
	13'h00d: qq = 8'he1; // 0x00d
	13'h00e: qq = 8'he1; // 0x00e
	13'h00f: qq = 8'he1; // 0x00f
	13'h010: qq = 8'he0; // 0x010
	13'h011: qq = 8'he0; // 0x011
	13'h012: qq = 8'he8; // 0x012
	13'h013: qq = 8'he8; // 0x013
	13'h014: qq = 8'he4; // 0x014
	13'h015: qq = 8'he4; // 0x015
	13'h016: qq = 8'hec; // 0x016
	13'h017: qq = 8'hec; // 0x017
	13'h018: qq = 8'he2; // 0x018
	13'h019: qq = 8'he2; // 0x019
	13'h01a: qq = 8'hea; // 0x01a
	13'h01b: qq = 8'hea; // 0x01b
	13'h01c: qq = 8'he6; // 0x01c
	13'h01d: qq = 8'he6; // 0x01d
	13'h01e: qq = 8'hee; // 0x01e
	13'h01f: qq = 8'hee; // 0x01f
		endcase

	assign q = qq;
	endmodule // rom addec_prom
