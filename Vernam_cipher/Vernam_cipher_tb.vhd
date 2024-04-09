library IEEE;
use IEEE.std_logic_1164.all;

entity random_generator_tb is
end random_generator_tb;

architecture testbench of random_generator_tb is
    -- Signály pro testbench
    signal clk_tb : std_logic := '0';
    signal reset_tb : std_logic := '0';
    signal txt_tb : std_logic_vector(7 downto 0) := (others => '0'); -- Vstupní data
    signal data_out_tb : std_logic_vector(7 downto 0);
    signal code_txt_tb : std_logic_vector(7 downto 0);
    signal decode_txt_tb : std_logic_vector(7 downto 0);
    signal array_of_key_debug_tb : STD_LOGIC_VECTOR(7 downto 0);
begin
    -- Připojení testovaného modulu
    DUT: entity work.random_generator
    port map (
        clk => clk_tb,
        reset => reset_tb,
        txt => txt_tb,
        data_out => data_out_tb,
        code_txt => code_txt_tb,
        decode_txt => decode_txt_tb,
        array_of_key_debug => array_of_key_debug_tb
    );

    -- Proces pro generování hodinového signálu
    clk_process: process
    begin
        while now < 1000 ns loop
            clk_tb <= '0';
            wait for 5 ns;
            clk_tb <= '1';
            wait for 5 ns;
        end loop;
        wait;
    end process;

    -- Proces pro reset
    reset_process: process
    begin
        reset_tb <= '1';
        wait for 10 ns;
        reset_tb <= '0';
        wait;
    end process;

    -- Proces pro stimulaci vstupních dat
    stimulus_process: process
    begin
        wait for 15 ns;
        txt_tb <= "01000001";
        wait for 10 ns;
        txt_tb <= "01001000";
        wait for 10 ns;
        txt_tb <= "01001111";
        wait for 10 ns;
        txt_tb <= "01001010";
    end process;
end testbench;