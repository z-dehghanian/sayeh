
library IEEE;
use IEEE.std_logic_1164.all;
   


entity fulladder is port(
        A,B,Cin: in std_logic;
        S,Cout : out std_logic
        );
      end entity;
      
      architecture RTL of fulladder is
      begin
      S <= A xor B xor Cin;
      Cout <= (A and B) or (A and Cin) or (B AND Cin);
      end RTL;
      


