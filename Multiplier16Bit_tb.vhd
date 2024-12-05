library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Multiplier16Bit_tb is
-- Testbench tidak memiliki port
end Multiplier16Bit_tb;

architecture Behavioral of Multiplier16Bit_tb is
    -- Sinyal internal untuk menghubungkan entitas utama
    signal clk   : std_logic := '0';
    signal reset : std_logic := '0';
    signal input_data  : std_logic_vector(15 downto 0) := (others => '0');
    signal output_data : std_logic_vector(16 downto 0);

    -- Komponen yang diuji
    component Multiplier16Bit
        Port (
            clk         : in  std_logic;
            reset       : in  std_logic;
            input_data  : in  std_logic_vector(15 downto 0);
            output_data : out std_logic_vector(16 downto 0)
        );
    end component;

begin
    -- Hubungkan sinyal ke entitas utama
    uut: Multiplier16Bit
        Port map (
            clk => clk,
            reset => reset,
            input_data => input_data,
            output_data => output_data
        );

    -- Clock process
    clk_process : process
    begin
        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
    end process;

    -- Stimulus process
    stimulus_process : process
    begin
        -- Reset sistem
        reset <= '1';
        wait for 20 ns;
        reset <= '0';

        -- Masukkan angka untuk diuji
        input_data <= "0000000000001010"; -- 10
        wait for 20 ns;

        input_data <= "0000000000011111"; -- 31
        wait for 20 ns;

        input_data <= "1111111111111111"; -- 65535
        wait for 20 ns;

        wait;
    end process;
end Behavioral;
