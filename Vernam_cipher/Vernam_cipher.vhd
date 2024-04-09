library IEEE;
use IEEE.std_logic_1164.all;

entity random_generator is
    Port (
        clk :        in STD_LOGIC;
        reset :      in STD_LOGIC := '0'; -- Reset nula
        txt :        in STD_LOGIC_VECTOR(7 downto 0);
        data_out :   out STD_LOGIC_VECTOR(7 downto 0);
        code_txt :   out STD_LOGIC_VECTOR(7 downto 0);
        decode_txt : out STD_LOGIC_VECTOR(7 downto 0);
        array_of_key_debug : out STD_LOGIC_VECTOR(7 downto 0)
    );
end random_generator;

architecture Behavioral of random_generator is
    
    signal key : STD_LOGIC_VECTOR(7 downto 0);
    signal array_of_key : STD_LOGIC_VECTOR(2400 downto 0);
    signal code_txt_x : STD_LOGIC_VECTOR(7 downto 0);
    signal index: integer :=0;
    
begin
    random_number: process(clk)
    begin
        if reset = '1' then
            key <= (others => '1');
        elsif rising_edge(clk) then
                -- Generování posloupnosti pomocí LFSR, musíme udělat random seed na tlačítko, aby to fungovalo náhodně
            key(0) <= key(7) xor key(5) xor key(4) xor key(3);
            key(1) <= key(0);
            key(2) <= key(1);
            key(3) <= key(2);
            key(4) <= key(3);
            key(5) <= key(4);
            key(6) <= key(5);
            key(7) <= key(6);
        end if;
    end process random_number;
    
    --data_out <= key;
    --code_txt <= txt XOR key;
    
    
    array_of_key(index * 8 + 7 downto index * 8) <= key;
    
    
    
    --code_txt_x <= txt XOR key;
    --decode_txt <= key XOR code_txt_x;
    
    process(clk)
    begin
        if rising_edge(clk) then
            array_of_key_debug <=array_of_key(index * 8 + 7 downto index * 8);
            
            code_txt <= txt XOR array_of_key(index * 8 + 7 downto index * 8);
            
            if index < 299 then
                index <= index + 1;
            else
                index <= 0; 
            end if;
        end if;
    end process;
    
    code_txt_x <= txt XOR array_of_key(index * 8 + 7 downto index * 8);
    decode_txt <= code_txt_x XOR array_of_key(index * 8 + 7 downto index * 8);
    
end Behavioral;







