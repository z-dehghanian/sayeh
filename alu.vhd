
library IEEE;
use IEEE.std_logic_1164.all;

entity alu is
	port ( 
	  A,B : in std_logic_vector(15 downto 0);
	  seed : in std_logic_vector(5 downto 0);
	  cin,B15to0, AandB, AorB, notB, shlB, shrB, AaddB, AsubB,ArandB,AdivB, AmulB, AcmpB : in std_logic; 
	  result : out std_logic_vector(15 downto 0);
	  cout, zout : out std_logic;
	  clk,zin: in std_logic
	  
	);
end entity;

architecture behavior of alu is
component AND_16bit is Port 
    ( i_a : in STD_LOGIC_VECTOR (15 downto 0); 
    i_b : in STD_LOGIC_VECTOR (15 downto 0); 
    result : out STD_LOGIC_VECTOR (15 downto 0)); 
    end component;

component bit16sub is  port( 
    a, b: in  std_logic_vector(15 downto 0);
    cin: in std_logic;
    sub: out std_logic_vector(15 downto 0);
    borrowout: out std_logic
    
      );
end component;


component XOR_16bit 
  is Port ( i_a : in STD_LOGIC_VECTOR (15 downto 0);
  i_b : in STD_LOGIC_VECTOR (15 downto 0);
  result : out STD_LOGIC_VECTOR (15 downto 0)); 
end component; 

component OR_16bit 
  is Port ( i_a : in STD_LOGIC_VECTOR (15 downto 0);
  i_b : in STD_LOGIC_VECTOR (15 downto 0);
  result : out STD_LOGIC_VECTOR (15 downto 0)); 
end component; 

component twoc is port(
        A: in std_logic_vector(15 downto 0);
        c : out std_logic_vector(15 downto 0)
        );
end component;

component R_Shift_16bit is Port(
 i_a : in STD_LOGIC_VECTOR (15 downto 0); 
 result : out STD_LOGIC_VECTOR (15 downto 0)); 
 end component; 

component l_Shift_16bit is Port 
( i_a : in STD_LOGIC_VECTOR (15 downto 0); 
 result : out STD_LOGIC_VECTOR (15 downto 0)); 
 end component; 
 
COMPONENT bit16cmp is 
port(
       A,B: in std_logic_vector(15 downto 0);
       result : out std_logic_vector(15 downto 0));
       end component;

 
component bit16adder is 
generic(N: integer := 16);
port(
        A,B: in std_logic_vector(N-1 downto 0);
        Cin : in std_logic;
        S : out std_logic_vector(N-1 downto 0);
        cout : out std_logic
        );
end component;

component not1 
is Port ( i_a : in STD_LOGIC_VECTOR (15 downto 0);
result : out STD_LOGIC_VECTOR (15 downto 0)); 
end component; 

component multiply8bit is
port( a,b: in std_logic_vector(7 downto 0);
    p: out std_logic_vector(15 downto 0)
    );
end component;

component div is
    port(
        operanda:     in std_logic_vector(15 downto 0);
        operandb:     in std_logic_vector(15 downto 0);
        errorsig:     out std_logic := '0';
        result_low:   out std_logic_vector(15 downto 0);
        result_high:  out std_logic_vector(15 downto 0)
    );
end component;

component rand is 
  port(
    seed : in std_logic_vector(5 downto 0 ) ; 
    output : out std_logic_vector(15 downto 0 ) 
  );
end component ;


signal res1,res2,res3,res4,res5,res6,res7,res8,res9,res10,res11,res12 :std_logic_vector(15 downto 0);


signal cout1,cout2,cout3,cout4,e : std_logic ;

begin
  --zout <= z;
  --cout <= c;
          m1 : AND_16bit port map (A,B,res1);
          m2 : OR_16bit port map (A,B,res2);
          m3 : not1 port map (A,res3); 
          m4 : l_Shift_16bit port map (A,res4);
          m5 : bit16adder port map (A,B,cin,res5,cout1);
          m6 : bit16sub port map (A,B,cin,res6,cout2);
          m7 : multiply8bit port map (A(7 downto 0),B(7 downto 0),res7);
          m8 : bit16cmp port map (A,B,res8);
          m9 : r_Shift_16bit port map (A,res9);
          m10 : rand port map (seed,res10);
          m11 : div port map (A,B,e,res12,res11);
          
            
  process (res1,res2,res3,res4,res5,res6,res7,res8,res9,res10,cin,B15to0, AandB, AorB, notB, shlB, shrB, AaddB, AsubB, AmulB, AcmpB,a,b) 
    begin
     -- if clk = '1' and clk'event then
       if B15to0 = '1' then
        result <= B;
        if(B = "0000000000000000") then
        zout <= '1';
        else
          zout <= '0';
        end if;
        
        elsif AandB = '1' then
          result <= res1;
          if(res1 = "0000000000000000") then
          zout <= '1';
          else
          zout <= '0';
          end if;
        elsif AorB = '1' then
          result <= res2;
          if(res2 = "0000000000000000") then
          zout <= '1';
          else
          zout <= '0';
          end if;
        elsif notB = '1' then
        result <= res3;
        if(res3 = "0000000000000000") then
          zout <= '1';
          else
          zout <= '0';
        end if;
        
        elsif shlB = '1' then  
        result <= res4;
        if(res4 = "0000000000000000") then
          zout <= '1';
          else
          zout <= '0';
          end if;
        
        elsif AaddB = '1' then
        result <= res5 ;
        cout <= cout1;
        if(res5 = "0000000000000000") then
          zout <= '1';
          else
          zout <= '0';
          end if;
        
        elsif AsubB = '1' then
        result <= res6 ;
        if(res6 = "0000000000000000") then
          zout <= '1';
          else
          zout <= '0';
          end if;
        
        elsif AmulB = '1' then
        result <=  res7 ;
        if(res7 = "0000000000000000") then
          zout <= '1';
          else
          zout <= '0';
          end if;
        
        elsif AcmpB = '1' then
        result <= res8 ;
        if(res8 = "0000000000000000") then
          zout <= '1';
          else
          zout <= '0';
          end if;
        
        elsif shrB = '1' then
        result <= res9 ;
        if(res9 = "0000000000000000") then
          zout <= '1';
          else
          zout <= '0';
          end if;
        
        elsif ArandB = '1' then
        result <= res10 ;
        if(res10 = "0000000000000000") then
          zout <= '1';
          else
          zout <= '0';
          end if;
          
        elsif AdivB = '1' then
        result <= res11 ;
        if(res11 = "0000000000000000") then
          zout <= '1';
          else
          zout <= '0';
          end if;  
          
      end if;
    --end if;
    --cout <= cout1;  
  end process;
end architecture;   
         
