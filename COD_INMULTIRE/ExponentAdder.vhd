library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ExponentAdder is
    Port (
        exponent_x : in STD_LOGIC_VECTOR(7 downto 0);
        exponent_y : in STD_LOGIC_VECTOR(7 downto 0);
        bias : in STD_LOGIC_VECTOR(7 downto 0);
        sum_exponent : out STD_LOGIC_VECTOR(7 downto 0)
    );
end ExponentAdder;

architecture rtl of ExponentAdder is
    component FullAdder8
        Port (
            A : in STD_LOGIC_VECTOR(7 downto 0);
            B : in STD_LOGIC_VECTOR(7 downto 0);
            Cin : in STD_LOGIC;
            Sum : out STD_LOGIC_VECTOR(7 downto 0);
            Cout : out STD_LOGIC
        );
    end component;
    
    signal temp_sum1 : STD_LOGIC_VECTOR(7 downto 0);
    signal temp_sum2 : STD_LOGIC_VECTOR(7 downto 0);
    signal carry_out1, carry_out2 : STD_LOGIC;
    signal not_bias : std_logic_vector(7 downto 0);
begin

    ADDER1: FullAdder8
        port map (
            A => exponent_x,
            B => exponent_y,
            Cin => '0',
            Sum => temp_sum1,
            Cout => carry_out1
        );

    not_bias<=NOT bias;
    
    ADDER2: FullAdder8
        port map (
            A => temp_sum1,
            B => not_bias,
            Cin => '1',
            Sum => temp_sum2,
            Cout => carry_out2
        );

    sum_exponent <= temp_sum2;

end rtl;
