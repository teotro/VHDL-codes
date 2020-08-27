library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity BCD_4bit_tb is
end BCD_4bit_tb;

architecture behavioral of BCD_4bit_tb is

component BCD_4bit is
port (FA, FB: in std_logic_vector(15 downto 0);
	FC: in std_logic;
	FS: out std_logic_vector(15 downto 0);
	FCA: out std_logic);
end component;

signal FA, FB: std_logic_vector(15 downto 0);
signal FC: std_logic:='0';
signal FS: std_logic_vector(15 downto 0);
signal FCA: std_logic;

begin
    uut: BCD_4bit port map(FA=>FA, FB=>FB, FC=>FC,
                                FS=>FS, FCA=>FCA);

	FA <= B"0010_0110_0010_0101"; -- "1010" after 30 ns, "0100" after 40 ns, "0010" after 138 ns, "1100" after 160 ns;
	FB <= B"1001_0111_0101_1000"; -- "0011" after 30 ns, "0111" after 40 ns, "0001" after 138 ns, "0110" after 160 ns;
	
end behavioral;