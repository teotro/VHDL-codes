library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity BCD_FA_tb is
end BCD_FA_tb;

architecture behavioral of BCD_FA_tb is

component BCD_FA is
port (FA, FB: in std_logic_vector(3 downto 0);
	FC: in std_logic;
	FS: out std_logic_vector(3 downto 0);
	FCA: out std_logic);
end component;

signal FA, FB: std_logic_vector(3 downto 0);
signal FC: std_logic:='0';
signal FS: std_logic_vector(3 downto 0);
signal FCA: std_logic;

begin
    uut: BCD_FA port map(FA=>FA, FB=>FB, FC=>FC,
                                FS=>FS, FCA=>FCA);

	FA <= "0010", "1010" after 30 ns, "0100" after 40 ns, "0010" after 138 ns, "1100" after 160 ns;
	FB <= "1101", "0011" after 30 ns, "0111" after 40 ns, "0001" after 138 ns, "0110" after 160 ns;
	
end behavioral;