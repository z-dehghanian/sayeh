library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rand is 
  port(
    seed : in std_logic_vector(5 downto 0 ) ; 
    output : out std_logic_vector(15 downto 0 ) 
  );
end entity ;


architecture func of rand is
  
  signal a : std_logic_vector(9 downto 0 ):="1110010101" ;
  signal c : std_logic_vector (3 downto 0 ) := "1011";
  signal ans : std_logic_vector(15 downto 0);
begin 
 
  ans <= std_logic_vector ( unsigned(unsigned(a)*unsigned(seed))+ unsigned(c));
-- seed <= ans( 5 downto 0 );
  output <= ans ;
  
end architecture ;
