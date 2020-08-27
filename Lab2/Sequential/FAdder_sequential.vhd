library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity HA is

Port ( A,B : in  STD_LOGIC;
       S,C : out  STD_LOGIC);

end HA;


architecture dataflow of HA is

begin

S <= A XOR B;
C <= A AND B;


end dataflow;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity ORGATE is

     Port ( X,Y : in STD_LOGIC;

              Z : out STD_LOGIC);

end ORGATE;


architecture dataflow of ORGATE is

begin

Z <= X OR Y;

end dataflow;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dff is
port(data_in: in std_logic;
     clk: in std_logic;
     rst: in std_logic;
     data_out: out std_logic);
 end dff;
 
 architecture behav of dff is
 begin
    process(data_in, clk)
    begin
        if(clk'event and clk='1') then
            if(rst='1') then
                data_out <='0';
            elsif(rst='0') then
                data_out <= data_in;
            end if;
        end if;
    end process;
end behav;

LIBRARY IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FAdder_seq is
Port ( clk, rst: in STD_LOGIC;
       FA, FB, FC : in STD_LOGIC;
       FS, FCA : out STD_LOGIC);
end FAdder_seq;

architecture structural of FAdder_seq is

component HA is
Port ( A,B : in STD_LOGIC;
       S,C : out STD_LOGIC);
end component;


component ORGATE is
Port ( X,Y: in STD_LOGIC;
         Z: out STD_LOGIC);
end component;

component dff is
port(data_in, clk, rst: in std_logic;
     data_out: out std_logic);
end component;

SIGNAL A,B,C,S0,S1,S2:STD_LOGIC;
--SIGNAL clk: STD_LOGIC;

begin
    D1:dff PORT MAP(data_in=>FA,clk=>clk,rst=>rst,data_out=>A);
    D2:dff PORT MAP(data_in=>FB,clk=>clk,rst=>rst,data_out=>B);
    D3:dff PORT MAP(data_in=>FC,clk=>clk,rst=>rst,data_out=>C);
    
    U1:HA PORT MAP(A=>A,B=>B,S=>S0,C=>S1);
    U2:HA PORT MAP(A=>S0,B=>C,S=>FS,C=>S2);
    
    U3:ORGATE PORT MAP(X=>S2,Y=>S1,Z=>FCA);
    
end structural;

architecture behavioral of FAdder_seq is

signal result: STD_LOGIC_VECTOR(1 downto 0);

begin
    result <= ('0'&FA)+('0'&FB)+('0'&FC);
    process(clk)
    begin
    if(clk'event and clk='1') then
        if(rst='1') then 
            FS <= '0';
            FCA <= '0';
         elsif(rst='0') then
            FS <= result(0);
            FCA <= result(1);
         end if;
     end if;
    end process;
    
 end behavioral;
