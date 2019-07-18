library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
ENTITY addec_prom IS
PORT
(
	address         : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
	clock           : IN STD_LOGIC  := '1';
	q               : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
);
END addec_prom; 
ARCHITECTURE SYN OF addec_prom IS	
signal qq : STD_LOGIC_VECTOR (7 DOWNTO 0);
begin
q<=qq;
PROCESS (address)
begin
CASE address IS 
	when "00000" => qq <= "00010001"; -- 0x000
	when "00001" => qq <= "00010001"; -- 0x001
	when "00010" => qq <= "00000001"; -- 0x002
	when "00011" => qq <= "00000001"; -- 0x003
	when "00100" => qq <= "01000001"; -- 0x004
	when "00101" => qq <= "01000001"; -- 0x005
	when "00110" => qq <= "10000001"; -- 0x006
	when "00111" => qq <= "10000001"; -- 0x007
	when "01000" => qq <= "11000001"; -- 0x008
	when "01001" => qq <= "11000001"; -- 0x009
	when "01010" => qq <= "00100001"; -- 0x00a
	when "01011" => qq <= "00100001"; -- 0x00b
	when "01100" => qq <= "11100001"; -- 0x00c
	when "01101" => qq <= "11100001"; -- 0x00d
	when "01110" => qq <= "11100001"; -- 0x00e
	when "01111" => qq <= "11100001"; -- 0x00f
	when "10000" => qq <= "11100000"; -- 0x010
	when "10001" => qq <= "11100000"; -- 0x011
	when "10010" => qq <= "11101000"; -- 0x012
	when "10011" => qq <= "11101000"; -- 0x013
	when "10100" => qq <= "11100100"; -- 0x014
	when "10101" => qq <= "11100100"; -- 0x015
	when "10110" => qq <= "11101100"; -- 0x016
	when "10111" => qq <= "11101100"; -- 0x017
	when "11000" => qq <= "11100010"; -- 0x018
	when "11001" => qq <= "11100010"; -- 0x019
	when "11010" => qq <= "11101010"; -- 0x01a
	when "11011" => qq <= "11101010"; -- 0x01b
	when "11100" => qq <= "11100110"; -- 0x01c
	when "11101" => qq <= "11100110"; -- 0x01d
	when "11110" => qq <= "11101110"; -- 0x01e
	when "11111" => qq <= "11101110"; -- 0x01f
	when others => qq <= "00000000";
END CASE; 
END PROCESS; 
END SYN; 
