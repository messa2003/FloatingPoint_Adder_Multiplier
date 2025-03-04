library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MantisaMultiplier is
    Port (
        x : in STD_LOGIC_VECTOR (23 downto 0);
        y : in STD_LOGIC_VECTOR (23 downto 0);
        rez : out STD_LOGIC_VECTOR (45 downto 0)
    );
end MantisaMultiplier;

architecture Behavioral of MantisaMultiplier is
begin
    process(x, y)
        variable acc : std_logic_vector(48 downto 0);
        variable s, temp : std_logic_vector(23 downto 0);
    begin

        acc := (others => '0');
        s := y; -- M
        acc(24 downto 1) := x; 

        -- Algoritmul Booth
        for i in 0 to 23 loop
            if (acc(1) = '1' and acc(0) = '0') then
                -- Scadere: acc(A) - s
                temp := acc(48 downto 25);
                acc(48 downto 25) := temp - s;
            elsif (acc(1) = '0' and acc(0) = '1') then
                -- Adunare: acc(A) + s
                temp := acc(48 downto 25);
                acc(48 downto 25) := temp + s;
            end if;

            -- Shiftare aritmetica la dreapta
            acc(47 downto 0) := acc(48 downto 1);
        end loop;

        rez <= acc(46 downto 1);
    end process;
end Behavioral;
