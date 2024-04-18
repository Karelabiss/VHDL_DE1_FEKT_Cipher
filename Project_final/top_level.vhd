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
        SW        : in    std_logic_vector(7 downto 0); --! 4 by 4-bit data values
        CA        : out   std_logic;                     --! Cathod A
        CB        : out   std_logic;                     --! Cathod B
        CC        : out   std_logic;                     --! Cathod C
        CD        : out   std_logic;                     --! Cathod D
        CE        : out   std_logic;                     --! Cathod E
        CF        : out   std_logic;                     --! Cathod F
        CG        : out   std_logic;                     --! Cathod G
        DP        : out   std_logic;                     --! Decimal point
        AN        : out   std_logic_vector(7 downto 0);  --! Common anode signals to individual displays
        BTNC      : in    std_logic;                      --! Synchronous reset
        BTNR      : in    STD_LOGIC;
        SWL       : in    std_logic_vector (4 downto 0);
        Code_vernam : out STD_LOGIC_VECTOR(7 downto 0);
        Decode_vernam : out STD_LOGIC_VECTOR(7 downto 0);
        Code_ceaser : out STD_LOGIC_VECTOR(7 downto 0);
        Decode_ceaser : out STD_LOGIC_VECTOR(7 downto 0);
        random_seed : out STD_LOGIC_VECTOR(7 downto 0);
        TX        : out   STD_LOGIC
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
    
    
    
    
    -- Component declaration for clock enable
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

    -- Component declaration for button debouncer
    component debounce is
        port (
            clk      : in    std_logic;
            rst      : in    std_logic;
            en       : in    std_logic;
            bouncey  : in    std_logic;
            clean    : out   std_logic;
            pos_edge : out   std_logic;
            neg_edge : out   std_logic
        );
    end component;

    -- Component declaration for serial tx
    component serial_tx is
        port (
            clk     : in    STD_LOGIC;
            rst     : in    STD_LOGIC;
            data    : in    STD_LOGIC_VECTOR(7 downto 0);
            trigger : in    STD_LOGIC;
            tx      : out   STD_LOGIC
        );
    end component;

    -- Local signals
    --! Clock enable signal for debouncer
    signal sig_en_2ms : std_logic;
    --! Edge-driven signal that lasts for only one clock cycle
    signal sig_event : std_logic;
    
    --data_out
    signal output_data : std_logic_vector (7 downto 0);
    
    
    

begin
-- Component instantiation of clock enable for 2 ms
    button_en : component clock_enable
        generic map (
            PERIOD => 200_000
        )
        port map (
            clk   => CLK100MHZ,
            rst   => BTNC,
            pulse => sig_en_2ms
        );

    -- Component instantiation of button debouncer
    button : component debounce
        port map (
            clk      => CLK100MHZ,
            rst      => BTNC,
            en       => sig_en_2ms,
            bouncey  => BTNR,
            clean    => open,
            pos_edge => sig_event,
            neg_edge => open
        );

    -- Component instantiation of serial tx
    serial : component serial_tx
        port map (
            clk     => CLK100MHZ,
            rst     => BTNC,
            data    => output_data,
            trigger => sig_event,
            tx      => TX
        );




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
        
        output_data(7) <= SW(7);
        output_data(6) <= SW(6);
        output_data(5) <= SW(5);
        output_data(4) <= SW(4);
        output_data(3) <= SW(3);
        output_data(2) <= SW(2);
        output_data(1) <= SW(1);
        output_data(0) <= SW(0);
        
    code_decode : process(CLK100MHZ)
    begin
        if (rising_edge(CLK100MHZ)) then
            
            case SWL is
                
                when "00001" =>
                    Code_ceaser <= output_data;
                    
                when "0010" =>
                    Code_vernam <= output_data;
                    
                when "1001" =>
                    Decode_ceaser <= output_data;
                    
                when "1010" =>
                    Decode_vernam <= output_data;
                    
                when "0100" =>
                    random_seed <= output_data;
                 
                        
            end case;
        end if;
end process code_decode;        
        
        
        
    --------------------------------------------------------
    -- Other settings
    --------------------------------------------------------
    -- Disconnect the top four digits of the 7-segment display
    --AN(7 downto 4) <= b"0000";

end architecture behavioral;