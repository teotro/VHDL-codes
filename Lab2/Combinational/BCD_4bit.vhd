library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity BCD_4bit is
Port (FA, FB: in STD_LOGIC_VECTOR(15 downto 0);
		FC: in STD_LOGIC;
		FS: out STD_LOGIC_VECTOR(15 downto 0);
		FCA: out STD_LOGIC);
end BCD_4bit;

architecture structural of BCD_4bit is

component BCD_FA is
port (FA, FB: in STD_LOGIC_VECTOR(3 downto 0);
		FC: in STD_LOGIC;
		FS: out STD_LOGIC_VECTOR(3 downto 0);
		FCA: out STD_LOGIC);
end component;

signal C1, C2, C3: std_logic;

begin

	U1: BCD_FA port map(FA=>FA(3 downto 0), FB=>FB(3 downto 0), FC=>FC, FS=>FS(3 downto 0), FCA=>C1);
	U2: BCD_FA port map(FA=>FA(7 downto 4), FB=>FB(7 downto 4), FC=>C1, FS=>FS(7 downto 4), FCA=>C2);
	U3: BCD_FA port map(FA=>FA(11 downto 8), FB=>FB(11 downto 8), FC=>C2, FS=>FS(11 downto 8), FCA=>C3);
	U4: BCD_FA port map(FA=>FA(15 downto 12), FB=>FB(15 downto 12), FC=>C3, FS=>FS(15 downto 12), FCA=>FCA);
	
end structural;