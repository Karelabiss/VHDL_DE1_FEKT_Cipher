----------------------------------------------------------
--
--! @title Driver for 4-digit 7-segment display
--! @author Tomas Fryza
--! Dept. of Radio Electronics, Brno Univ. of Technology, Czechia
--!
--! @copyright (c) 2020 Tomas Fryza
--! This work is licensed under the terms of the MIT license
--
-- Hardware: Nexys A7-50T, xc7a50ticsg324-1L
-- Software: TerosHDL, Vivado 2020.2, EDA Playground
--
----------------------------------------------------------

library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

----------------------------------------------------------
-- Entity declaration for display driver
--
--             +-------------------+
--        -----|> clk              |
--        -----| rst            dp |-----
--             |          seg(6:0) |--/--
--        --/--| data0(3:0)        |  7
--        --/--| data1(3:0)        |
--        --/--| data2(3:0)        |
--        --/--| data3(3:0)        |
--          4  |           dig(3:0)|--/--
--        --/--| dp_vect(3:0)      |  4
--          4  +-------------------+
--
-- Inputs:
--   clk          -- Main clock
--   rst          -- Synchronous reset
--   dataX(3:0)   -- Data values for individual digits
--   dp_vect(3:0) -- Decimal points for individual digits
--
-- Outputs:
--   dp:          -- Decimal point for specific digit
--   seg(6:0)     -- Cathode values for individual segments
--   dig(3:0)     -- Common anode signals to individual digits
--
----------------------------------------------------------

entity driver_7seg_4digits is
    port (
        clk     : in    std_logic;
        rst     : in    std_logic;
        data0   : in    std_logic_vector(1 downto 0);
        data1   : in    std_logic_vector(1 downto 0);
        data2   : in    std_logic_vector(1 downto 0);
        data3   : in    std_logic_vector(1 downto 0);
        data4   : in    std_logic_vector(1 downto 0);
        data5   : in    std_logic_vector(1 downto 0);
        data6   : in    std_logic_vector(1 downto 0);
        data7   : in    std_logic_vector(1 downto 0);
        dp      : out   std_logic;
        seg     : out   std_logic_vector(6 downto 0);
        dig     : out   std_logic_vector(7 downto 0)
    );
end entity driver_7seg_4digits;

----------------------------------------------------------
-- Architecture declaration for display driver
----------------------------------------------------------

architecture behavioral of driver_7seg_4digits is
    component simple_counter is
        generic (
            NBIT : integer
        );
        port (
            clk   : in    std_logic;
            rst   : in    std_logic;
            en    : in    std_logic;
            count : out   std_logic_vector(NBIT - 1 downto 0)
        );
    end component;

    component clock_enable is
        generic (
            PERIOD : integer
        );
        port (
            clk   : in    std_logic;
            rst   : in    std_logic;
            pulse : out   std_logic
        );
    end component;

    component bin2seg is
        port (
            clear : in    std_logic;
            bin   : in    std_logic_vector(1 downto 0);
            seg   : out   std_logic_vector(6 downto 0)
        );
    end component;

    -- Internal clock enable
    signal sig_en_4ms : std_logic;

    -- Internal 2-bit counter for multiplexing 4 digits
    signal sig_cnt_7bit : std_logic_vector(2 downto 0);

    -- Internal 4-bit value for 7-segment decoder
    signal sig_hex : std_logic_vector(1 downto 0);
begin

    --------------------------------------------------------
    -- Instance (copy) of clock_enable entity generates
    -- an enable pulse every 4 ms
    --------------------------------------------------------
    clk_en0 : component clock_enable
        generic map (
            -- 4       @ 40 ns for simulation
            -- 200_000 @ 2 ms
            PERIOD => 200_000
        )
        port map (
            clk   => clk,
            rst   => rst,
            pulse => sig_en_4ms
        );

    --------------------------------------------------------
    -- Instance (copy) of cnt_up_down entity performs
    -- a 2-bit down counter
    --------------------------------------------------------
    bin_cnt0 : component simple_counter
        generic map (
            NBIT => 3
        )
        port map (
            clk   => clk,
            rst   => rst,
            en    => sig_en_4ms,
            count => sig_cnt_7bit
        );

    --------------------------------------------------------
    -- Instance (copy) of hex_7seg entity performs
    -- a 7-segment display decoder
    --------------------------------------------------------
    hex2seg : component bin2seg
        port map (
            clear => rst,
            bin   => sig_hex,
            seg   => seg
        );

    --------------------------------------------------------
    -- p_mux:
    -- A sequential process that implements a multiplexer for
    -- selecting data for a single digit, a decimal point,
    -- and switches the common anodes of each display.
    --------------------------------------------------------
    p_mux : process (clk) is
    begin

        if rising_edge(clk) then
            if (rst = '1') then
                sig_hex <= data0;
                dig     <= "11111110";
            else

                case sig_cnt_7bit is

                    when "111" =>
                        sig_hex <= data1;
                        dig     <= "01111111";

                    when "110" =>
                        -- DEFINE ALL OUTPUTS FOR "10" HERE
                        sig_hex <= data2;
                        dig     <= "10111111";

                    when "101" =>
                        -- DEFINE ALL OUTPUTS FOR "01" HERE
                        sig_hex <= data3;
                        dig     <= "11011111";
                        
                        when "100" =>
                        sig_hex <= data4;
                        dig     <= "11101111";

                    when "011" =>
                        -- DEFINE ALL OUTPUTS FOR "10" HERE
                        sig_hex <= data5;
                        dig     <= "11110111";

                    when "010" =>
                        -- DEFINE ALL OUTPUTS FOR "01" HERE
                        sig_hex <= data6;
                        dig     <= "11111011";

                    when "001" =>
                        -- DEFINE ALL OUTPUTS FOR "01" HERE
                        sig_hex <= data7;
                        dig     <= "11111101";
                        
                    when others =>
                        -- DEFINE ALL OUTPUTS FOR "00" HERE
                        sig_hex <= data0;
                        dig     <= "11111110";

                end case;

            end if;
        end if;

    end process p_mux;

end architecture behavioral;