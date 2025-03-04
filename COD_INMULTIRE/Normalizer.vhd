library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Normalizer is
    Port (
        product : in STD_LOGIC_VECTOR(47 downto 0);
        exponent : in STD_LOGIC_VECTOR(7 downto 0);
        normalized_mantissa : out STD_LOGIC_VECTOR(22 downto 0);
        normalized_exponent : out STD_LOGIC_VECTOR(7 downto 0)
    );
end Normalizer;

architecture rtl of Normalizer is
begin
    process(product, exponent)
    begin
        if product(47) = '1' then
            normalized_mantissa <= product(46 downto 24);
            normalized_exponent <= std_logic_vector(unsigned(exponent) + 1);
        else
            normalized_mantissa <= product(45 downto 23);
            normalized_exponent <= exponent;
        end if;
    end process;
end rtl;
