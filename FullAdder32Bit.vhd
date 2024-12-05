library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FullAdder32Bit is
    Port (
        A : in STD_LOGIC_VECTOR(31 downto 0); -- Input bilangan pertama (32-bit)
        B : in STD_LOGIC_VECTOR(31 downto 0); -- Input bilangan kedua (32-bit)
        CIN : in STD_LOGIC; -- Carry-in
        SUM : out STD_LOGIC_VECTOR(31 downto 0); -- Output hasil penjumlahan (32-bit)
        COUT : out STD_LOGIC -- Carry-out
    );
end FullAdder32Bit;

architecture Behavioral of FullAdder32Bit is
    signal temp_sum : STD_LOGIC_VECTOR(32 downto 0); -- Sinyal sementara untuk penjumlahan
begin
    -- Penjumlahan dengan carry
    temp_sum <= ('0' & A) + ('0' & B) + CIN; -- Tambahkan CIN sebagai bagian carry-in
    SUM <= temp_sum(31 downto 0); -- Ambil hasil penjumlahan 32-bit
    COUT <= temp_sum(32); -- Carry-out adalah bit ke-32
end Behavioral;
