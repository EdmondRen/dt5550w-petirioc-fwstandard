----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.04.2018 08:40:54
-- Design Name: 
-- Module Name: common_trigger - Behavioral
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

entity common_trigger is
    Port ( trigger_a : in STD_LOGIC;
           trigger_b : in STD_LOGIC;
           trigger_c : in STD_LOGIC;
           trigger_d : in STD_LOGIC;
           
           trigger_mode_reg : in std_logic_vector(31 downto 0);
           enable_trigger_ext_reg : in std_logic_vector(31 downto 0);
           
           self_trigger_pulse_a : in std_logic;
           self_trigger_pulse_b : in std_logic;
           self_trigger_pulse_c : in std_logic;
           self_trigger_pulse_d : in std_logic;
           
           out_extrigger_a : out STD_LOGIC;
           out_extrigger_b : out STD_LOGIC;
           out_extrigger_c : out STD_LOGIC;
           out_extrigger_d : out STD_LOGIC
                      
           );
end common_trigger;

architecture Behavioral of common_trigger is
    signal trigger_mode : std_logic_vector(3 downto 0) := x"0";
    signal cm_trigger : std_logic;
begin

 cm_trigger <=  (not trigger_a) or (not trigger_b) or (not trigger_c) or (not trigger_d)        when trigger_mode = x"0" else
                    (not trigger_a) or (not trigger_b)                                              when trigger_mode = x"1" else
                    (not trigger_c) or (not trigger_d)                                              when trigger_mode = x"2" else
                    (not trigger_a)                                                                 when trigger_mode = x"3" else
                    (not trigger_b)                                                                 when trigger_mode = x"4" else
                    (not trigger_c)                                                                 when trigger_mode = x"5" else
                    (not trigger_d)                                                                 when trigger_mode = x"6" else
                    ((not trigger_a) or (not trigger_b)) and ((not trigger_c) or (not trigger_d))   when trigger_mode = x"7" else
                    ((not trigger_a) or (not trigger_b)) and ((not trigger_c) or (not trigger_d))   when trigger_mode = x"8" else
                    (not trigger_a) and (not trigger_b)                                             when trigger_mode = x"9" else
                    (not trigger_c) and (not trigger_d)                                             when trigger_mode = x"A" else
                    (not trigger_a) and (not trigger_b) and (not trigger_c) and (not trigger_d)     when trigger_mode = x"B" else
                    (lemo1)                                                                         when trigger_mode = x"E" else
                    (global_trigger)                                                                when trigger_mode = x"F" else
                    '0';

    out_extrigger_a <= (cm_trigger and enable_trigger_ext_reg(0)) or self_trigger_pulse_a;
    out_extrigger_b <= (cm_trigger and enable_trigger_ext_reg(1)) or self_trigger_pulse_b;
    out_extrigger_c <= (cm_trigger and enable_trigger_ext_reg(2)) or self_trigger_pulse_c;
    out_extrigger_d <= (cm_trigger and enable_trigger_ext_reg(3)) or self_trigger_pulse_d;
end Behavioral;
