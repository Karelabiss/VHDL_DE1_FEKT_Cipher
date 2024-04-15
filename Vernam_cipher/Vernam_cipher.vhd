library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity random_generator is
    Port (
        clk                 : in STD_LOGIC;
        reset               : in STD_LOGIC := '0';
        txt                 : in STD_LOGIC_VECTOR(7 downto 0);
        coded_txt_input     : in STD_LOGIC_VECTOR(7 downto 0);
        SW                  : in STD_LOGIC_VECTOR(1 downto 0);
        random_seed         : in STD_LOGIC_VECTOR(7 downto 0);
        code_txt            : out STD_LOGIC_VECTOR(7 downto 0);
        decode_txt          : out STD_LOGIC_VECTOR(7 downto 0)
        --array_of_key_debug  : out STD_LOGIC_VECTOR(7 downto 0)
    );
end random_generator;

architecture Behavioral of random_generator is
    
    signal key : STD_LOGIC_VECTOR(7 downto 0);
    signal array_of_key : STD_LOGIC_VECTOR(2400 downto 0);
    signal code_index: integer :=0;
    signal decode_index: integer :=0;
    signal key_index: integer :=0;
    signal prev_txt : STD_LOGIC_VECTOR(7 downto 0):=b"0000_0000";
    signal key_cnt : INTEGER :=0;
    signal input_cnt : INTEGER :=0;
    
begin
    
    counting : process(clk,txt)
    begin
        if rising_edge(clk) then
            if (txt(7 downto 0) /= prev_txt(7 downto 0)) then
                input_cnt <= input_cnt +1;
                prev_txt <= txt;
            end if;
        end if;
    end process counting;
    
    random_number: process(clk)
    begin
        if reset = '1' then
            key <= random_seed;
        elsif rising_edge(clk) then
            key(0) <= key(7) xor key(5) xor key(4) xor key(3);
            key(1) <= key(0);
            key(2) <= key(1);
            key(3) <= key(2);
            key(4) <= key(3);
            key(5) <= key(4);
            key(6) <= key(5);
            key(7) <= key(6);
            
            key_cnt <= key_cnt+1;
            
        end if;
        
    end process random_number;

    array_of_key(key_index * 8 + 7 downto key_index * 8) <= key;

    code:process(clk)
    begin
        if rising_edge(clk) then
            --array_of_key_debug <=array_of_key(code_index * 8 + 7 downto code_index * 8);
            if (code_index < input_cnt) then
                if(SW(0)='1' and SW(1)='0') then
                    code_txt <= txt XOR array_of_key(code_index * 8 + 7 downto code_index * 8);
                    
                    if code_index < 299 then
                        code_index <= code_index + 1;
                    else
                        code_index <= 0;
                    end if;
                end if;
            end if;
                if key_index < 299 then
                    key_index <= key_index + 1;
                else
                    key_index <= 0;
                end if;
                
            end if;
        end process code;

        decode : process(clk)
        begin
            
            if rising_edge(clk) then
                if(SW(1)='1' and SW(0)='0') then
                    if (decode_index < input_cnt) then
                        decode_txt <= coded_txt_input XOR array_of_key(decode_index * 8 + 7 downto decode_index * 8);
                        
                        if decode_index < 299 then
                            decode_index <= decode_index + 1;
                        else
                            decode_index <= 0;
                        end if;
                    end if;
                end if;
            end if;
        end process decode;
        

    end Behavioral;







