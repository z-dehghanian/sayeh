
library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.STD_LOGIC_ARITH.ALL; 
use IEEE.STD_LOGIC_UNSIGNED.ALL; 
entity R_Shift_16bit is Port 
( i_a : in STD_LOGIC_VECTOR (15 downto 0); 
--c_in : in STD_LOGIC;
 result : out STD_LOGIC_VECTOR (15 downto 0)); 
 end R_Shift_16bit; 
 architecture bhv_rshift_16 of R_Shift_16bit 
 is begin 
 result(14 downto 0)<= i_a(15 downto 1);
 
result(15)<=i_a(0); 
end bhv_rshift_16;