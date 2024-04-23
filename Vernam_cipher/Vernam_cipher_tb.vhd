-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 23.4.2024 12:28:15 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_Vernam_cipher is
end tb_Vernam_cipher;

architecture tb of tb_Vernam_cipher is

    component Vernam_cipher
    port (clk             : in std_logic;
        input           : in std_logic_vector (7 downto 0);
        shift           : in std_logic_vector (7 downto 0);
        coded_txt_input : in std_logic_vector (7 downto 0);
        SW              : in std_logic;
        decode_output   : out std_logic_vector (7 downto 0);
        code_output     : out std_logic_vector (7 downto 0));
end component;

signal clk             : std_logic;
signal input           : std_logic_vector (7 downto 0);
signal shift           : std_logic_vector (7 downto 0);
signal coded_txt_input : std_logic_vector (7 downto 0);
signal SW              : std_logic;
signal decode_output   : std_logic_vector (7 downto 0);
signal code_output     : std_logic_vector (7 downto 0);

constant TbPeriod : time := 1000 ns; -- EDIT Put right period here
signal TbClock : std_logic := '0';
signal TbSimEnded : std_logic := '0';

begin

    dut : Vernam_cipher
    port map (clk             => clk,
        input           => input,
        shift           => shift,
        coded_txt_input => coded_txt_input,
        SW              => SW,
        decode_output   => decode_output,
        code_output     => code_output);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        SW <= '0';
        wait for 100 ns;
        input <= b"0100_0001";
        wait for 100 ns;
        shift <= b"0000_0011";
        wait for 100 ns;
        SW <= '1';
        wait for 100 ns;
        coded_txt_input <=b"0100_0010";
        

        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_Vernam_cipher of tb_Vernam_cipher is
    for tb
end for;
end cfg_tb_Vernam_cipher;
