----------------------------------------------------------
--
--! @title Top-level for 4-digit 7-segment display driver
--! @author Tomas Fryza
--! Dept. of Radio Electronics, Brno Univ. of Technology, Czechia
--!
--! @copyright (c) 2019 Tomas Fryza
--! This work is licensed under the terms of the MIT license
--
-- Hardware: Nexys A7-50T, xc7a50ticsg324-1L
-- Software: TerosHDL, Vivado 2020.2, EDA Playground
--
----------------------------------------------------------

library ieee;
    use ieee.std_logic_1164.all;

----------------------------------------------------------
-- Entity declaration for top level
----------------------------------------------------------

entity top is
    port (
        CLK100MHZ : in    std_logic;                     --! Main clock
        SW        : in    std_logic_vector(15 downto 0); --! 4 by 4-bit data values
        CA        : out   std_logic;                     --! Cathod A
        CB        : out   std_logic;                     --! Cathod B
        CC        : out   std_logic;                     --! Cathod C
        CD        : out   std_logic;                     --! Cathod D
        CE        : out   std_logic;                     --! Cathod E
        CF        : out   std_logic;                     --! Cathod F
        CG        : out   std_logic;                     --! Cathod G
        DP        : out   std_logic;                     --! Decimal point
        AN        : out   std_logic_vector(7 downto 0);  --! Common anode signals to individual displays
        BTNC      : in    std_logic                      --! Synchronous reset
    );
end entity top;

----------------------------------------------------------
-- Architecture body for top level
----------------------------------------------------------

architecture behavioral of top is
    component driver_7seg_4digits is
        port (
            clk     : in    std_logic;
            rst     : in    std_logic;
            data0   : in    std_logic;
            data1   : in    std_logic;
            data2   : in    std_logic;
            data3   : in    std_logic;
            data4   : in    std_logic;
            data5   : in    std_logic;
            data6   : in    std_logic;
            data7   : in    std_logic;
            dp      : out   std_logic;
            seg     : out   std_logic_vector(6 downto 0);
            dig     : out   std_logic_vector(7 downto 0)
        );
    end component;

begin

    --------------------------------------------------------
    -- Instance (copy) of driver_7seg_4digits entity
    --------------------------------------------------------
    driver_seg_4 : component driver_7seg_4digits
        port map (
            clk      => CLK100MHZ,
            rst      => BTNC,
            
            data0 => SW(0),

            data1 => SW(1),
        
            data2 => SW(2),

            data3 => SW(3),

            data4 => SW(4),

            data5 => SW(5),
       
            data6 => SW(6),

            data7 => SW(7),


            -- DECIMAL POINT
            dp      => DP,

            seg(6) => CA,
            -- MAP OTHER DISPLAY SEGMENTS HERE
            seg(5) => CB,
            seg(4) => CC,
            seg(3) => CD,
            seg(2) => CE,
            seg(1) => CF,
            seg(0) => CG,

            -- DIGITS
            dig(7 downto 0) => AN(7 downto 0)
        );

    --------------------------------------------------------
    -- Other settings
    --------------------------------------------------------
    -- Disconnect the top four digits of the 7-segment display
    --AN(7 downto 4) <= b"0000";

end architecture behavioral;