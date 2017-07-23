

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity memory is
	generic (blocksize : integer := 1024);

	port (clk, readmem, writemem : in std_logic;
		addressbus: in std_logic_vector (15 downto 0);
		databus : out std_logic_vector (15 downto 0);
		databus1 : in std_logic_vector (15 downto 0);
		
		memdataready : out std_logic);
end entity memory;

architecture behavioral of memory is
	type mem is array (0 to blocksize - 1) of std_logic_vector (15 downto 0);
begin
	process (clk, readmem)
		variable buffermem : mem := (others => (others => '0'));
		variable ad : integer;
		variable init : boolean := true;
	begin
		if init = true then
			-- some initiation
			buffermem(0) := "0010011110100001"; --mil
			buffermem(1) := "0000101000000111"; --mih
			buffermem(2) := "1111110010001000"; --mil
			buffermem(3) := "1111110100001000"; --mih
			--buffermem(4) := "0011101100001000"; --sta
			init := false;
		end if;

		--databus <= (others => 'Z');

		if  clk'event and clk = '1' then
			ad := to_integer(unsigned(addressbus));

			if readmem = '1' then -- Readiing :)
				memdataready <= '0';
				if ad >= blocksize then
			--		databus <= (others => 'Z');
				else
					databus <= buffermem(ad);
				end if;
			
			elsif writemem = '1' then -- Writing :)
				memdataready <= '0';
				if ad < blocksize then
					buffermem(ad) := databus1;
				end if;
			else
			--	databus <= (others => 'Z');

			end if;
			memdataready <= '1';
		end if;
	end process;
end architecture behavioral;