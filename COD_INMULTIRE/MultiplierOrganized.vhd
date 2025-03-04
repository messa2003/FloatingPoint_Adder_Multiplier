library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MultiplierOrganized is
    Port (
        x : in STD_LOGIC_VECTOR(31 downto 0);
        y : in STD_LOGIC_VECTOR(31 downto 0);
        z : out STD_LOGIC_VECTOR(31 downto 0)
    );
end MultiplierOrganized;

architecture rtl of MultiplierOrganized is
    signal sign_x, sign_y, sign_result, is_special_case : STD_LOGIC;
    
    signal exponent_x, exponent_y, sum_exponent, normalized_exponent : STD_LOGIC_VECTOR(7 downto 0);
    signal mantissa_x, mantissa_y : STD_LOGIC_VECTOR(23 downto 0);
    
    signal product : STD_LOGIC_VECTOR(47 downto 0);
    signal product_b : STD_LOGIC_VECTOR(45 downto 0);
    
    signal normalized_mantissa : STD_LOGIC_VECTOR(22 downto 0);
    
    signal special_result : STD_LOGIC_VECTOR(31 downto 0);
    signal normal_result : STD_LOGIC_VECTOR(31 downto 0);
begin

    Extractor_x: entity work.Extractor port map(x, sign_x, exponent_x, mantissa_x);
    Extractor_y: entity work.Extractor port map(y, sign_y, exponent_y, mantissa_y);
    
    Special_case: entity work.SpecialCasesChecker port map(x,y,is_special_case,special_result);

    SignCalc: entity work.SignCalculator port map(sign_x, sign_y, sign_result);

    ExpAdder: entity work.ExponentAdder port map(exponent_x, exponent_y, "01111111", sum_exponent);

    M: entity work.M port map(mantissa_x, mantissa_y, product);
    
    Booth: entity work.MantisaMultiplier port map(mantissa_x, mantissa_y, product_b);
    
    Norm: entity work.Normalizer port map(product, sum_exponent, normalized_mantissa, normalized_exponent);

    Assembler: entity work.ResultAssembler port map(sign_result, normalized_exponent, normalized_mantissa, normal_result);
    
process (is_special_case, special_result, normal_result)
    begin
        if is_special_case = '1' then
            z <= special_result;
        else
            z <= normal_result;
        end if;
    end process;

end rtl;
