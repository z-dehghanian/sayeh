
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

ENTITY AddressLogic IS
 PORT (
 PCside, Rside : IN std_logic_vector (15 DOWNTO 0);
 Iside : IN std_logic_vector (7 DOWNTO 0);
 ALout : OUT std_logic_vector (15 DOWNTO 0);
 ResetPC, PCplusI, PCplus1, RplusI, Rplus0 : IN std_logic
 );
 END AddressLogic;

 ARCHITECTURE dataflow of AddressLogic IS
  signal alo :  std_logic_vector(15 downto 0);
  signal m :  std_logic_vector(15 downto 0);
  begin 
  m <= "0000000000000001";
  alout <= alo;
  
  process(resetpc,pcplusi,pcplus1,rplusi,rplus0)
    begin
    if resetpc = '1' then
    alo <= "0000000000000000";
    elsif pcplusi = '1' then
    alo <= std_logic_vector(unsigned(pcside) + unsigned(iside));
    elsif pcplus1 = '1' then
    alo <= std_logic_vector(unsigned(pcside) + unsigned(m));
    elsif rplusi = '1' then
    alo <= std_logic_vector(unsigned(rside) + unsigned(iside));
    elsif rplus0 = '1' then
    alo <= rside;
  end if;
end process;
end architecture;
      
     
   
