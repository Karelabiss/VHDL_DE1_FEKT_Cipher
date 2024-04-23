library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity atbash_cipher is
    port (
        clk             : in std_logic;
        input           : in  std_logic_vector(7 downto 0);
        coded_txt_input : in STD_LOGIC_VECTOR(7 downto 0);
        SW              : in STD_LOGIC;
        decode_output    : out std_logic_vector(7 downto 0);
        code_output      : out std_logic_vector(7 downto 0)
    );
end entity atbash_cipher;

architecture Behavioral of atbash_cipher is
begin
    
    code : process (clk)

    begin
        if (rising_edge(clk)) then
            
            if (SW='0') then
                
                case input is
                    
                    when b"0100_0001" =>
                        code_output <= b"0101_1010";
                    when b"0100_0010" =>
                        code_output <= b"0101_1001";
                    when b"0100_0011" =>
                        code_output <= b"0101_1000";
                    when b"0100_0100" =>
                        code_output <= b"0101_0111";
                    when b"0100_0101" =>
                        code_output <= b"0101_0110";
                    when b"0100_0110" =>
                        code_output <= b"0101_0101";
                    when b"0100_0111" =>
                        code_output <= b"0101_0100";
                    when b"0100_1000" =>
                        code_output <= b"0101_0011";
                    when b"0100_1001" =>
                        code_output <= b"0101_0010";
                    when b"0100_1010" =>
                        code_output <= b"0101_0001";
                    when b"0100_1011" =>
                        code_output <= b"0101_0000";
                    when b"0100_1100" =>
                        code_output <= b"0100_1111";
                    when b"0100_1101" =>
                        code_output <= b"0100_1110";
                    when b"0100_1110" =>
                        code_output <= b"0100_1101";
                    when b"0100_1111" =>
                        code_output <= b"0100_1100";
                    when b"0101_0000" =>
                        code_output <= b"0100_1011";
                    when b"0101_0001" =>
                        code_output <= b"0100_1010";
                    when b"0101_0010" =>
                        code_output <= b"0100_1001";
                    when b"0101_0011" =>
                        code_output <= b"0100_1000";
                    when b"0101_0100" =>
                        code_output <= b"0100_0111";
                    when b"0101_0101" =>
                        code_output <= b"0100_0110";
                    when b"0101_0110" =>
                        code_output <= b"0100_0101";
                    when b"0101_0111" =>
                        code_output <= b"0100_0100";
                    when b"0101_1000" =>
                        code_output <= b"0100_0011";
                    when b"0101_1001" =>
                        code_output <= b"0100_0010";
                    when b"0101_1010" =>
                        code_output <= b"0100_0001";
                    when others       =>
                        code_output <= b"1111_1111";
                end case;
            end if;
        end if;
        
    end process code;

    decode : process (clk)

    begin
        if (rising_edge(clk)) then
            if (SW='1') then
                case coded_txt_input is
                    
                    when b"0101_1010" =>
                        decode_output <= b"0100_0001";
                    when b"0101_1001" =>
                        decode_output <= b"0100_0010";
                    when b"0101_1000"=>
                        decode_output <= b"0100_0011";
                    when b"0101_0111" =>
                        decode_output <= b"0100_0100";
                    when b"0101_0110" =>
                        decode_output <= b"0100_0101";
                    when b"0101_0101" =>
                        decode_output <= b"0100_0110";
                    when b"0101_0100" =>
                        decode_output <= b"0100_0111";
                    when b"0101_0011" =>
                        decode_output <= b"0100_1000";
                    when b"0101_0010" =>
                        decode_output <= b"0100_1001";
                    when b"0101_0001" =>
                        decode_output <= b"0100_1010";
                    when b"0101_0000" =>
                        decode_output <= b"0100_1011";
                    when b"0100_1111" =>
                        decode_output <= b"0100_1100";
                    when b"0100_1110" =>
                        decode_output <= b"0100_1101";
                    when b"0100_1101" =>
                        decode_output <= b"0100_1110";
                    when b"0100_1100" =>
                        decode_output <= b"0100_1111";
                    when b"0100_1011" =>
                        decode_output <= b"0101_0000";
                    when b"0100_1010" =>
                        decode_output <= b"0101_0001";
                    when b"0100_1001" =>
                        decode_output <= b"0101_0010";
                    when b"0100_1000" =>
                        decode_output <= b"0101_0011";
                    when b"0100_0111" =>
                        decode_output <= b"0101_0100";
                    when b"0100_0110" =>
                        decode_output <= b"0101_0101";
                    when b"0100_0101" =>
                        decode_output <= b"0101_0110";
                    when b"0100_0100" =>
                        decode_output <= b"0101_0111";
                    when b"0100_0011" =>
                        decode_output <= b"0101_1000";
                    when b"0100_0010" =>
                        decode_output <= b"0101_1001";
                    when b"0100_0001" =>
                        decode_output <= b"0101_1010";
                    when others       =>
                        decode_output <= b"1111_1111";

                end case;
            end if;
        end if;
            
        end process decode;


    end architecture Behavioral;