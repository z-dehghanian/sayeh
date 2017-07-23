library IEEE;
use IEEE.std_logic_1164.all;

entity bit16mult1 is 
end entity;

architecture sub of bit16mult1 is
component bit16mult is 
port(
        A,B: in std_logic_vector(7 downto 0);
        result : out std_logic_vector(15 downto 0)
        --cout : out std_logic
        );
      end component;
 
  signal a,b : std_logic_vector (7 downto 0);

  signal result : std_logic_vector(15 downto 0);
  
  begin
  a <= "01010100";
  b <= "00001000";
  f:  bit16mult port map(a,b,result);
end sub;
