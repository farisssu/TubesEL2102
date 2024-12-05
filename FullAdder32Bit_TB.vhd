library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FullAdder32Bit_TB is
end FullAdder32Bit_TB;

architecture Behavioral of FullAdder32Bit_TB is
    signal A, B : STD_LOGIC_VECTOR(31 downto 0);
    signal CIN : STD_LOGIC;
    signal SUM : STD_LOGIC_VECTOR(31 downto 0);
    signal COUT : STD_LOGIC;
begin
    UUT: entity work.FullAdder32Bit
        Port map (
            A => A,
            B => B,
            CIN => CIN,
            SUM => SUM,
            COUT => COUT
        );

    process
    begin
        -- Test case 1: Penjumlahan tanpa carry
        A <= X"0000000F"; B <= X"00000001"; CIN <= '0';
        wait for 10 ns;

        -- Test case 2: Penjumlahan dengan carry-out
        A <= X"FFFFFFFF"; B <= X"00000001"; CIN <= '0';
        wait for 10 ns;

        -- Test case 3: Penjumlahan dengan carry-in
        A <= X"0000AAAA"; B <= X"00005555"; CIN <= '1';
        wait for 10 ns;

        wait; -- Stop simulation
    end process;
end Behavioral;
