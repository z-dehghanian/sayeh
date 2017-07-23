


library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.STD_LOGIC_ARITH.ALL; 
use IEEE.STD_LOGIC_UNSIGNED.ALL; 

entity not1 
is Port ( i_a : in STD_LOGIC_VECTOR (15 downto 0);
result : out STD_LOGIC_VECTOR (15 downto 0)); 
end not1; 

architecture BhvNot of not1
is begin 
result(15 downto 0)<= not i_a(15 downto 0) ; 

 end BhvNot;

