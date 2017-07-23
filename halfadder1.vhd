library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Half_Adder is
  port( A,B: in std_logic;
      Sum,Carry: out std_logic);

end Half_Adder;

architecture Behavioral of Half_Adder is

begin

process(A,B)
begin
  
  if (A = '0') and (B = '0') then
    Sum <= '0';
    Carry <= '0';
    
  elsif (A = '0') and (B = '1') then
    Sum <= '1';
    Carry <= '0';
    
  elsif (A = '1') and (B = '0') then
    Sum <= '1';
    Carry <= '0';
    
  elsif (A = '1') and (B = '1') then
    Sum <= '0';
    Carry <= '1';
    
end if;

end process; 

end Behavioral;

