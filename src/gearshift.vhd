-- Gear Shift
-- (c) 2019 alanswx


library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
    use std.textio.all;
entity gearshift is 
port(   
			Clk				: in	std_logic;
			reset				: in	std_logic;
			gearup			: in	std_logic;
			geardown			: in	std_logic;
			gearout			: out std_logic_vector(2 downto 0) := "000";
			gear1				: out std_logic;
			gear2				: out std_logic;
			gear3				: out std_logic
			
			);
end gearshift;

architecture rtl of gearshift is

signal gear : std_logic_vector(2 downto 0):= (others =>'0');

begin

gearout<=gear;

process (gearup,geardown,reset)
variable l: line;
begin
  if (reset='1') then
		gear<="000";
  end if;
  if (gearup='1') then
	if (gear < 4) then
		gear<= gear +1;
	end if;
  elsif (geardown='1') then
	if (gear>0) then
		gear<=gear-1;
	end if;
end if;


   case gear is
        when "000" => gear1 <=  '0' ;
        when "001" => gear1 <=  '1' ;
        when "010" => gear1 <=  '1' ;
        when "011" => gear1 <=  '1' ;
        when others => gear1 <= '1' ;
    end case;
   case gear is
        when "000" => gear2 <=  '1' ;
        when "001" => gear2 <=  '0' ;
        when "010" => gear2 <=  '1' ;
        when "011" => gear2 <=  '1' ;
        when others => gear2 <= '1' ;
    end case;
   case gear is
        when "000" => gear3 <=  '1' ;
        when "001" => gear3 <=  '1' ;
        when "010" => gear3 <=  '0' ;
        when "011" => gear3 <=  '1' ;
        when others => gear3 <= '1' ;
    end case;
	
end process;

end rtl;
