LIBRARY IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BCD_FA is
Port (FA, FB: in STD_LOGIC_VECTOR(3 downto 0);
		FC: in STD_LOGIC;
		FS: out STD_LOGIC_VECTOR(3 downto 0);
		FCA: out STD_LOGIC);
end BCD_FA;

architecture structural of BCD_FA is

component OR_gate is
port(x,y,z: in std_logic;
		F: out std_logic);
end component;

component AND_gate is
port(x,y: in std_logic;
		F: out std_logic);
end component;

component FA4bit_comb is
Port (FA, FB: in STD_LOGIC_VECTOR(3 downto 0);
		FC: in STD_LOGIC;
		FS: out STD_LOGIC_VECTOR(3 downto 0);
		FCA: out STD_LOGIC);
end component;

signal Z1, Z2: std_logic_vector(3 downto 0);
signal K, CA, C: std_logic;
signal A1, A2: std_logic;

begin

	U1: FA4bit_comb port map(FA=>FA, FB=>FB, FC=>FC, FS=>Z1, FCA=>K);
	
	U2: AND_gate port map(x=>Z1(3), y=>Z1(2), F=>A1);
	U3: AND_gate port map(x=>Z1(3), y=>Z1(1), F=>A2);
	
	U4: OR_gate port map(x=>K, y=>A1, z=>A2, F=>CA);
	
	Z2(0)<='0';
	Z2(1)<=CA;
	Z2(2)<=CA;
	Z2(3)<='0';
	
	U5: FA4bit_comb port map(FA=>Z1, FB=>Z2, FC=>'0', FS=>FS, FCA=>C);
	
	FCA <= CA;

end structural;
	