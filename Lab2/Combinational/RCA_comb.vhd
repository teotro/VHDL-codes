LIBRARY IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FA4bit_comb is
Port (FA, FB: in STD_LOGIC_VECTOR(3 downto 0);
		FC: in STD_LOGIC;
		FS: out STD_LOGIC_VECTOR(3 downto 0);
		FCA: out STD_LOGIC);
end FA4bit_comb;

architecture structural of FA4bit_comb is

component FAdder_comb is
Port(FA, FB, FC: in STD_LOGIC;
		FS, FCA: out STD_LOGIC);
end component;

signal C1, C2, C3: STD_LOGIC;

begin

	U1: FAdder_comb port map(FA=>FA(0), FB=>FB(0), FC=>FC, FS=>FS(0), FCA=>C1);
	U2: FAdder_comb port map(FA=>FA(1), FB=>FB(1), FC=>C1, FS=>FS(1), FCA=>C2);
	U3: FAdder_comb port map(FA=>FA(2), FB=>FB(2), FC=>C2, FS=>FS(2), FCA=>C3);
	U4: FAdder_comb port map(FA=>FA(3), FB=>FB(3), FC=>C3, FS=>FS(3), FCA=>FCA);
	
end structural;