----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.09.2018 11:24:34
-- Design Name: 
-- Module Name: MultichannelRateMeter - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity MultichannelRateMeter is
    Generic(
            CHANNEL_COUNT : integer := 128;
            CLK_FREQ : integer := 160000000
            );
    Port ( clk : in STD_LOGIC;
           trigger : in STD_LOGIC_VECTOR (CHANNEL_COUNT-1 downto 0);
           reg_address : in STD_LOGIC_VECTOR (15 downto 0);
           reg_read : out STD_LOGIC_VECTOR (31 downto 0));
end MultichannelRateMeter;

architecture Behavioral of MultichannelRateMeter is
    type t_COUNTERS is array (0 to CHANNEL_COUNT-1) of std_logic_vector(31 downto 0);    
    signal RUNTIME_COUNTERS : t_COUNTERS ;
    signal STATIC_COUNTERS : t_COUNTERS ;
    signal sec_pulse : std_logic := '0';
    signal sec_counter : integer := 0;
    signal o_TRIGGER : std_logic_vector (CHANNEL_COUNT-1 downto 0);
    signal i_TRIGGER : std_logic_vector (CHANNEL_COUNT-1 downto 0);
begin

    reg_read <= STATIC_COUNTERS(conv_integer(reg_address));
    
    sec_pulse_gen : process( clk )
    begin
        if rising_edge(clk) then
            if sec_counter = CLK_FREQ then
               sec_pulse <= '1';
               sec_counter <= 0;
            else
               sec_counter <= sec_counter +1;
               sec_pulse <= '0'; 
            end if;
        end if;
    end process;

CPS_GENERATE:
   for I in 0 to CHANNEL_COUNT-1 generate
      begin
      
        cps_counters : process( clk )
          begin
              if rising_edge(clk) then
                i_TRIGGER(I) <= trigger(I);
                o_TRIGGER(I) <= i_TRIGGER(I);
                if sec_pulse = '1' then
                    STATIC_COUNTERS(I) <= RUNTIME_COUNTERS(I);
                    RUNTIME_COUNTERS(I) <= (others => '0');
                else
                    if o_TRIGGER(I) = '0' and  i_TRIGGER(I) = '1' then
                        RUNTIME_COUNTERS(I) <= RUNTIME_COUNTERS(I) +1;
                    end if;
                end if;
              end if;
          end process;
    
   end generate;
			

end Behavioral;
