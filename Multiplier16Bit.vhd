library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Multiplier16Bit is
    Port (
        clk         : in  std_logic;                       -- Clock signal
        reset       : in  std_logic;                       -- Reset signal
        input_data  : in  std_logic_vector(15 downto 0);   -- 16-bit input
        output_data : out std_logic_vector(16 downto 0)    -- 17-bit output
    );
end Multiplier16Bit;

architecture Behavioral of Multiplier16Bit is
    signal temp_result : std_logic_vector(16 downto 0);    -- Internal signal for result
begin

    process(clk, reset)
    begin
        if reset = '1' then
            temp_result <= (others => '0'); -- Reset output to 0
            output_data <= (others => '0');
        elsif rising_edge(clk) then
            temp_result <= ('0' & input_data) sll 1; -- Concatenate '0' and shift left by 1
            output_data <= temp_result;
        end if;
    end process;

end Behavioral;
