-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 13.4.2024 15:42:52 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_dominik_zkouska is
end tb_dominik_zkouska;

architecture tb of tb_dominik_zkouska is

    component dominik_zkouska
    port (clk  : in std_logic;
        BTNU : in std_logic;
        BTND : in std_logic;
        BTNL : in std_logic;
        BTNR : in std_logic;
        AN   : out std_logic_vector (7 downto 0);
        seg_debug : out STD_LOGIC_VECTOR(6 downto 0);
        output_display : out STD_LOGIC_VECTOR(7 downto 0);
        CA   : out std_logic;
        CB   : out std_logic;
        CC   : out std_logic;
        CD   : out std_logic;
        CE   : out std_logic;
        CF   : out std_logic;
        CG   : out std_logic);
end component;

signal clk  : std_logic;
signal BTNU : std_logic;
signal BTND : std_logic;
signal BTNL : std_logic;
signal BTNR : std_logic;
signal AN   : std_logic_vector (7 downto 0);
signal seg_debug: STD_LOGIC_VECTOR(6 downto 0);
signal output_display: STD_LOGIC_VECTOR(7 downto 0);
signal CA   : std_logic;
signal CB   : std_logic;
signal CC   : std_logic;
signal CD   : std_logic;
signal CE   : std_logic;
signal CF   : std_logic;
signal CG   : std_logic;

constant TbPeriod : time := 100 ns; -- EDIT Put right period here
signal TbClock : std_logic := '0';
signal TbSimEnded : std_logic := '0';

begin

    dut : dominik_zkouska
    port map (clk  => clk,
        BTNU => BTNU,
        BTND => BTND,
        BTNL => BTNL,
        BTNR => BTNR,
        AN   => AN,
        seg_debug => seg_debug,
        output_display => output_display,
        CA   => CA,
        CB   => CB,
        CC   => CC,
        CD   => CD,
        CE   => CE,
        CF   => CF,
        CG   => CG);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        BTNU <= '0';
        wait for 100 ns;
        BTNU <= '1';
        wait for 100 ns;
        BTNU <= '0';
        wait for 100 ns;
        
        BTNR <= '1';
        wait for 100 ns;
        BTNR <= '0';
        wait for 100 ns;
        BTNR <= '1';
        wait for 100 ns;
        BTNR <= '0';
        wait for 100 ns;
        
        BTNU <= '1';
        wait for 100 ns;
        BTNU <= '0';
        wait for 100 ns;
        
        BTNR <= '1';
        wait for 100 ns;
        BTNR <= '0';
        wait for 100 ns;
        
        BTNR <= '1';
        wait for 100 ns;
        BTNR <= '0';
        wait for 100 ns;
        
        BTNR <= '1';
        wait for 100 ns;
        BTNR <= '0';
        wait for 100 ns;

        BTNU <= '1';
        wait for 100 ns;
        BTNU <= '0';
        wait for 100 ns;
        
        BTNR <= '1';
        wait for 100 ns;
        BTNR <= '0';
        wait for 100 ns;
        
        BTNR <= '1';
        wait for 100 ns;
        BTNR <= '0';
        wait for 100 ns;
        
        BTNU <= '1';
        wait for 100 ns;
        BTNU <= '0';
        wait for 100 ns;

        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_dominik_zkouska of tb_dominik_zkouska is
    for tb
end for;
end cfg_tb_dominik_zkouska;