LIBRARY IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mul_cell is
Port (    clk, rst: in STD_LOGIC;
          ai, bi: in STD_LOGIC;
		  ci: in STD_LOGIC;
		  si: in STD_LOGIC;
		  so: out STD_LOGIC;
	      co: out STD_LOGIC;
		  ao: out STD_LOGIC;
		  bo: out STD_LOGIC);
end mul_cell;

architecture structural of mul_cell is

component FAdder_seq is
Port ( clk, rst: in STD_LOGIC;
       FA, FB, FC : in STD_LOGIC;
       FS, FCA : out STD_LOGIC);
end component;

SIGNAL reg1A,reg2A,regB,regSout,regCout:STD_LOGIC;
SIGNAL Z: STD_LOGIC;
begin
    Z<= ai AND bi;
	
	D1:FAdder_seq PORT MAP(clk=>clk,rst=>rst,FC=>ci,FA=>si,FB=>Z,FS=>so,FCA=>co);
	
	stall: process(clk)
	begin
		if(clk'event and clk='1') then
		reg1A <= ai;
		reg2A <= reg1A;
		ao <= reg2A;
		
		regB <= bi;
		bo <= regB;
		end if;
	end process;
	--reg1A<=Aj;
	--reg2A<=reg1A;
	--Ao<=reg2A;
	--regB<=Bi;
	--Bo<=regB;
	--Sout<=regSout;
	--Cout<=regCout;
	
end structural;
	
	
	
