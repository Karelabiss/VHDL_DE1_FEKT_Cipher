-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 9.4.2024 19:10:45 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_random_generator is
end tb_random_generator;

architecture tb of tb_random_generator is

    component random_generator
    port (clk                : in std_logic;
        reset              : in std_logic;
        txt                : in std_logic_vector (7 downto 0);
        code_txt           : out std_logic_vector (7 downto 0);
        decode_txt         : out std_logic_vector (7 downto 0);
        array_of_key_debug : out std_logic_vector (7 downto 0));
end component;

signal clk                : std_logic;
signal reset              : std_logic;
signal txt                : std_logic_vector (7 downto 0);
signal code_txt           : std_logic_vector (7 downto 0);
signal decode_txt         : std_logic_vector (7 downto 0);
signal array_of_key_debug : std_logic_vector (7 downto 0);

constant TbPeriod : time := 100 ns; -- EDIT Put right period here
signal TbClock : std_logic := '0';
signal TbSimEnded : std_logic := '0';

begin

    dut : random_generator
    port map (clk                => clk,
        reset              => reset,
        txt                => txt,
        code_txt           => code_txt,
        decode_txt         => decode_txt,
        array_of_key_debug => array_of_key_debug);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    
    
    
    stimuli : process
    begin
        
        -- Reset generation
        -- EDIT: Check that reset is really your reset signal
        reset <= '1';
        wait for 10 ns;
        reset <= '0';
        wait for 10 ns;
        
        
        -- EDIT Adapt initialization as needed
        txt <= "01000001";
        wait for 100 ns;
        txt <= "01001000";
        wait for 100 ns;
        txt <= "01001111";
        wait for 100 ns;
        txt <= "01001010";

        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_random_generator of tb_random_generator is
    for tb
end for;
end cfg_tb_random_generator;
