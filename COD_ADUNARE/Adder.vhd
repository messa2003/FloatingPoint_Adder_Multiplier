library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Adder is
    port(
        A_mantissa : in  std_logic_vector(24 downto 0);
        B_mantissa : in  std_logic_vector(24 downto 0);
        sum_mantissa : out std_logic_vector(24 downto 0)
    );
end Adder;

architecture Behavioral of Adder is
    -- Semnale pentru carry-out si carry-in intre addere
    signal carry : std_logic_vector(3 downto 0);
    
    -- Semnale pentru rezultatele partiale ale celor 3 addere de 8 biti
    signal sum_part0, sum_part1, sum_part2 : std_logic_vector(7 downto 0);
    
    -- Declar componenta FullAdder8
    component FullAdder8
        Port (
            A : in STD_LOGIC_VECTOR(7 downto 0);
            B : in STD_LOGIC_VECTOR(7 downto 0);
            Cin : in STD_LOGIC;
            Sum : out STD_LOGIC_VECTOR(7 downto 0);
            Cout : out STD_LOGIC
        );
    end component;
begin
    -- Initializarea carry-in
    carry(0) <= '0';
    
    -- Adder pentru primii 8 biti
    ADDER0: FullAdder8 port map(
        A    => A_mantissa(7 downto 0),
        B    => B_mantissa(7 downto 0),
        Cin  => carry(0),
        Sum  => sum_part0,
        Cout => carry(1)
    );
    
    -- Adder pentru urmatorii 8 biti
    ADDER1: FullAdder8 port map(
        A    => A_mantissa(15 downto 8),
        B    => B_mantissa(15 downto 8),
        Cin  => carry(1),
        Sum  => sum_part1,
        Cout => carry(2)
    );
    
    -- Adder pentru ultimii 8 biti
    ADDER2: FullAdder8 port map(
        A    => A_mantissa(23 downto 16),
        B    => B_mantissa(23 downto 16),
        Cin  => carry(2),
        Sum  => sum_part2,
        Cout => carry(3)
    );
    
    -- Concateneaza rezultatele partiale pentru a obtine suma completa
  
    sum_mantissa <= carry(3) & sum_part2 & sum_part1 & sum_part0; 
end Behavioral;
