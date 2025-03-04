library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity FullAdder8 is
    Port (
        A : in STD_LOGIC_VECTOR(7 downto 0);
        B : in STD_LOGIC_VECTOR(7 downto 0);
        Cin : in STD_LOGIC; -- Carry de intrare
        Sum : out STD_LOGIC_VECTOR(7 downto 0);
        Cout : out STD_LOGIC -- Carry de iesire
    );
end FullAdder8;

architecture Behavioral of FullAdder8 is
    signal carry : STD_LOGIC_VECTOR(8 downto 0); -- Carry intern
begin
    carry(0) <= Cin; 
    
    GEN_SUM: for i in 0 to 7 generate
        Sum(i) <= A(i) XOR B(i) XOR carry(i);
        carry(i+1) <= (A(i) AND B(i)) OR (carry(i) AND (A(i) XOR B(i)));
    end generate;
    
    Cout <= carry(8);
end Behavioral;
