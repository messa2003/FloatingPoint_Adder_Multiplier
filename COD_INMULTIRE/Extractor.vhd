library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Extractor is
    Port (
        input : in STD_LOGIC_VECTOR(31 downto 0);
        sign : out STD_LOGIC;
        exponent : out STD_LOGIC_VECTOR(7 downto 0);
        mantissa : out STD_LOGIC_VECTOR(23 downto 0)
    );
end Extractor;

architecture rtl of Extractor is
begin
    process(input)
    begin
        sign <= input(31);                       -- Extrage semnul
        exponent <= input(30 downto 23);         -- Extrage exponentul
        mantissa <= "1" & input(22 downto 0);    -- Mantisa
    end process;
end rtl;
