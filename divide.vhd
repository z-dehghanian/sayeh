library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity div is
    port(
        operanda:     in std_logic_vector(15 downto 0);
        operandb:     in std_logic_vector(15 downto 0);
        errorsig:     out std_logic := '0';
        result_low:   out std_logic_vector(15 downto 0);
        result_high:  out std_logic_vector(15 downto 0)
    );
end div;

architecture foo of div is

begin


    process(operanda,operandb)
        variable quotient:  unsigned (15 downto 0);
        variable remainder: unsigned (15 downto 0);
    begin  
        errorsig <= '0';      
        if operandb = "0000000000000000" then
       
            assert  operandb /= "0000000000000000"
                report "Division by Zero Exception"
                severity ERROR;
            errorsig <= '1';
        else 
            quotient := (others => '0'); 
            remainder := (others => '0');
           for i in 15 downto 0 loop  
               remainder := remainder (14 downto 0) & '0'; 
               remainder(0) := operanda(i);       
               if remainder >= unsigned(operandb) then 
                    remainder := remainder - unsigned(operandb);
                    quotient(i) := '1';
               end if;
            end loop;
            result_high <= std_logic_vector(quotient); 
            result_low  <= std_logic_vector(remainder); 
        end if;
    end process;

end architecture foo;
