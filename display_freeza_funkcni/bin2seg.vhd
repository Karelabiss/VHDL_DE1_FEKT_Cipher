
-------------------------------------------------
--! @brief One-digit 7-segment display decoder
--! @version 1.3
--! @copyright (c) 2018-24 Tomas Fryza, MIT license
--!
--! This VHDL file represents a binary-to-seven-segment decoder
--! for a one-digit display with Common Anode configuration
--! (active-low). The decoder defines 16 hexadecimal symbols:
--! `0, 1, ..., 9, A, b, C, d, E, F`. All segments are turned
--! off when `clear` signal is high. Note that Decimal Point
--! functionality is not implemented.
--!
--! Developed using TerosHDL, Vivado 2020.2, and EDA Playground.
--! Tested on Nexys A7-50T board and xc7a50ticsg324-1L FPGA.
-------------------------------------------------

library ieee;
    use ieee.std_logic_1164.all;

-------------------------------------------------

entity bin2seg is
    port (
        clear : in    std_logic;                    --! Clear the display
        bin   : in    std_logic; --! Binary representation of one hexadecimal symbol
        seg   : out   std_logic_vector(6 downto 0)  --! Seven active-low segments from A to G
    );
end entity bin2seg;

-------------------------------------------------

architecture behavioral of bin2seg is
begin

    --! This combinational process decodes binary input
    --! `bin` into 7-segment display output `seg` for a
    --! Common Anode configuration. When either `bin` or
    --! `clear` changes, the process is triggered. Each
    --! bit in `seg` represents a segment from A to G.
    --! The display is cleared if `clear` is set to 1.
    p_7seg_decoder : process (bin, clear) is
    begin

        if (clear = '1') then
            seg <= "1111111";  -- Clear the display
        else

            case bin is

                when '1' =>
                    seg <= "1001111";
    
                when others =>
                    seg <= "0000001";
            end case;

        end if;

    end process p_7seg_decoder;

end architecture behavioral;
