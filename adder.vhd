

library IEEE;
use IEEE.std_logic_1164.all;
   



entity bit16adder is 
generic(N: integer := 16);

port(
        A,B: in std_logic_vector(N-1 downto 0);
        Cin : in std_logic;
        S : out std_logic_vector(N-1 downto 0);
        cout : out std_logic
        );
      end entity;
      
      architecture RTL of bit16adder is
        component fulladder is port(
        A,B,Cin: in std_logic;
        S,Cout : out std_logic
        );
      end component;
      signal car: std_logic_vector(N downto 0);
      begin
        car(0)<=Cin;
      m1 : for i in 0 to N-1 generate
        m2 : fulladder port map(A => A(i),B => B(i),cin => Car(i) ,S=>S(i),Cout=>car(i + 1) );
        
        
    end generate;
    
Cout <= car(n); 
end RTL;
      



