
-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 11.4.2024 17:17:19 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_BinaryAdder is
end tb_BinaryAdder;

architecture tb of tb_BinaryAdder is

    component BinaryAdder
    port (clk             : in std_logic;
        input           : in std_logic_vector (7 downto 0);
        shift           : in std_logic_vector (7 downto 0);
        decode_input    : out std_logic_vector (7 downto 0);
        SW              : in std_logic_vector (1 downto 0);
        coded_txt_input : in std_logic_vector (7 downto 0);
        code_input      : out std_logic_vector (7 downto 0));
end component;

signal clk             : std_logic;
signal input           : std_logic_vector (7 downto 0);
signal shift           : std_logic_vector (7 downto 0);
signal decode_input    : std_logic_vector (7 downto 0);
signal SW              : std_logic_vector (1 downto 0);
signal coded_txt_input : std_logic_vector (7 downto 0);
signal code_input      : std_logic_vector (7 downto 0);

constant TbPeriod : time := 100 ns; -- EDIT Put right period here
signal TbClock : std_logic := '0';
signal TbSimEnded : std_logic := '0';

begin

    dut : BinaryAdder
    port map (clk             => clk,
        input           => input,
        shift           => shift,
        decode_input    => decode_input,
        SW              => SW,
        coded_txt_input => coded_txt_input,
        code_input      => code_input);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
               -- Test cases
        SW(1)<= '0';
        SW(0)<= '1';
        input <= "01000001";
        shift <= "00000010";
        wait for 100 ns;
        
        input <= "01001000";
        shift <= "00000010";
        wait for 100 ns;
        
        input <= "01001111";
        shift <= "00000010";
        wait for 100 ns;
        
        input <= "01001010";
        shift <= "00000010";
        wait for 100 ns;
        
        SW(1)<= '1';
        SW(0)<= '0';
        coded_txt_input <= "01000011";
        wait for 100 ns;
        coded_txt_input <= "01001010";
        wait for 100 ns;
        coded_txt_input <= "01010001";
        wait for 100 ns;
        coded_txt_input <= "01001100";
        wait for 100 ns;
        

        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_BinaryAdder of tb_BinaryAdder is
    for tb
end for;
end cfg_tb_BinaryAdder;
