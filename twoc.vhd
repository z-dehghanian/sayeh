
library IEEE;
use IEEE.std_logic_1164.all;
   


entity twoc is port(
        A: in std_logic_vector(15 downto 0);
        c : out std_logic_vector(15 downto 0)
        );
      end entity;
      
      architecture RTL of twoc is
      component bit16adder is 
generic(N: integer := 16);

port(
        A,B: in std_logic_vector(N-1 downto 0);
        Cin : in std_logic;
        S : out std_logic_vector(N-1 downto 0);
        cout : out std_logic
        );
      end component;
  signal b : std_logic_vector(15 downto 0);
  signal cc : std_logic;
      begin
      process (A)
        begin
	       for I in 0 to 15 loop
		      b(I) <= NOT A(I);
	end loop;
end process;
m : bit16adder port map (b , "0000000000000001",'0',c,cc); 
end RTL;
      

