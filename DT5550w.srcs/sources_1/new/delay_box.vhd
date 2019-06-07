----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.06.2019 17:23:38
-- Design Name: 
-- Module Name: delay_box - Behavioral
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


Library xpm;
use xpm.vcomponents.all;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity delay_box is
    Port ( 
           clk : in STD_LOGIC;
           input_signal : in STD_LOGIC;
           output_signal : out STD_LOGIC;
           delay_value : in STD_LOGIC_VECTOR (15 downto 0));
end delay_box;

architecture Behavioral of delay_box is
    
    signal ioutput_signal : std_logic;
    signal isig : std_logic;
    signal osig : std_logic;
    signal psig : std_logic;
    signal csig : std_logic_vector(3 downto 0) := x"0";
    signal dsig : std_logic_vector(11 downto 0) := (others => '0');
    signal idelay_value :  STD_LOGIC_VECTOR (15 downto 0);
begin
  
  

CDC_delay: xpm_cdc_array_single
  generic map (

    -- Common module generics
    DEST_SYNC_FF   => 4, -- integer; range: 2-10
    INIT_SYNC_FF   => 0, -- integer; 0=disable simulation init values, 1=enable simulation init values
    SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
    SRC_INPUT_REG  => 0, -- integer; 0=do not register input, 1=register input
    WIDTH          => 16  -- integer; range: 1-1024

  )
  port map (

    src_clk  => '1',  -- optional; required when SRC_INPUT_REG = 1
    src_in   => delay_value,
    dest_clk => clk,
    dest_out => idelay_value
  );

    
    output_signal <= input_signal when delay_value = x"0000" else psig;
    
    delay_process : process (clk)
    begin
        if rising_edge(clk) then
           isig <= input_signal;
           osig <= isig;
           
           
           if csig = x"0" then
              psig <= '0';
           else
              psig <= '1';
              csig <= csig -1;
           end if; 
           
           if dsig = x"000" then
           
           else
                if dsig = x"001" then
                    csig <= x"4";               
                end if;
                
                dsig <= dsig -1;
           end if;
           
           
           
           if isig = '1' and osig = '0' then
            if delay_value = x"0001" then
                csig <= x"4";
            else
                dsig <= delay_value(11 downto 0)+1;
            end if;
            
           end if;
           

          
        end if;
    end process;


end Behavioral;
