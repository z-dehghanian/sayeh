
library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.STD_LOGIC_ARITH.ALL; 
use IEEE.STD_LOGIC_UNSIGNED.ALL; 

entity OR_16bit 
is Port ( i_a : in STD_LOGIC_VECTOR (15 downto 0);
 i_b : in STD_LOGIC_VECTOR (15 downto 0);
result : out STD_LOGIC_VECTOR (15 downto 0)); 
end OR_16bit; 

architecture Bhv_or_16bit of OR_16bit
is begin result(15 downto 0)<=i_a(15 downto 0) or i_b(15 downto 0); 

 end Bhv_or_16bit;