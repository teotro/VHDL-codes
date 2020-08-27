library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity controller is
generic(
        M: integer :=8;
        addr_width: integer :=3);
port(   clk, rst: in std_logic;
        valid_in: in std_logic;
        mac_init: out std_logic;
        we: out std_logic;
        en: out std_logic;
        rom_addres, ram_addres: out std_logic_vector(addr_width-1 downto 0);
        valid_out: out std_logic );
end controller;

architecture behavioral of controller is

signal counter: std_logic_vector(addr_width-1 downto 0) := (others => '0');
--signal mac: std_logic := '0';
signal temp: std_logic_vector(addr_width-1 downto 0);
--signal enable: std_logic :='0';
signal val_out: std_logic_vector(M-1 downto 0):= (others => '0');

constant all_zeros: std_logic_vector(addr_width-1 downto 0) := (others => '0');
constant all_ones: std_logic_vector(addr_width-1 downto 0) := (others => '1');

begin

process(clk, rst)
begin
	if(rst='1') then
		counter <= (others => '0');
		mac_init <= '0';
		en <= '0';
		valid_out <= '0';

	elsif(rst='0') then
		--en <= '1';
		if(clk'event and clk='1') then
        temp <= counter;
        for i in 1 to M-1 loop
            val_out(i) <= val_out(i-1);
        end loop;
        valid_out <= val_out(M-1);
			--if(counter=all_ones) then       --must produce valid output and initialize 
				--mac_init <= '1';
				--we <= '0';
				--counter <= counter + 1;
			if(counter=all_zeros) then
			     val_out(0) <= valid_in;
			     mac_init <= '1';
                 we <= '1';
                 --valid_out <= '1';
                 en <= valid_in;
			     if(valid_in='1') then	
				     --en <= '1';
				     counter <= counter + 1;
				 elsif(valid_in='0') then
				     --en <= '0';
				     
				     counter <= counter;
				end if;
			else
			     val_out(0) <= '0';
			     mac_init <= '0';
			     we <= '0';
			     counter <= counter + 1;
			     --valid_out <= '0';
			end if;

        --if(enable='1') then
        --    counter <= counter + 1;
        --end if;
        
		end if;
	end if;
			
end process;

--en <= enable;

ram_addres <= temp;
rom_addres <= temp;

end behavioral;
