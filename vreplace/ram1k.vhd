LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


ENTITY ram1k_dp IS
	PORT
	(
		address_a		: IN STD_LOGIC_VECTOR (9 DOWNTO 0);
		address_b		: IN STD_LOGIC_VECTOR (9 DOWNTO 0);
		--clock		: IN STD_LOGIC  := '1';
		clock		: IN STD_LOGIC  ;
		data_a		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		data_b		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		--wren_a		: IN STD_LOGIC  := '0';
		--wren_b		: IN STD_LOGIC  := '0';
		wren_a		: IN STD_LOGIC  ;
		wren_b		: IN STD_LOGIC  ;
		q_a		: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
		q_b		: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
	);
END ram1k_dp;

ARCHITECTURE SYN OF ram1k_dp IS
	-- Build a 2-D array type for the RAM


	subtype word_t is std_logic_vector(7 downto 0);
	type memory_t is array(1023 downto 0) of word_t;
	-- Declare the RAM
	shared variable ram : memory_t;
	-- Declare the RAM
	--type memory_t is array(1023 downto 0) of std_logic_vector(7 downto 0);
	--shared variable ram : memory_t;

begin

	-- Port A
	process(clock)
	begin
		if(rising_edge(clock)) then 
			if(wren_a = '1') then
				ram(conv_integer(address_a)) := data_a;
			end if;
			q_a <= ram(conv_integer(address_a));
		end if;
	end process;
	
	-- Port B
	process(clock)
	begin
		if(rising_edge(clock)) then
			if(wren_b = '1') then
				ram(conv_integer(address_b)) := data_b;
			end if;
			q_b <= ram(conv_integer(address_b));
		end if;
	end process;

END SYN;


	
