

library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.STD_LOGIC_ARITH.ALL; 
use IEEE.STD_LOGIC_UNSIGNED.ALL; 
entity l_Shift_16bit is Port 
( i_a : in STD_LOGIC_VECTOR (15 downto 0); 
--c_in : in STD_LOGIC;
 result : out STD_LOGIC_VECTOR (15 downto 0)); 
 end 
 l_Shift_16bit; 
 architecture bhv_lshift_16 of l_Shift_16bit 
 is begin 
 result(15 downto 1)<= i_a(14 downto 0);
 
--result(0)<=i_a(15); 
result(0)<='0'; 

end bhv_lshift_16;
