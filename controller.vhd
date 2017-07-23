library IEEE;
use IEEE.std_logic_1164.all;



entity controller is
	port ( cout,zout,zst,zrst,cst,crst,cwp,move,andsd,orsd,notsd,add,sub,shl,shr,cmp,mil,mih,spc,jpa,jpr,brz,brc,awp,writeregf,readmem,writemem,en,ResetPC, PCplusI, PCplus1, RplusI, Rplus0,irordata1,rwp,writeRFH,writeRFL,sh1,lda,mve,rand,div,mul : out std_logic;
		clk, rst , coutin,zoutin : in std_logic;
		instruct1 : in std_logic_vector(15 downto 0));
end entity;


architecture rtl of controller is
	type state is (S0,s01,s02, S1,S11,S12,S13,s15, S2, S3, S4);
	signal current_state : state;
	signal next_state : state;
	signal instruct : std_logic_vector (7 downto 0);
	signal sh,im,read,irordata : std_logic;
	
begin
  readmem <= read;
  sh1 <= sh;
  --cwp <= rwp;
  irordata1 <= irordata;
  --irordata <= '0';
  --resetpc <= rpc;
	-- next to current
	process (clk, rst)
	begin
	  if rst = '0' then 
     resetpc <= '0' ;			
		 --irordata <= '0';
		 rwp <= '0';	
			end if ;
		if rst = '1' then
		  --readmem <= '1';
			rwp <= '1';
			resetpc <= '1';
			--irordata <= '0';
			current_state <= S0;
     
		elsif clk'event and clk = '1' then
	
		  zout <= zoutin;
			cout <= coutin;
			current_state <= next_state;
		end if;
	end process;

	-- next based on state
	process (current_state)
	begin
		case current_state is
			when S0 =>
			  --all controller signal have to be with 0 value
			   read <= '1';
			   sh <= '1';
				 writeregf <= '0';
			   writeRFH <= '0';
			   writeRFL <= '0';
			   writemem <= '0';
				 en <= '1';
				 next_state <= S02;
			  when s02 =>
			   --read <= '1';
			   
			   sh <= '1';
				 next_state <= S01;
				 irordata <= '0';
			      
			  when s01 =>
			  im <= '0';
			  read <= '0';
			  --irordata <= '0';
			  zst<='0';
			  zrst<='0';
			  cst<='0';
			  crst<='0';
			  cwp<='0';
			  move<='0';
			  andsd<='0';
			  orsd<='0';
			  notsd<='0';
			  add<='0';
			  sub<='0';
			  shl<='0';
			  shr<='0';
			  cmp<='0';
			  mil<='0';
			  mih<='0';
			  spc<='0';
			  jpa<='0';
			  jpr<='0';
			  brz<='0';
			  brc<='0';
			  awp<='0';
			  lda <= '0';
			  mve <= '0';
			  --ResetPC<='0';
			  PCplusI<='0';
			  PCplus1<='0';
			  RplusI<='0';
			  Rplus0<='0'; 
			  writeregf <= '0';
			  writeRFH <= '0';
			  writeRFL <= '0';
			  writemem <= '0';
			  div <= '0';
			  mul <= '0';
			  rand <= '0';
			  if sh = '1' then
			  instruct <= instruct1(15 downto 8);
			  else
			  instruct <= instruct1(7 downto 0);
			  end if;  
			 next_state <= S1;
			     
			    
			when S1 =>
			  if instruct = "00000000" then
				  next_state <= S4;
				  if sh = '0' then
				    pcplus1 <='1';
				  end if;  
				elsif instruct="00000001" then  
					next_state <= S3;
				else 
				  if instruct = "00000010" then
			     zst <= '1' ;
			     if sh = '0' then
				    pcplus1 <='1';
				   end if;
				    next_state <= S2;
			  elsif instruct = "00000011" then
			    zrst <= '1' ;
			    if sh = '0' then
				    pcplus1 <='1';
				  end if;
				  next_state <= S2;
			  elsif instruct = "00000100" then
			    cst <= '1' ;
			    if sh = '0' then
				    pcplus1 <='1';
				  end if;
			    next_state <= S2;
			  elsif instruct = "00000101" then
			    crst <= '1' ;
			    if sh = '0' then
				    pcplus1 <='1';
				  end if;
			    next_state <= S2;
			  elsif instruct = "00000110" then
			    cwp <= '1';
			    if sh = '0' then
				    pcplus1 <='1';
				  end if;
				  next_state <= S2;
			  elsif instruct(7 downto 4) = "0001" then
			    move <= '1';
			   if sh = '0' then
				    pcplus1 <='1';
				  end if;
			    next_state <= S2;
				elsif instruct(7 downto 4) = "0010" then
				  irordata <= '1';
				  read <= '1';
				  next_state <= s11; 
			    lda <= '1';
			    en <= '0';
				elsif instruct(7 downto 4) = "0011" then
			    irordata <= '1'; 
			   -- rplus0 <= '1';
				  next_state <= s11; 
			    writemem <= '1';
			    en <= '0';
			    mve <= '1';
			    -- devider
				elsif instruct(7 downto 4) = "0100" then
			  
			   div <= '1';
				  if sh = '0' then
				    pcplus1 <='1';
				  end if;
				  next_state <= S2;
				 -- random
				elsif instruct(7 downto 4) = "0101" then
			  
			   rand <= '1';
				  if sh = '0' then
				    pcplus1 <='1';
				  end if;
				  next_state <= S2;
				
				elsif instruct(7 downto 4) = "0110" then
				  andsd <= '1';
				  if sh = '0' then
				    pcplus1 <='1';
				  end if;
				  next_state <= S2;
				elsif instruct(7 downto 4) = "0111" then
				  orsd <= '1';
				  if sh = '0' then
				    pcplus1 <='1';
				  end if;
				  next_state <= S2;
				elsif instruct(7 downto 4) = "1000" then
				  notsd <= '1';
				  if sh = '0' then
				    pcplus1 <='1';
				  end if;
				  next_state <= S2;
				elsif instruct(7 downto 4) = "1001" then
				  shl <= '1';
				  if sh = '0' then
				    pcplus1 <='1';
				  end if;
				  next_state <= S2;
				elsif instruct(7 downto 4) = "1010" then
				  shr <= '1';
				  if sh = '0' then
				    pcplus1 <='1';
				  end if;
				  next_state <= S2;
				elsif instruct(7 downto 4) = "1011" then
				  add <= '1';
				  if sh = '0' then
				    pcplus1 <='1';
				  end if;
				  next_state <= S2;
				elsif instruct(7 downto 4) = "1100" then
				  sub <= '1';
				  if sh = '0' then
				    pcplus1 <='1';
				  end if;
				  next_state <= S2;
				elsif instruct(7 downto 4) = "1101" then
			    mul <= '1';
			   if sh = '0' then
				    pcplus1 <='1';
				  end if;
				  
				  next_state <= S2;
					elsif instruct(7 downto 4) = "1110" then
				  cmp <= '1';
				  if sh = '0' then
				    pcplus1 <='1';
				  end if;
				  next_state <= S2;
				  ----------------------------- with immediate
				elsif instruct(7 downto 4) = "1111" then
				  if instruct(1 downto 0) = "00" then
				    mil <= '1';
				    pcplus1 <='1';
				    im <= '1';
				    next_state <= S2;
				  elsif instruct(1 downto 0) = "01" then
				    mih <= '1';
				    pcplus1 <='1';
				    im <= '1';
				    next_state <= S2;
				  elsif instruct(1 downto 0) = "10" then
				    irordata <= '1';
				    spc <= '1';
				    --pcplus1 <='1';
				    im <= '1';
				    next_state <= S15;
	        elsif instruct(1 downto 0) = "11" then
				    jpa <= '1';
				    im <= '1';
				    next_state <= S15;
				  end if; 
				elsif instruct = "00000111" then
				  jpr <= '1'; 
				  im <= '1';
				  next_state <= S15;
				  --next_state <= S2;
				elsif instruct = "00001000" then
				  brz <= '1'; 
				  im <= '1';
				  next_state <= S15;
				elsif instruct = "00001001" then
				  brc <= '1'; 
				  im <= '1';
				  next_state <= S15;
				elsif instruct = "00001010" then
				  --awp <= '1'; 
				  im <= '1';
				  next_state <= S15;
				else
				  next_state <= S0;
				  pcplus1 <= '1';
				end if;
			  
			  end if ;
			  when s11 =>
			     rplus0 <= '1';
			     next_state <= S12;  
			  when s12 =>
			     rplus0 <= '0';
			     if sh = '0' then
			       pcplus1 <= '1';
			      -- en <= '1';
			     end if;  
			     next_state <= S13;  
			  when s13 =>
			     --rplus0 <= '0';
			     --pcplus1 <= '1';
			     next_state <= S2;  
			 when s15 =>
			     if instruct = "00000111" then
			       pcplusi <= '1';
			     elsif instruct = "00001010" then
			       awp <= '1';
			       --pcplusi <= '1';
			     elsif instruct = "00001000" then
				     --brz <= '1'; 
				     pcplusi <= '1';
				   elsif instruct = "00001001" then
				     --brc <= '1'; 
				     pcplusi <= '1';
				   elsif instruct(7 downto 4) = "1111" then
				    if instruct(1 downto 0) = "10" then
				      pcplusi <= '1';
				    elsif instruct(1 downto 0) = "11" then
				      rplusi <= '1';
				    end if; 
				 end if;  
			     next_state <= S2;  
			   
			  when S2 =>
			    if instruct(7 downto 4) = "1111" then
				    if instruct(1 downto 0) = "00" then
				        writeRFL <= '1';
			      elsif instruct(1 downto 0) = "01" then
				        writeRFH <= '1';
				    elsif instruct(1 downto 0) = "10" then
			         writeregf <= '1';
			      else   
			         writeregf <= '0'; 
				    end if;    
			    else 
			      if instruct = "00000111" or instruct = "00001000" or instruct = "00001001" or instruct = "00001010" then
				      writeregf <= '0';
				    else  
				      writeregf <= '1';
				  end if;
				 
			       
		      end if;
			       
			       read <= '1';	       
			       if( sh = '1' and im = '0' )then
			         sh <= '0';
			         next_state <= S01;      
			       else
			         irordata <= '0';
			         next_state <= S0;
			       end if;  
			  
			  when S3 =>
			 -- read <= '1'; 
				-- next_state <= S0;
			  when S4 =>
			  if( sh = '1' and im = '0' )then
	         sh <= '0';
	         next_state <= S01;      
			  else
		       next_state <= S0;
			       end if; 
			          
			  read <= '1';  
				next_state <= S0;
		end case;
	end process;
end architecture;
