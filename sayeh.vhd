

library IEEE;
use IEEE.std_logic_1164.all;
   


entity sayeh is port(
       -- instruct: in std_logic_vector(7 downto 0);      
        clk : in std_logic
        --cout,zout,zst,zrst,cst,crst,cwp,move,andsd,orsd,notsd,add,sub,shl,shr,cmp,mil,mih,spc,jpa,jpr,brz,brc,awp: out std_logic;
		    --reg : out std_logic_vector(3 downto 0)
        
        );
      end entity;
      
      architecture RTL of sayeh is
      
  component controller is
	 port ( cout,zout,zst,zrst,cst,crst,cwp,move,andsd,orsd,notsd,add,sub,shl,shr,cmp,mil,mih,spc,jpa,jpr,brz,brc,awp,writeregf,readmem,writemem,en,ResetPC, PCplusI, PCplus1, RplusI, Rplus0 ,irordata1,rwp,writeRFH,writeRFL,sh1,lda,mve,rand,div,mul: out std_logic;
		clk, rst , coutin,zoutin : in std_logic;
		instruct1 : in std_logic_vector(15 downto 0));
  end component;
  
  component datapath is 
    port(
     instruct: in std_logic_vector(15 downto 0);
     clk , write: in std_logic;
     zst,zrst,cst,crst,cwp,move,andsd,orsd,notsd,add,sub,shl,shr,cmp,mil,mih,spc,jpa,jpr,brz,brc,awp,en,ResetPC, PCplusI, PCplus1, RplusI, Rplus0 ,irordata,rwp,writeRFH,writeRFL,sh,lda,mve,rand,div,mul: in std_logic;
 --  reg : out std_logic_vector(3 downto 0)
     irout,addbus,rs : out std_logic_vector(15 downto 0);
     inputreg : in std_logic_vector(15 downto 0)      
    );
    end component ;
    
  component memory is
	generic (blocksize : integer := 1024);

	port (clk, readmem, writemem : in std_logic;
		addressbus: in std_logic_vector (15 downto 0);
		databus : out std_logic_vector (15 downto 0);
		databus1 : in std_logic_vector (15 downto 0);
		
		memdataready : out std_logic
		);
  end component;

    
    
 signal i,iir : std_logic_vector(15 downto 0);
 signal xx,cout,zout,zst,zrst,cst,crst,cwp,move,andsd,orsd,notsd,add,sub,shl,shr,cmp,mil,mih,spc,jpa,jpr,brz,brc,awp,writeregf,readm,writem,en,ResetPC, PCplusI, PCplus1, RplusI, Rplus0,irordata1,rwp,writeRFH,writeRFL,sh,lda,mve,rand,div,mul: std_logic;
 signal addbus,databus,inputreg,rs,databus1 : std_logic_vector(15 downto 0);
begin
  
   m : controller port map (cout,zout,zst,zrst,cst,crst,cwp,move,andsd,orsd,notsd,add,sub,shl,shr,cmp,mil,mih,spc,jpa,jpr,brz,brc,awp,writeregf,readm,writem,en,ResetPC, PCplusI, PCplus1, RplusI, Rplus0
		,irordata1,rwp,writeRFH,writeRFL,sh,lda,mve,rand,div,mul,clk,'0','0','0',i);
   m1 : datapath port map (iir,clk,writeregf,zst,zrst,cst,crst,cwp,move,andsd,orsd,notsd,add,sub,shl,shr,cmp,mil,mih,spc,jpa,jpr,brz,brc,awp,en,ResetPC, PCplusI, PCplus1, RplusI, Rplus0,irordata1,rwp,writeRFH,writeRFL,sh,lda,mve,rand,div,mul
,i,addbus,rs,inputreg);
   z : memory port map(clk,readm,writem,addbus,databus,databus1,xx);

  process(clk)
    begin
    if irordata1 = '0' then
      iir <= databus;  
    elsif irordata1 = '1' and lda = '1' then
      inputreg <= databus;
    elsif irordata1 = '1' and mve = '1' then
      databus1 <= rs;
    
    end if;
  end process;  
  end RTL  ;   



