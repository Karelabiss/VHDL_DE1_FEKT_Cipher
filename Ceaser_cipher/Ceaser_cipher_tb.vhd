library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity BinaryAdder_tb is
end entity BinaryAdder_tb;

architecture sim of BinaryAdder_tb is
    signal clk : std_logic := '0';
    signal input, shift : std_logic_vector(7 downto 0) := (others => '0');
    signal code_input, decode_input : std_logic_vector(7 downto 0);
    
    constant CLK_PERIOD : time := 10 ns; -- Define your clock period here

begin
    -- Instantiate the BinaryAdder entity
    DUT: entity work.BinaryAdder
    port map (
        clk => clk,
        input => input,
        shift => shift,
        code_input => code_input,
        decode_input => decode_input
    );

    -- Clock process
    clk_process: process
    begin
        while now < 1000 ns loop -- Simulation time
            clk <= '1';
            wait for CLK_PERIOD / 2;
            clk <= '0';
            wait for CLK_PERIOD / 2;
        end loop;
        wait;
    end process clk_process;

    -- Stimulus process
    stim_process: process
    begin
        -- Test cases
        input <= "01000001";
        shift <= "00000010";
        wait for 20 ns;
        
        input <= "01001000";
        shift <= "00000010";
        wait for 20 ns;
        
        input <= "01001111";
        shift <= "00000010";
        wait for 20 ns;
        
        input <= "01001010";
        shift <= "00000010";
        wait for 20 ns;
        
        -- Add more test cases as needed
        
        wait;
    end process stim_process;

end architecture sim;