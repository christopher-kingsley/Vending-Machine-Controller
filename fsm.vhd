library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity fsm is
port(clk, rst, n, d, q, gum, candy, soda, ref: in std_logic;
T: out std_logic_vector(2 downto 0);
ref_amount: out std_logic_vector(1 downto 0);
ne, gumout, candyout, sodaout, nickel_back: out std_logic);
end entity;
architecture beh of fsm is
type states is (zero, five, ten, fifteen, twenty, twentyfive, thirty, R15, R10, R5);
signal ns, cs : states;
begin
process(clk, rst)
begin
if (rst='0') then
cs <= zero;
elsif (clk'event and clk = '1') then
cs <= ns;
end if;
end process;
process(n, d, q, gum, candy, cs, ref)
begin
case cs is
when zero =>
nickel_back<='0';
Ref_amount<="00";


T<="000";
gumout <= '0';
candyout <= '0';
sodaout <= '0';
ne <= '0';
if ((gum = '1') or (candy = '1') or (soda = '1')) then
ne <= '1';
ns <= zero;
elsif (q = '1') then
ns <= twentyfive;
elsif (d = '1') then
ns <= ten;
elsif (n = '1') then
ns <= five;
else
ns <= zero;
end if;
when five =>
T<="001";
gumout <= '0';
candyout <= '0';
sodaout <= '0';
ne <= '0';
if ((gum = '1') or (candy = '1') or (soda = '1')) then
ne <= '1';
ns <= five;
elsif (q = '1') then
ns <= thirty;
elsif (d = '1') then
ns <= fifteen;
elsif (n = '1') then
ns <= ten;
else
ns <= five;
end if;
when ten =>
T<="010";
gumout <= '0';
candyout <= '0';
sodaout <= '0';
ne <= '0';
if ((gum = '1') or (candy = '1') or (soda = '1')) then
ne <= '1';
ns <= ten;
elsif (q = '1') then
ns <= thirty;
elsif (d = '1') then
ns <= twenty;
elsif (n = '1') then
ns <= fifteen;
else
ns <= ten;

end if;
when fifteen =>
T<="011";
gumout <= '0';
candyout <= '0';
sodaout <= '0';
ne <= '0';
if ((candy = '1') or (soda = '1')) then
ne <= '1';
ns <= fifteen;
elsif (gum = '1') then
gumout <= '1';
ns <= zero;
elsif (q = '1') then
ns <= thirty;
elsif (d = '1') then
ns <= twentyfive;
elsif (n = '1') then
ns <= twenty;
else
ns <= fifteen;
end if;
when twenty =>
T<="100";
gumout <= '0';
candyout <= '0';
sodaout <= '0';
ne <= '0';
if ((candy = '1') or (soda = '1')) then
ne <= '1';
ns <= fifteen;
elsif (gum = '1') then
gumout <= '1';
ns <= R5;
elsif (q = '1') then
ns <= thirty;
elsif (d = '1') then
ns <= thirty;
elsif (n = '1') then
ns <= twentyfive;
else
ns <= twenty;
end if;
when twentyfive =>
T<="101";
gumout <= '0';
candyout <= '0';
sodaout <= '0';
ne <= '0';

if (soda = '1') then
ne <= '1';
ns <= twentyfive;
elsif (candy = '1') then
candyout <= '1';
ns <= zero;
elsif (gum = '1') then
gumout <= '1';
ns <= R10;
elsif (q = '1') then
ns <= thirty;
elsif (d = '1') then
ns <= thirty;
elsif (n = '1') then
ns <= thirty;
else
ns <= twentyfive;
end if;
when thirty =>
T<="110";
gumout <= '0';
candyout <= '0';
sodaout <= '0';
ne <= '0';
if (soda = '1') then
sodaout <= '1';
ns <= zero;
elsif (candy = '1') then
candyout <= '1';
ns <= R5;
elsif (gum = '1') then
gumout <= '1';
ns <= R15;
elsif (q = '1') then
ns <= thirty;
elsif (d = '1') then
ns <= thirty;
elsif (n = '1') then
ns <= thirty;
else
ns <= thirty;
end if;
when R5 =>
ref_amount<="01";
if ref ='0' then
nickel_back<='1';
NS<=zero;
else
NS<= R5;
end if;

when R10 =>
ref_amount<="10";
if ref ='0' then
nickel_back<='1';
NS<=zero;
else
NS<= R10;
end if;
when R15 =>
ref_amount<="11";
if ref ='0' then
nickel_back<='1';
NS<=zero;
else
NS<= R15;
end if;
end case;
end process;
end beh;