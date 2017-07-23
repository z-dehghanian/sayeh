

library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_arith.all;
    use ieee.std_logic_unsigned.all;
    
    entity datapath is 
    port(
     instruct: in std_logic_vector(15 downto 0);
     clk , write: in std_logic;
     zst,zrst,cst,crst,cwp,move,andsd,orsd,notsd,add,sub,shl,shr,cmp,mil,mih,spc,jpa,jpr,brz,brc,awp,en,ResetPC, PCplusI, PCplus1, RplusI, Rplus0,irordata,rwp,writeRFH,writeRFL,sh,lda,mve,rand,div,mul : in std_logic;
     irout,addbus,rs : out std_logic_vector(15 downto 0);
     inputreg : in std_logic_vector(15 downto 0)   
    );
    end entity ;
    
  architecture dp of datapath is 
  
  
  component alu is
	port ( 
	  A,B : in std_logic_vector(15 downto 0);
	  seed : in std_logic_vector(5 downto 0);
	  cin,B15to0, AandB, AorB, notB, shlB, shrB, AaddB, AsubB,ArandB,AdivB,AmulB, AcmpB : in std_logic; 
	  result : out std_logic_vector(15 downto 0);
	  cout, zout : out std_logic;
	  clk,zin: in std_logic
	);
  end component;

  component RegisterFile is
  port (
  inputz :in std_logic_vector(15 downto 0);
  clk ,write ,RFLwrite , RFHwrite : in std_logic ;
  adress : in std_logic_vector(3 downto 0 );
  r0 : in std_logic_vector(5 downto 0);
  rs, rd : out std_logic_vector(15 downto 0)
  
);
end component ;

component instructionregister is 
    port(
      --load : in std_logic ;
      clk : in std_logic ;
      a : in std_logic_vector(15 downto 0);
      b : out std_logic_vector(15 downto 0 );
      r : out std_logic_vector(7 downto 0 ) 
    
    );
    end component ;
    
    component cz is 
    port(
      cin,zin,cset,zset,creset,zreset,load : in std_logic ;
      clk : in std_logic ;
      cout,zout : out std_logic
     
    );
    end component ;
    
    
  
    component wp is 
    port(
      --load : in std_logic ;
      clk : in std_logic ;
      start : in std_logic_vector(5 downto 0);
      outwp : out std_logic_vector(5 downto 0 );
      rst,addwp : in std_logic 
    
    );
    end component;
    
    component ProgramCounter IS
    PORT (
    EnablePC : IN std_logic;
    input: IN std_logic_vector (15 DOWNTO 0);
    clk : IN std_logic;
    output: OUT std_logic_vector (15 DOWNTO 0)
    );

 END component;
  
  component AddressLogic IS
  PORT (
  PCside, Rside : IN std_logic_vector (15 DOWNTO 0);
  Iside : IN std_logic_vector (7 DOWNTO 0);
  ALout : OUT std_logic_vector (15 DOWNTO 0);
  ResetPC, PCplusI, PCplus1, RplusI, Rplus0 : IN std_logic
  );
  END component;
    
  
  signal whichreg : std_logic_vector(3 downto 0);
  signal aluout ,rss,rdd,adout,pcout,rside,inputreg1,Imorrdd,adrside: std_logic_vector(15 downto 0);
  signal alucout,aluzout,mm,z,zout,cout,load: std_logic;
  signal wpr0,imwp : std_logic_vector(5 downto 0);
  signal iside,m,whichreg1 : std_logic_vector(7 downto 0);
  begin
  m <= "00000000";
  mm <= move or mil or mih;
  z <= rwp or cwp;
  --load <= not crst and not cst and not zst and not zrst; 
  --zout & cout ro che konim?  
    
  IReg : instructionregister port map (clk,instruct,irout,whichreg1);
  --wpr0 as seed to alu for random
  ALU1 : alu port map (rss,imorrdd,wpr0,cout,mm,andsd,orsd,notsd,shl,shr,add,sub,rand,div,mul,cmp,aluout,alucout,aluzout,clk,zout);  
     
  regfile : registerfile port map (inputreg1,clk,write,writeRFL,writeRFH,whichreg,wpr0,rss,rdd);
  
  windowspointer : wp port map (clk,imwp,wpr0,z,awp);
  
  pc : programcounter port map (en,adout,clk,pcout);
   
  zc : cz port map (alucout,aluzout,cst,zst,crst,zrst,load,clk,cout,zout);
  
  ad :AddressLogic port map (pcout,adrside,iside,adout,ResetPC, PCplusI, PCplus1, RplusI, Rplus0);
  
  addbus <= adout;
  
  process(clk)
    begin
    if lda = '1' then
      adrside <=  rss;
    elsif mve = '1' then
      adrside <=  rdd;
      rs <= rss;  
    end if;
  end process;
  process(clk)
    begin
    if sh = '1' then
      whichreg <=  whichreg1(7 downto 4);
    else  
      whichreg <=  whichreg1(3 downto 0);
    end if;
  end process;
  
  
  process(clk,mil,mih)
    begin
    if mil = '1' then
      imorrdd <=  m & instruct(7 downto 0);
    elsif mih = '1' then
      imorrdd <=  instruct(7 downto 0) & m;
    else  
      imorrdd <= rdd;
    end if;
  end process;
  
  process(clk)
    begin
    if andsd = '1' or orsd = '1' or notsd = '1' or shl = '1' or shr = '1' or add ='1' or sub ='1'or cmp = '1' or mm = '1' or mul = '1' or div = '1' or rand = '1' then
      load <= '1';
  else
    load <= '0';   
    end if;
  end process;
  
  process(clk,jpa,jpr,cout,zout,brz,brc,spc)
    begin
    if jpa = '1' or jpr = '1' or spc ='1' then
      iside <=  instruct(7 downto 0);
  elsif brz = '1' and zout = '1' then
     iside <=  instruct(7 downto 0);
  elsif brc = '1' and cout = '1' then
     iside <=  instruct(7 downto 0);
  else
    iside <= "00000001";   
    end if;
  end process;
  
  process(clk,awp)
    begin
    if awp = '1' then
      imwp <=  instruct(5 downto 0);
  
    end if;
  end process;
  
  process(pcout,inputreg,clk)
    begin
    if irordata = '1' and spc = '1' then
        inputreg1 <= pcout;
    elsif irordata = '1' and lda = '1' then
      inputreg1 <= inputreg;
    
    elsif andsd = '1' or orsd = '1' or notsd = '1' or shl = '1' or shr = '1' or add ='1' or sub ='1'or cmp = '1' or mm = '1' or mul = '1' or div = '1' or rand = '1' then   
      inputreg1 <= aluout;
    
    end if;
  end process;
  end architecture ;
  
