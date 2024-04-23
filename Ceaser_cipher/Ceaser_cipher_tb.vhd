
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
        decode_output    : out std_logic_vector (7 downto 0);
        SW              : in std_logic;
        coded_txt_input : in std_logic_vector (7 downto 0);
        code_output      : out std_logic_vector (7 downto 0));
end component;

signal clk             : std_logic;
signal input           : std_logic_vector (7 downto 0);
signal shift           : std_logic_vector (7 downto 0);
signal decode_output    : std_logic_vector (7 downto 0);
signal SW              : std_logic;
signal coded_txt_input : std_logic_vector (7 downto 0);
signal code_output      : std_logic_vector (7 downto 0);

constant TbPeriod : time := 10 ns; -- EDIT Put right period here
signal TbClock : std_logic := '0';
signal TbSimEnded : std_logic := '0';

begin

    dut : BinaryAdder
    port map (clk             => clk,
        input           => input,
        shift           => shift,
        decode_output    => decode_output,
        SW              => SW,
        coded_txt_input => coded_txt_input,
        code_output      => code_output);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
               -- Test cases
        shift <= "00000010";
        SW<= '0';
        wait for 10 ns;
        input <= "01000001";
        wait for 150 ns;    
        input <= "01001000";
        wait for 80 ns;
        input <= "01001111";
        wait for 30 ns;
        input <= "01001010";
        wait for 15 ns;

        
        SW<= '1';
        coded_txt_input <= "01000011";
        wait for 10 ns;
        coded_txt_input <= "01001010";
        wait for 10 ns;
        coded_txt_input <= "01010001";
        wait for 10 ns;
        coded_txt_input <= "01001100";
        wait for 10 ns;
        

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



