library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity MAC is
generic (
		width : integer :=8;
		tap: integer :=3          --for 8-tap FIR => 7 adds => 2^3 adds => +3 bits
	 );
port(	clk, rst: in std_logic;
		mac_init: in std_logic :='1';
		en: in std_logic;
		ram_out, rom_out: in std_logic_vector(width-1 downto 0);
		valid_out: out std_logic :='0';
		y: out std_logic_vector(width+width+tap-1 downto 0));
end MAC;

architecture behavioral of MAC is

signal a: std_logic_vector(width+width+tap-1 downto 0) := (others => '0');

begin

process(clk, rst)
begin

if (rst='1') then
	a <= (others => '0');
	--y <= (others => '0');
elsif(rst='0') then
	if(clk'event and clk='1') then
	   if(en='1') then
		    a <= a + ram_out*rom_out;
            if(mac_init='1') then
                --valid_out <= '1';
                --y <= a;
                a <= (others => '0');
           -- elsif(mac_init='0') then
               -- valid_out <= '0';
            end if;
       -- elsif(en='0') then
           -- valid_out <= '1';
            --y <= a;
        end if;
	end if;
end if;
--y <= a;
end process;
y <= a;
end behavioral;
