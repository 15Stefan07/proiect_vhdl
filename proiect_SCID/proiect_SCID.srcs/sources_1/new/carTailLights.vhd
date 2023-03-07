----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/25/2022 11:05:42 PM
-- Design Name: 
-- Module Name: carTailLights - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity carTailLights is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           switch : in STD_LOGIC_VECTOR (2 downto 0);
           led0, led1, led2, led3, led4, led11, led12 ,led13, led14, led15 : out std_logic);
           
end carTailLights;

architecture Behavioral of carTailLights is

type states is (idle, leftLed0 ,leftLed1, leftLed2, leftLed3, leftLed4, rightLed0 ,rightLed1, rightLed2, rightLed3, rightLed4, hazLights);
				
signal current_state, next_state : states;

signal left, right, hazard : std_logic;

signal inc1sec : std_logic;
signal en_cnt : std_logic;				

-- component deBouncer is
    -- port(   Clock : in std_logic;
            -- Reset : in std_logic;
            -- button_in : in std_logic;
            -- pulse_out : out std_logic
        -- );
-- end component deBouncer;

-- signal switch : std_logic_vector (2 downto 0);

-- signal signalLightChangeLeft : std_logic := '0';
-- signal signalLightChangeRight : std_logic := '0';

begin


-- db2 : deBouncer port map (Clock => clk,
                          -- Reset => rst,
                          -- button_in => btn(2),
                          -- pulse_out => btn_db (2));

-- db1 : deBouncer port map (Clock => clk,
                          -- Reset => rst,
                          -- button_in => btn(1),
                          -- pulse_out => btn_db (1));

-- db0 : deBouncer port map (Clock => clk,
                          -- Reset => rst,
                          -- button_in => btn(0),
                          -- pulse_out => btn_db (0));                          

--btn_db <= btn;

left <= switch(2);
hazard <= switch(1);
right <= switch(0);

-- timer
process(clk, rst)
variable q : integer := 0;
begin
  if rst = '1' then
    q := 0;
    inc1sec <= '0';
  elsif rising_edge(clk) then
--     if en_cnt = '1' then   
--      if q = 10 - 1 then
        if q = 10**7 + 5*(10**6) - 1 then --
--        if q = 10 then
        q := 1;
        inc1sec <= '1';
      else
        q := q + 1;
        inc1sec <= '0';
      end if;
--    end if;        
  end if;  
end process;


-- CLS
process(clk, rst)
begin
  if rst = '1' then
    current_state <= idle;
  elsif rising_edge(clk) then
    current_state <= next_state;
  end if;    
end process;

-- clc


process(current_state, inc1sec, left, right, hazard)
begin
	case current_state is
		when idle 	=>   
											if hazard = '1' then
													if inc1sec = '1' then 
														next_state <= hazLights;
													else
														next_state <= idle;
													end if;
											elsif (left = '1' and right = '1') and hazard = '0' then
											        if inc1sec = '1' then 
														next_state <= hazLights;
													else
														next_state <= idle;
													end if;
											elsif left= '1' and right = '0' and hazard = '0' then
													next_state <= leftLed0;
											elsif right = '1' and left = '0' and hazard = '0' then
													next_state <= rightLed0;		
											elsif left = '0' and right = '0' and hazard = '0' then
										            next_state <= idle;		
											end if;
							
                        
		when leftLed0 => 	                if hazard = '1' then		                   
													next_state <= idle;							
											elsif right = '1' then                            
													next_state <= hazLights;                         										
											elsif left = '0' then		                    
													next_state <= idle;							
											elsif left = '1' then
                                                if inc1sec = '1' then 
                                                    next_state <= leftLed1;
                                                else
                                                    next_state <= leftLed0;
                                                end if;
                                            end if;
						
		when leftLed1 =>              if hazard = '1' then		                   
													next_state <= idle;							
										elsif right = '1' then                            
												next_state <= hazLights;                         										
										elsif left = '0' then		                    
												next_state <= idle;							
										elsif left = '1' then
													if inc1sec = '1' then 
														next_state <= leftLed2;
													else
														next_state <= leftLed1;
													end if;
										end if;
						
		when leftLed2 => 	                if hazard = '1' then		                   
													next_state <= idle;							
											elsif right = '1' then                            
													next_state <= hazLights;                         										
											elsif left = '0' then		                    
													next_state <= idle;							
											elsif left = '1' then
														if inc1sec = '1' then 
															next_state <= leftLed3;
														else
															next_state <= leftLed2;
														end if;
											end if;
											
		when leftLed3 => 	if hazard = '1' then		                   
													next_state <= idle;							
											elsif right = '1' then                            
													next_state <= hazLights;                         										
											elsif left = '0' then		                    
													next_state <= idle;							
											elsif left = '1' then
														if inc1sec = '1' then 
															next_state <= leftLed4;
														else
															next_state <= leftLed3;
														end if;
											end if;
		
		when leftLed4 => 	if hazard = '1' then		                   
													next_state <= idle;							
											elsif right = '1' then                            
													next_state <= hazLights;                         										
											elsif left = '0' then		                    
													next_state <= idle;							
											elsif left = '1' then
														if inc1sec = '1' then 
															next_state <= idle;
														else
															next_state <= leftLed4;
														end if;
											end if;	
			
			
		when rightLed0 => if hazard = '1' then
													next_state <= idle;
                      elsif left= '1' then
													next_state <= hazLights;
											elsif right ='0' then
													next_state <= idle;
											elsif right = '1' then
													if inc1sec = '1' then    
															next_state <= rightLed1;
													else	
															next_state <= rightLed0;
													end if;
											end if;
											
		when rightLed1 => if hazard = '1' then
													next_state <= idle;
                      elsif left= '1' then
													next_state <= hazLights;
											elsif right ='0' then
													next_state <= idle;
											elsif right = '1' then
													if inc1sec = '1' then    
															next_state <= rightLed2;
													else	
															next_state <= rightLed1;
													end if;
											end if;
											
										
		when rightLed2 =>   if hazard = '1' then
													next_state <= idle;
                      elsif left= '1' then
													next_state <= hazLights;
											elsif right ='0' then
													next_state <= idle;
											elsif right = '1' then
													if inc1sec = '1' then    
															next_state <= rightLed3;
													else	
															next_state <= rightLed2;
													end if;
											end if;
		
		when rightLed3 =>   if hazard = '1' then
															next_state <= idle;
													elsif left= '1' then
															next_state <= hazLights;
													elsif right ='0' then
															next_state <= idle;
													elsif right = '1' then
															if inc1sec = '1' then    
																	next_state <= rightLed4;
															else	
																	next_state <= rightLed3;
															end if;
													end if;		
													
		when rightLed4 =>   if hazard = '1' then
                                    next_state <= idle;
                            elsif left= '1' then
                                    next_state <= hazLights;
                            elsif right ='0' then
                                    next_state <= idle;
                            elsif right = '1' then
                                    if inc1sec = '1' then    
                                            next_state <= idle;
                                    else	
                                            next_state <= rightLed4;
                                    end if;
                            end if;		
															
											
		when hazLights =>	if hazard = '0' and left = '0' and right = '0' then
		                       next_state <= idle;
		                    elsif hazard = '1' then 
                                if inc1sec = '1' then
                                    next_state <= idle;
                                else
                                    next_state <= hazLights;
                                end if;
                            elsif hazard = '0' and (left = '1' and right = '1') then
                                if inc1sec = '1' then
                                    next_state <= idle;
                                else
                                    next_state <= hazLights;
                                end if;
                            elsif hazard = '0' and left = '1' and right = '0' then
                                next_state <= leftLed0;
                            elsif hazard = '0' and left = '0' and right = '1' then 
                                next_state <= rightLed0;
                            end if;
											
		when others => next_state <= idle;
	end case;
end process;


-- left led
process(clk)
begin
-- if rst = '1' then
    -- led0 <= '0';
    -- led1 <= '0';
    -- led2 <= '0';
		-- led3 <= '0';
		-- led4 <= '0';
		-- --
		-- led11 <= '0';
		-- led12 <= '0';
    -- led13 <= '0';
    -- led14 <= '0';
    -- led15 <= '0';
if rising_edge(clk) then
	
	if current_state = idle then
	  led0 <= '0';
    led1 <= '0';
    led2 <= '0';
		led3 <= '0';
		led4 <= '0';
		--
		led11 <= '0';
		led12 <= '0';
    led13 <= '0';
    led14 <= '0';
    led15 <= '0';
	 end if;
	
	--left leds	
	if current_state = leftLed0 or current_state = leftLed1 or current_state = leftLed2 or current_state = leftLed3 or current_state = leftLed4 or current_state = hazLights then
		led15 <= '1';
	else
		led15 <= '0';
	end if;
	
	if current_state = leftLed1 or current_state = leftLed2 or current_state = leftLed3 or current_state = leftLed4 or current_state = hazLights then
		led14 <= '1';
	else
		led14 <= '0';
	end if;
	
	if current_state = leftLed2 or current_state = leftLed3 or current_state = leftLed4 or current_state = hazLights then
		led13 <= '1';
	else
		led13 <= '0';
	end if;
	
	if current_state = leftLed3 or current_state = leftLed4 or current_state = hazLights then
		led12 <= '1';
	else
		led12 <= '0';
	end if;
	
	if current_state = leftLed4 or current_state = hazLights then
		led11 <= '1';
	else
		led11 <= '0';
	end if;
	
	
	
	--right leds
	if current_state = rightLed0 or current_state = rightLed1 or current_state = rightLed2 or current_state = rightLed3 or current_state = rightLed4 or current_state = hazLights then
		led0 <= '1';
	else
		led0 <= '0';
	end if;
	
	if current_state = rightLed1 or current_state = rightLed2 or current_state = rightLed3 or current_state = rightLed4 or current_state = hazLights then
		led1 <= '1';
	else
		led1 <= '0';
	end if;
	
	if current_state = rightLed2 or current_state = rightLed3 or current_state = rightLed4 or current_state = hazLights then
		led2 <= '1';
	else
		led2 <= '0';
	end if;
	
	if current_state = rightLed3 or current_state = rightLed4 or current_state = hazLights then
		led3 <= '1';
	else
		led3 <= '0';
	end if;
	
	if current_state = rightLed4 or current_state = hazLights then
		led4 <= '1';
	else
		led4 <= '0';
	end if;	
end if;	
end process;



-- -- en_cnt
--process(clk)
--begin
--	if current_state = leftLed0 or current_state = leftLed1 or current_state = leftLed0 then
--		en_cnt <= '1';
--	elsif	current_state = rightLed0 or current_state = rightLed1 or current_state = rightLed2 then
--		en_cnt <= '1';
--	elsif current_state = hazIdle or current_state = hazLights then
--		en_cnt <= '1';
--	elsif (current_state = idle and signalLightChangeLeft = '1') or (current_state = idle and signalLightChangeRight = '1') then
--		en_cnt <= '1';
--	else
--		en_cnt <= '0';
--	end if;

--end process;		
		
end Behavioral;
