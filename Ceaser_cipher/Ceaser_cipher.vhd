library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity BinaryAdder is
    port (
        clk : in std_logic;                             -- Hodinový signál
        input, shift : in  std_logic_vector(7 downto 0);        -- Vstupní hodnoty a a b
        code_input, decode_input : out std_logic_vector(7 downto 0)    -- Výstupní součty
    );
end entity BinaryAdder;

architecture Behavioral of BinaryAdder is
    
    
begin
    process (clk)
    variable temp_sum : unsigned(7 downto 0);
    variable temp_substract : UNSIGNED(7 downto 0);
    
    begin
        if rising_edge(clk) then
            -- Sčítání
            temp_sum := unsigned(input) + unsigned(shift);
            code_input <= std_logic_vector(temp_sum);
            
            -- Odečítání
            temp_substract := temp_sum - unsigned(shift);
            decode_input <= std_logic_vector(temp_substract);
            
        end if;
    end process;
end architecture Behavioral;