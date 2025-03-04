library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity SpecialCaseHandler is
    Port (
        clk : in std_logic;
        nr1, nr2 : in std_logic_vector(31 downto 0); 
        SpecialCase : out std_logic;
        DisplayResult : out std_logic_vector (31 downto 0)
    );
end SpecialCaseHandler;

architecture Behavioral of SpecialCaseHandler is
begin
process(nr1, nr2)

begin
    -- Verificare NaN: daca unul dintre numere este NaN, rezultatul este NaN
    if (nr1 = "01111111100000000000000000000001" or nr2 = "01111111100000000000000000000001") then
        DisplayResult <= "01111111100000000000000000000001"; -- NaN
        SpecialCase <= '1';
    
    -- Verificare pentru 0: daca ambele sunt 0, rezultatul este 0
    elsif (nr1 = "00000000000000000000000000000000" and nr2 = "00000000000000000000000000000000") then
        DisplayResult <= "00000000000000000000000000000000";
        SpecialCase <= '1';
    
    -- Daca primul numar este 0, rezultatul este exact al doilea numar
    elsif (nr1 = "00000000000000000000000000000000") then
        DisplayResult <= nr2;
        SpecialCase <= '1';
    
    -- Daca al doilea numar este 0, rezultatul este exact primul numar
    elsif (nr2 = "00000000000000000000000000000000") then
        DisplayResult <= nr1;
        SpecialCase <= '1';
    
    -- Daca ambele sunt +INF, rezultatul este NaN (nedefinit)
    elsif (nr1 = "01111111100000000000000000000000" and nr2 = "01111111100000000000000000000000") then
        DisplayResult <= "01111111100000000000000000000001"; -- NaN
        SpecialCase <= '1';
    
    -- Daca unul dintre numere este infinit, rezultatul este infinit
    elsif (nr1 = "01111111100000000000000000000000" or nr2 = "01111111100000000000000000000000") then
        if (nr1 = "01111111100000000000000000000000") then
            DisplayResult <= nr1;
        else
            DisplayResult <= nr2;
        end if;
    
    -- Ramura asta este irelevanta, am pus-o doar ca sa nu am eroare ca nu am tratat toate cazurile
    else
        DisplayResult <= "01111111100000000000000000000001"; -- NaN
        SpecialCase <= '0';
    end if;

end process;
end Behavioral;
