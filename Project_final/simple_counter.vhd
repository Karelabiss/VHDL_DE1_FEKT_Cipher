
-------------------------------------------------
--! @brief N-bit binary counter (Ver. internal integer)
--! @version 1.3
--! @copyright (c) 2019-2024 Tomas Fryza, MIT license
--!
--! Implementation of N-bit up counter with enable input and
--! high level reset. The width of the counter (number of bits)
--! is set generically using `NBIT`. The data type of the
--! internal counter is `integer`.
--!
--! Developed using TerosHDL, Vivado 2023.2, and EDA Playground.
--! Tested on Nexys A7-50T board and xc7a50ticsg324-1L FPGA.
-------------------------------------------------

library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all; -- Package for data types conversion

-------------------------------------------------

entity simple_counter is
    generic (
        NBIT : integer := 3 --! Number of bits
    );
    port (
        clk   : in    std_logic;                          --! Main clock
        rst   : in    std_logic;                          --! High-active synchronous reset
        en    : in    std_logic;                          --! Clock enable input
        count : out   std_logic_vector(NBIT - 1 downto 0) --! Counter value
    );
end entity simple_counter;

-------------------------------------------------

architecture behavioral of simple_counter is
    --! Local counter
    signal sig_count : integer range 0 to (2 ** NBIT - 1);
begin

    --! Clocked process with synchronous reset which implements
    --! N-bit up counter.
    p_simple_counter : process (clk) is
    begin

        if (rising_edge(clk)) then
            -- Synchronous, active-high reset
            if (rst = '1') then
                sig_count <= 0;

            -- Clock enable activated
            elsif (en = '1') then
                -- Test the maximum value
                if (sig_count < (2 ** NBIT - 1)) then
                    sig_count <= sig_count + 1;
                else
                    sig_count <= 0;
                end if;

            -- Each `if` must end by `end if`
            end if;
        end if;

    end process p_simple_counter;

    -- Assign internal register to output
    -- Note: integer--> unsigned--> std_logic vector
    count <= std_logic_vector(to_unsigned(sig_count, NBIT));

end architecture behavioral;
