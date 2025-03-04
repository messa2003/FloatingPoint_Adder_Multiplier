library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ResultAssembler is
    Port (
        sign : in STD_LOGIC;
        exponent : in STD_LOGIC_VECTOR(7 downto 0);
        mantissa : in STD_LOGIC_VECTOR(22 downto 0);
        result : out STD_LOGIC_VECTOR(31 downto 0)
    );
end ResultAssembler;

architecture rtl of ResultAssembler is
begin
    process(sign, exponent, mantissa)
    begin
        result <= sign & exponent & mantissa;
    end process;
end rtl;
