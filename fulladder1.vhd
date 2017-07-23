

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Full_Adder is
port( A,B,Carry_in: in std_logic;
    Sum,Carry_out: out std_logic);
end Full_Adder;

architecture Behavioral of Full_Adder is

begin

process(A,B,Carry_in)
begin
  
  if (A = '0') and (B = '0') and (Carry_in = '0') then
    Sum <= '0';
    Carry_out <= '0';
    
  elsif (A = '0') and (B = '0') and (Carry_in = '1') then
    Sum <= '1';
    Carry_out <= '0';
    
  elsif (A = '0') and (B = '1') and (Carry_in = '0') then
    Sum <= '1';
    Carry_out <= '0';
    
  elsif (A = '0') and (B = '1') and (Carry_in = '1') then
    Sum <= '0';
    Carry_out <= '1';
    
  elsif (A = '1') and (B = '0') and (Carry_in = '0') then
    Sum <= '1';
    Carry_out <= '0';
    
  elsif (A = '1') and (B = '0') and (Carry_in = '1') then
    Sum <= '0';
    Carry_out <= '1';
    
  elsif (A = '1') and (B = '1') and (Carry_in = '0') then
    Sum <= '0';
    Carry_out <= '1';
    
  elsif (A = '1') and (B = '1') and (Carry_in = '1') then
    Sum <= '1';
    Carry_out <= '1';
    
end if;

end process;

end Behavioral;