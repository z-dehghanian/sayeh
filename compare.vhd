
library IEEE;
use IEEE.std_logic_1164.all;
   
entity bit16cmp is 
port(
       A,B: in std_logic_vector(15 downto 0);
       result : out std_logic_vector(15 downto 0));
       end entity;
      
architecture RTL of bit16cmp is
     begin
       process(A,B)
     begin
       
       if A > B then
        result <= "0000000000000100";
     elsif A = B then
      result <= "0000000000000010"; 
   elsif A < B then
     result <= "0000000000000001";
   end if;
   end process;
end RTL;
      






