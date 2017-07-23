
library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_arith.all;
    use ieee.std_logic_unsigned.all;
    
    entity instructionregister is 
    port(
      --load : in std_logic ;
      clk : in std_logic ;
      a : in std_logic_vector(15 downto 0);
      b : out std_logic_vector(15 downto 0 );
      r : out std_logic_vector(7 downto 0 ) 
    
    );
    end entity ;
    
    architecture func of instructionregister is 
     begin
    process (clk )
      begin
    if( clk'event and clk ='1' ) then 
       b<= a ;
       r <= a(11 downto 8) & a(3 downto 0) ;
    end if ;
  end process ;
    
    
  end architecture ;
  
