
library ieee;
    use ieee.std_logic_1164.all;
    use IEEE.NUMERIC_STD.ALL;
    
    entity wp is 
    port(
      --load : in std_logic ;
      clk : in std_logic ;
      start : in std_logic_vector(5 downto 0);
      outwp : out std_logic_vector(5 downto 0 );
     -- im : in std_logic_vector(5 downto 0);
      rst,addwp : in std_logic 
    
    );
    end entity ;
    
    architecture func2 of wp is 
    signal m : std_logic_vector(5 downto 0);
    
    begin
    m <= "000000";
      --outwp <= m;  
    process (clk,addwp,rst )
    
      begin
    if(rst = '1') then
       outwp <= "000000";
    end if;       
    if( clk'event and clk ='1' ) then 
       --m <= std_logic_vector(unsigned(m) + unsigned(im));    
    if(addwp = '1') then
      outwp <= std_logic_vector(unsigned(m) + unsigned(start));
    end if;    
       --outwp<= start ;
    end if;
  end process ;
    
    
  end architecture ;
  


