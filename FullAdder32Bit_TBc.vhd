library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity FullAdder32Bit_TBc is
end FullAdder32Bit_TBc;

architecture Behavioral of FullAdder32Bit_TBc is
    -- Deklarasi sinyal
    signal A, B : STD_LOGIC_VECTOR(31 downto 0);
    signal CIN : STD_LOGIC := '0';
    signal SUM : STD_LOGIC_VECTOR(31 downto 0);
    signal COUT : STD_LOGIC;
    signal CLK : STD_LOGIC := '0'; -- Clock

    -- Parameter clock period
    constant CLK_PERIOD : time := 10 ns;

begin
    -- Instansiasi Unit Under Test (UUT)
    UUT: entity work.FullAdder32Bit
        Port map (
            A => A,
            B => B,
            CIN => CIN,
            SUM => SUM,
            COUT => COUT
        );

    -- Proses Clock
    ClockProcess : process
    begin
        while True loop
            CLK <= '1';
            wait for CLK_PERIOD / 2;
            CLK <= '0';
            wait for CLK_PERIOD / 2;
        end loop;
    end process;

    -- Proses untuk menghasilkan berbagai kombinasi input
    StimulusProcess : process
    begin
        -- Inisialisasi input
        A <= (others => '0');
        B <= (others => '0');
        CIN <= '0';
        wait for CLK_PERIOD;

        -- Uji berbagai kombinasi input
        A <= X"00000001"; B <= X"00000001"; CIN <= '0';
        wait for CLK_PERIOD;

        A <= X"FFFFFFFF"; B <= X"00000001"; CIN <= '0';
        wait for CLK_PERIOD;

        A <= X"12345678"; B <= X"87654321"; CIN <= '1';
        wait for CLK_PERIOD;

        A <= X"AAAAAAAA"; B <= X"55555555"; CIN <= '0';
        wait for CLK_PERIOD;

        A <= X"0000FFFF"; B <= X"FFFF0000"; CIN <= '1';
        wait for CLK_PERIOD;

        -- Tambahkan kombinasi input lainnya sesuai kebutuhan

        -- Berhenti setelah selesai
        wait;
    end process;

end Behavioral;
