-------------------------------------------------
--! @brief Top level implementation for 4-bit adder
--! @version 1.1
--! @copyright (c) 2019-2024 Tomas Fryza, MIT license
--!
--! This VHDL module integrates a 4-bit adder and a binary-to-
--! 7-segment decoder to perform addition on two 4-bit binary
--! numbers represented by on-bboard switches 'SW_B' and 'SW_A'.
--! The result is shown on the 7-segment display, and the carry
--! output is indicated by 'LED_RED'. The input values are
--! displayed on LEDs.
--!
--! Developed using TerosHDL, Vivado 2023.2, and EDA Playground.
--! Tested on Nexys A7-50T board and xc7a50ticsg324-1L FPGA.
-------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

-------------------------------------------------

entity top_level is
    port (
        CLK100MHZ : in std_logic;
        BTNC   : in std_logic;
        JD_1   : in    std_logic;
        JD_2   : in    std_logic
    );
end entity top_level;

-------------------------------------------------

architecture behavioral of top_level is
    -- Component declaration for 4-bit added
    
    component clock_enable is
        generic (
            N_PERIODS : integer
        );
        port (
            clk   : in    std_logic;
            rst   : in    std_logic;
            pulse : out   std_logic
        );
    end component;
    
    component uart_tx is
        generic (
            g_CLKS_PER_BIT : integer := 115   -- Needs to be set correctly
        );
        port (
            i_clk       : in  std_logic;
            i_tx_dv     : in  std_logic;
            i_tx_byte   : in  std_logic_vector(7 downto 0);
            o_tx_active : out std_logic;
            o_tx_serial : out std_logic;
            o_tx_done   : out std_logic
        );
    end component uart_tx;
    
    component uart_rx is
        generic (
            g_CLKS_PER_BIT : integer := 115   -- Needs to be set correctly
        );
        port (
            i_clk       : in  std_logic;
            i_rx_serial : in  std_logic;
            o_rx_dv     : out std_logic;
            o_rx_byte   : out std_logic_vector(7 downto 0)
        );
    end component uart_rx;

    constant c_CLKS_PER_BIT : integer := 87;
    
    constant c_BIT_PERIOD : time := 8680 ns;
    
    signal Main_CLOCK     : std_logic                 := '0';
    signal r_TX_DV     : std_logic                    := '0';
    signal r_TX_BYTE   : std_logic_vector(7 downto 0) := (others => '0');
    signal w_TX_SERIAL : std_logic;
    signal w_TX_DONE   : std_logic;
    signal w_RX_DV     : std_logic;
    signal w_RX_BYTE   : std_logic_vector(7 downto 0);
    signal r_RX_SERIAL : std_logic := '1';
    
begin
    
    clk_en0 : component clock_enable
    generic map (
        N_PERIODS => 10
    )
    port map (
        clk   => CLK100MHZ,
        rst   => BTNC,
        pulse => Main_CLOCK
    );
    
    tx_uart : component uart_tx
    generic map (
        g_CLKS_PER_BIT => c_CLKS_PER_BIT
    )
    port map (
        i_clk       => Main_CLOCK,
        i_tx_dv     => r_TX_DV,
        i_tx_byte   => r_TX_BYTE,
        o_tx_serial => JD_2
    );

    rx_uart : component uart_rx
    generic map (
        g_CLKS_PER_BIT => c_CLKS_PER_BIT
    )
    port map (
        i_clk       => Main_CLOCK,
        i_rx_serial => JD_1,
        o_rx_dv     => w_RX_DV,
        o_rx_byte   => w_RX_BYTE
    );

end architecture behavioral;