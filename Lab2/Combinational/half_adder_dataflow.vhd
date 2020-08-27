library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity HA is
port (
A,B: in std_logic;
S,C: out std_logic);
end HA;

architecture dataflow of HA is
begin
S<=A xor B;
C<=A and B;
end dataflow;
