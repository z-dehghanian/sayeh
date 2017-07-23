   
library IEEE  ;
use IEEE.std_logic_1164.all ;
use IEEE.NUMERIC_STD.ALL;


entity RegisterFile is
  port (
  inputz :in std_logic_vector(15 downto 0);
  clk ,write, RFLwrite , RFHwrite : in std_logic ;
  adress : in std_logic_vector(3 downto 0 );
  r0 : in std_logic_vector(5 downto 0);
  rs, rd : out std_logic_vector(15 downto 0)
  
);
end entity ;

architecture func of RegisterFile is
   type memory is array (63 downto 0 )of std_logic_vector(15 downto 0);
   signal reset,t1 : std_logic ;
   signal firstadress,secondadress : std_logic_vector(5 downto 0);
   signal thismemory :memory ;
   signal ans : std_logic_vector( 15 downto 0 );
   signal m,z,o : std_logic_vector(5 downto 0);
   begin 
     m <= "0000" & adress(3 downto 2);
     z <= "0000" & adress(1 downto 0);
     o <= "000000";
     --Sub <=  std_logic_vector(unsigned(A) - unsigned(B) - unsigned(m));
     firstadress <= std_logic_vector(unsigned(m) + unsigned(r0));
     secondadress <= std_logic_vector(unsigned(z) + unsigned(r0));
    -- thismemory(to_integer(unsigned(o)))(15 downto 0) <= "0000000001101011";
      
      process(clk)
        begin 
          
          
          if write ='1' then 
            thismemory(to_integer(unsigned(firstadress)))(15 downto 0) <=inputz(15 downto 0);
          elsif RFHwrite ='1' then
            thismemory(to_integer(unsigned(firstadress)))(15 downto 8) <=inputz(15 downto 8);
          elsif RFLwrite ='1' then
            thismemory(to_integer(unsigned(firstadress)))(7 downto 0) <=inputz(7 downto 0);
          end if;
          
          if  RFLwrite ='0' and RFHwrite ='0' and write ='0' then
            rd <=  thismemory(to_integer(unsigned(firstadress)));
            rs <=  thismemory(to_integer(unsigned(secondadress)));
          end if ;
        end process ;
    end architecture;
    

