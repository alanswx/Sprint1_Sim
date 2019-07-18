//
//
//

`timescale 1ns/1ns

`define SDL_DISPLAY

module centipede_verilator;

   reg clk/*verilator public_flat*/;
   reg reset/*verilator public_flat*/;

   wire [8:0] rgb;
   wire       csync, hsync, vsync, hblank, vblank;
   wire [7:0] audio;
   wire [3:0] led/*verilator public_flat*/;

   reg [7:0]  trakball/*verilator public_flat*/;
   reg [7:0]  joystick/*verilator public_flat*/;
   reg [7:0]  sw1/*verilator public_flat*/;
   reg [7:0]  sw2/*verilator public_flat*/;
   reg [9:0]  playerinput/*verilator public_flat*/;

SPRINT1 SPRINT1(
	.Clk_50_I(CLK_50M),
	.Reset_n(~(RESET | status[0] | buttons[1] | ioctl_download)),

	.dn_addr(ioctl_addr[16:0]),
	.dn_data(ioctl_data),
	.dn_wr(ioctl_wr),

	.VideoW_O(videowht),
	.VideoB_O(videoblk),

	.Sync_O(compositesync),
	.Audio1_O(audio),
	.Coin1_I(~(m_coin|btn_coin_1)),
	.Coin2_I(~(m_coin|btn_coin_2)),
	.Start_I(~(m_start1|btn_start_1)),
	.Gas_I(~m_gas),
	.Gear1_I(gear1),
	.Gear2_I(gear2),
	.Gear3_I(gear3),
	.gear_shift(gear),
	.Test_I	(~status[13]),
	.SteerA_I(steer[1]),
	.SteerB_I(steer[0]),
	.StartLamp_O(lamp),
	.hs_O(hs),
	.vs_O(vs),
	.hblank_O(hblank),
	.vblank_O(vblank),
	.clk_12(clk_12),
	.clk_6_O(CLK_VIDEO_2),
	.SW1_I(SW1)
	);
			  
/* 
   centipede uut(
		 .clk_12mhz(clk),
 		 .reset(reset),
		 .playerinput_i(playerinput),
		 .trakball_i(trakball),
		 .joystick_i(joystick),
		 .sw1_i(sw1),
		 .sw2_i(sw2),
		 .led_o(led),
		 .rgb_o(rgb),
		 .sync_o(csync),
		 .hsync_o(hsync),
		 .vsync_o(vsync),
		 .hblank_o(hblank),
		 .vblank_o(vblank),
		 .audio_o(audio),
		.clk_6mhz_o()
		 );
*/
`ifdef SDL_DISPLAY
   import "DPI-C" function void dpi_vga_init(input integer h,
					     input integer v);

   import "DPI-C" function void dpi_vga_display(input integer vsync_,
						input integer hsync_,
    						input integer pixel_);

   initial
     begin
	dpi_vga_init(640, 480);
     end

   wire [31:0] pxd;
   wire [31:0] hs;
   wire [31:0] vs;

   wire [2:0]  vgaBlue;
   wire [2:0]  vgaGreen;
   wire [2:0]  vgaRed;

   assign vgaBlue  = rgb[8:6];
   assign vgaGreen = rgb[5:3];
   assign vgaRed   = rgb[2:0];

   //assign pxd = (hblank | vblank) ? 32'b0 : { 24'b0, vgaBlue, vgaGreen[2:1], vgaRed };
   //assign pxd = (hblank | vblank) ? 32'b0 : { vgaRed,5'b0,vgaGreen,5'b0,vgaBlue,5'b0,8'b11111111 };
   assign pxd = (hblank | vblank) ? 32'b0 : { 8'b11111111,vgaRed,5'b0,vgaGreen,5'b0,vgaBlue,5'b0 };
//ARGB8888

   assign vs = {31'b0, ~vsync};
   assign hs = {31'b0, ~hsync};
   
   always @(posedge clk)
     dpi_vga_display(vs, hs, pxd);
`endif
   
endmodule // ff_tb


