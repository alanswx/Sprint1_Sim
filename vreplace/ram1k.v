//-----------------------------------------------------
// Design Name : ram_dp_sr_sw
// File Name   : ram_dp_sr_sw.v
// Function    : Synchronous read write RAM
// Coder       : Deepak Kumar Tala
//-----------------------------------------------------
module ram1k(
                address_a               : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
                address_b               : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
                --clock         : IN STD_LOGIC  := '1';
                clock           : IN STD_LOGIC  ;
                data_a          : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                data_b          : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                --wren_a                : IN STD_LOGIC  := '0';
                --wren_b                : IN STD_LOGIC  := '0';
                wren_a          : IN STD_LOGIC  ;
                wren_b          : IN STD_LOGIC  ;
                q_a             : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
                q_b             : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
clock       , // Clock Input
address_a , // address_a Input
data_a    , // data_a bi-directional
wren_a      , // Write Enable/Read Enable
q_a,
address_b , // address_b Input
data_b    , // data_b bi-directional
wren_b      , // Write Enable/Read Enable
q_b
); 

parameter data_a_WIDTH = 8 ;
parameter ADDR_WIDTH = 9 ;
parameter RAM_DEPTH = 1 << ADDR_WIDTH;

//--------------Input Ports----------------------- 
input [ADDR_WIDTH-1:0] address_a ;
input wren_a ;
input [ADDR_WIDTH-1:0] address_b ;
input wren_b ;

//--------------Inout Ports----------------------- 
input [data_a_WIDTH-1:0] data_a ; 
input [data_a_WIDTH-1:0] data_b ;

output [data_a_WIDTH-1:0] q_a; 
output [data_a_WIDTH-1:0] q_b;

//--------------Internal variables---------------- 
reg [data_a_WIDTH-1:0] data_a_out ; 
reg [data_a_WIDTH-1:0] data_b_out ;
reg [data_a_WIDTH-1:0] mem [0:RAM_DEPTH-1];

//--------------Code Starts Here------------------ 
// Memory Write Block 
// Write Operation : When wren_a = 1
always @ (posedge clock)
begin : MEM_WRITE
  if ( wren_a ) begin
     mem[address_a] <= data_a;
  end else if (wren_b) begin 
     mem[address_b] <= data_b;
  end
    q_a <= mem[address_a]; 
    q_b <= mem[address_b]; 
end

endmodule // End of Module ram_dp_sr_sw
