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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FAdder is

Port ( FA, FB, FC : in STD_LOGIC;

          FS, FCA : out STD_LOGIC);

end FAdder;


architecture structural of FAdder is


component HA is

Port ( A,B : in STD_LOGIC;

       S,C : out STD_LOGIC);

end component;


component ORGATE is

Port ( X,Y: in STD_LOGIC;

         Z: out STD_LOGIC);

end component;


SIGNAL S0,S1,S2:STD_LOGIC;


begin


U1:HA PORT MAP(A=>FA,B=>FB,S=>S0,C=>S1);

U2:HA PORT MAP(A=>S0,B=>FC,S=>FS,C=>S2);

U3:ORGATE PORT MAP(X=>S2,Y=>S1,Z=>FCA);


end structural;