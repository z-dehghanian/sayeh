LIBRARY IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity bit16sub is
        port( 
    a, b: in  std_logic_vector(15 downto 0);
    cin: in std_logic;
    sub: out std_logic_vector(15 downto 0);
    borrowout: out std_logic
    
      );
end entity;

architecture sub of bit16sub is

component bit16adder is 
generic(N: integer := 16);

port(
        A,B: in std_logic_vector(N-1 downto 0);
        Cin : in std_logic;
        S : out std_logic_vector(N-1 downto 0);
        cout : out std_logic
        );
      end component;

  signal c0, c1: std_logic;
  signal ib: std_logic_vector(15 downto 0);
  signal ic: std_logic_vector(15 downto 0):= "0000000000000000";
  signal sum0, sum1: std_logic_vector(15 downto 0);
begin

  ib <= not(b); 
  ic(0)<= not(cin);
  s0: bit16adder port map(a, ib, '1', sum0, c0); -- two comp then add
  s1: bit16adder port map(sum0, ic, '1', sum1, c1);
 -- sum1 <= sum0 - cin;
  borrowout<= c0 xor c1;
  
  sub<= sum1;
end sub;