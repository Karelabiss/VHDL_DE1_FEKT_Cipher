library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity BinaryAdder is
    port (
        clk             : in std_logic;
        input           : in  std_logic_vector(7 downto 0);
        shift           : in  std_logic_vector(7 downto 0);
        coded_txt_input : in STD_LOGIC_VECTOR(7 downto 0);
        SW              : in STD_LOGIC_VECTOR(1 downto 0);
        decode_input    : out std_logic_vector(7 downto 0);
        code_input      : out std_logic_vector(7 downto 0)
    );
end entity BinaryAdder;

architecture Behavioral of BinaryAdder is
    
    
begin
    code :process (clk)
    variable temp_sum : unsigned(7 downto 0);
    begin
        if rising_edge(clk) then
            
            if(SW(0)='1' and SW(1)='0') then
                temp_sum := unsigned(input) + unsigned(shift);
                code_input <= std_logic_vector(temp_sum);
            end if;
        end if;
    end process code;
    
    decode : process (clk)
    variable temp_substract : UNSIGNED(7 downto 0);
    begin
        if rising_edge(clk) then
            if(SW(0)='0' and SW(1)='1') then
                temp_substract := unsigned(coded_txt_input) - unsigned(shift);
                decode_input <= std_logic_vector(temp_substract);
            end if;
        end if;
    end process decode;
    
    
end architecture Behavioral;





