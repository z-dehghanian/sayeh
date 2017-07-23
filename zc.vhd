
library ieee;
    use ieee.std_logic_1164.all;
    use IEEE.NUMERIC_STD.ALL;
    
    entity cz is 
    port(
      cin,zin,cset,zset,creset,zreset,load : in std_logic ;
      clk : in std_logic ;
      cout,zout : out std_logic
     
    );
    end entity ;
    
    architecture func2 of cz is 
    signal m : std_logic_vector(5 downto 0);
    
    begin
    process (clk)
    
    begin
    if( clk'event and clk ='1' ) then 

      if(cset = '1') then
       cout <= '1';
      elsif(zset = '1') then
       zout <= '1';
      elsif(creset = '1') then
       cout <= '0';
      elsif(zreset = '1') then
       zout <= '0';
      elsif load = '1' then
       zout <= zin;
       cout <= cin;
    end if;       
  end if;    

  end process ;
    
    
  end architecture ;
  



