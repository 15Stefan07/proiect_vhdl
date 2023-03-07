----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/25/2022 11:07:27 PM
-- Design Name: 
-- Module Name: simCarTailLights - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity simCarTailLights is
--  Port ( );
end simCarTailLights;

architecture Behavioral of simCarTailLights is
component carTailLights is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           switch : in STD_LOGIC_VECTOR (2 downto 0);
           led0, led1, led2, led3, led4, led11, led12 ,led13, led14, led15 : out std_logic);
          
end component carTailLights;

signal clk : std_logic;
signal rst : std_logic;
signal switch : std_logic_vector(2 downto 0);
signal led0, led1, led2, led13, led14, led15 : std_logic;

begin

process
begin
clk <= '0'; wait for 5 ns; clk <= '1'; wait for 5 ns;
end process;

rst <= '1' after 0 ns, '0' after  10 ns;

--left signal test                                                                            .from right to left signal change test        .trying to change state from hazard => left
--btn(0) <= '0' after 0 ns , '1' after 20 ns, '0' after 30 ns, '1' after 40 ms, '0' after 42 ms, '1' after 90 ms , '0' after 92 ms, '1' after 280 ms, '0' after 282 ms;
switch(0) <= '0' after 0 ns , '1' after 200 ns, '0' after 300 ns;
--switch(2) <= '0' after 0 ns , '1' after 44 ms, '0' after 55000 us; 

--right signal test
--btn(2) <= '0' after 50 ms , '1' after 56 ms, '0' after 58 ms, '1' after 90 ms, '0' after 92 ms;       
--btn(2) <= '0' after 0 ms , '1' after 56 ms, '0' after 58 ms, '1' after 150 ms, '0' after 152 ms, '1' after 210 ms, '0' after 212 ms, '1' after 290 ms, '0' after 292 ms;
switch(2) <= '0' after 0 ns , '1' after 150 ns, '0' after 250 ns;


--hazard lights test
--switch(0) <= '0' after 0 ns;
--switch(2) <= '0' after 0 ns; 
--switch(1) <= '0' after 0 ms, '1' after 50 ns, '0' after 150 ns;
--switch(1) <= '0' after 0 ms, '1' after 50 ns, '0' after 150 ns, '1' after 250 ns, '0' after 350 ns; --apasarea butonului trb sa dureze minim 2 ms (> 1ms)


--process
--begin
--clk <= '0'; wait for 0.5 ms;
--clk <= '1'; wait for 0.5 ms;
--end process;

--rst <= '1' after 0 ms, '0' after  4 ms;

----left signal test                                                                            .from right to left signal change test        .trying to change state from hazard => left
--btn(0) <= '0' after 0 ms , '1' after 6 ms, '0' after 8 ms, '1' after 40 ms, '0' after 42 ms, '1' after 90 ms , '0' after 92 ms, '1' after 280 ms, '0' after 282 ms;
----btn(0) <= '0' after 0 ms , '1' after 6 ms, '0' after 8 ms;

----right signal test
----btn(2) <= '0' after 50 ms , '1' after 56 ms, '0' after 58 ms, '1' after 90 ms, '0' after 92 ms;       
--btn(2) <= '0' after 0 ms , '1' after 56 ms, '0' after 58 ms, '1' after 150 ms, '0' after 152 ms, '1' after 210 ms, '0' after 212 ms, '1' after 290 ms, '0' after 292 ms;

----hazard lights test
--btn(1) <= '0' after 0 ms, '1' after 250 ms, '0' after 252 ms, '1' after 450 ms, '0' after 452 ms; --apasarea butonului trb sa dureze minim 2 ms (> 1ms)



UUT: carTailLights port map(    clk => clk,
                                rst => rst, 
                                switch => switch,
                                led0 => led0,
                                led1 => led1,
                                led2 => led2,
                                led13 => led13,
                                led14 => led14,
                                led15 => led15    );
                                
                                
                                

end Behavioral;

