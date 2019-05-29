----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.03.2018 17:52:01
-- Design Name: 
-- Module Name: PetirocAnalogMonitor - Behavioral
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

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

Library xpm;
use xpm.vcomponents.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PetirocAnalogMonitor is
    Generic (CLKDIV : integer := 10);
    Port (  clk : in STD_LOGIC;
            A_trigger_logic : in STD_LOGIC;
            chrage_srin_a : out STD_LOGIC;
            chrage_clk_a : out STD_LOGIC;
            raz_signal : out STD_LOGIC;
            enable : in STD_LOGIC
    );
end PetirocAnalogMonitor;

architecture Behavioral of PetirocAnalogMonitor is
    signal RazCounter : integer range 0 to 16 := 0;
    signal iEnable : std_logic;
    signal iAnalogOnly : std_logic;
begin

xpm_cdc_single_inst: xpm_cdc_single
  generic map (
     DEST_SYNC_FF   => 4, -- integer; range: 2-10
     INIT_SYNC_FF   => 0, -- integer; 0=disable simulation init values, 1=enable simulation init values
     SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
     SRC_INPUT_REG  => 0  -- integer; 0=do not register input, 1=register input
  )
  port map (
     src_clk  => '1',  -- optional; required when SRC_INPUT_REG = 1
     src_in   => enable,
     dest_clk => clk,
     dest_out => iEnable
  );
  
 ANALOG_READOUT : block
        signal BLKSM : std_logic_vector (3 downto 0) := x"0";
        signal iA_trigger_logic : std_logic;
        signal oA_trigger_logic : std_logic;
        signal counter : integer;
        signal bitcounter : integer;
    begin
        ANALOG_SM : process(clk)
        begin
            if rising_edge(clk) then
                if RazCounter= 0 then
                    raz_signal <= '0';
                else
                    raz_signal <= '1';
                    RazCounter <= RazCounter -1;
                end if;
                iA_trigger_logic <= A_trigger_logic;
                oA_trigger_logic <= iA_trigger_logic;
                case BLKSM is
                    when x"0" =>
                        if iA_trigger_logic = '0' and oA_trigger_logic = '1' and iEnable='1'  then
                            BLKSM <= x"1";
                            chrage_srin_a <= '1';
                            chrage_clk_a  <= '0';
                            counter <= CLKDIV;
                            bitcounter <= 35;
                        end if;
                    when x"1" =>
                        if counter = 0 then
                            chrage_clk_a <= '1';
                            counter <= CLKDIV;
                            BLKSM <= x"2";
                        else
                            counter <= counter -1;
                        end if; 
                    when x"2" =>
                        if counter = 0 then
                            chrage_clk_a <= '0';
                            counter <= CLKDIV;
                            BLKSM <= x"3";
                        else
                            counter <= counter -1;
                        end if; 
                    
                    when x"3" =>
                        chrage_srin_a <= '0';
                        if bitcounter = 0 then
                            BLKSM <= x"0";
                            RazCounter <= 5;
                        else
                            BLKSM <= x"1";
                            bitcounter <= bitcounter -1;
                        end if;
                        
                    when others =>
                        BLKSM <= x"0";
              end case;
            end if;
        end process;
    end block;
end Behavioral;
