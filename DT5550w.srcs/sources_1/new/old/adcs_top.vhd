----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.12.2016 19:06:35
-- Design Name: 
-- Module Name: adcs_top - Behavioral
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


Library UNISIM;
use UNISIM.vcomponents.all;

entity adcs_top is
    Port (  
          sCLK_100 : in std_logic;
          
          SMADC_1_RESET : out STD_LOGIC;
          
          ADC_1_CLK_A_P : in STD_LOGIC;
          ADC_1_CLK_A_N : in STD_LOGIC;
          
          ADC_1_FRAME_A_P : in STD_LOGIC;
          ADC_1_FRAME_A_N : in STD_LOGIC;
          
          ADC_1_DATA_A_P: in STD_LOGIC_VECTOR(7 downto 0);
          ADC_1_DATA_A_N: in STD_LOGIC_VECTOR(7 downto 0);
          
          ADC_1_DATA_B_P: in STD_LOGIC_VECTOR(7 downto 0);
          ADC_1_DATA_B_N: in STD_LOGIC_VECTOR(7 downto 0);
          
          SMADC_1_CSA : out std_logic;
          SMADC_1_CSB : out std_logic;
          SMADC_1_CLK : out std_logic;
          SMADC_1_MOSI : out std_logic;
          
          
          READOUT_CLK : in STD_LOGIC;
          
          CH0 : out std_logic_vector (15 downto 0);
          CH1 : out std_logic_vector (15 downto 0);
          CH2 : out std_logic_vector (15 downto 0);
          CH3 : out std_logic_vector (15 downto 0);                                            
          CH4 : out std_logic_vector (15 downto 0);
          CH5 : out std_logic_vector (15 downto 0);
          CH6 : out std_logic_vector (15 downto 0);
          CH7 : out std_logic_vector (15 downto 0);

          
          CHv0_7 : out STD_LOGIC;
          
          inversion : in std_logic_vector(7 downto 0)
          
          
                  
          );
end adcs_top;

architecture Behavioral of adcs_top is
    component clk_wiz_0
    port
    (  
     signal clk_out1 : out std_logic;
     signal clk_out2 : out std_logic;
     signal clk_out3 : out std_logic;
     signal clk_out4 : out std_logic;
     signal clk_out5 : out std_logic;
     signal reset : in std_logic;
     signal locked : out std_logic;
     signal clk_in1  :  in std_logic
    );
    end component;
        
    
    component adc_interface 
        Generic (ADC_A_INV : std_logic_vector(7 downto 0) := x"00";
                 ADC_B_INV : std_logic_vector(7 downto 0) := x"00";
                 ADC_CLK_INV : std_logic := '0';
                 IODELAY_GROUP_NAME : string := "ADC_DESER_group"
        );    
        Port ( clock_ref : in STD_LOGIC;
               locked_dcmref : in STD_LOGIC;
               SMADC_1_RESET : out STD_LOGIC;
               sCLK_25 : in std_logic;
               
             
               ADC_BUS_CLK_A_P : in STD_LOGIC;
               ADC_BUS_CLK_A_N : in STD_LOGIC;
               
               ADC_BUS_FRAME_A_P : in STD_LOGIC;
               ADC_BUS_FRAME_A_N : in STD_LOGIC;
               
               ADC_BUS_DATA_A_P: in STD_LOGIC_VECTOR(7 downto 0);
               ADC_BUS_DATA_A_N: in STD_LOGIC_VECTOR(7 downto 0);
               
               ADC_BUS_DATA_B_P: in STD_LOGIC_VECTOR(7 downto 0);
               ADC_BUS_DATA_B_N: in STD_LOGIC_VECTOR(7 downto 0);
               
               eDATA_OUT: out STD_LOGIC_VECTOR((14*8)-1 downto 0);
               eEMPTY : out STD_LOGIC;
               eCLK : in STD_LOGIC;
               eREAD : in STD_LOGIC;
                  
               SMADC_CSA : out std_logic;
               SMADC_CSB : out std_logic;
               SMADC_CLK : out std_logic;
               SMADC_MOSI : out std_logic
    
               );
    end component;
    
    
    
    
    signal locked_dcmref : std_logic := '0';
    signal clock_ref : std_logic;       
    
    signal clock_ref1 : std_logic; 
    signal clock_ref2 : std_logic; 
    signal clock_ref3 : std_logic; 
    signal clock_ref4 : std_logic;                  
    signal clk25 : std_logic;
    
    signal ADC_CS : std_logic;
    
   
    
    SIGNAL  eDATA_OUT1 : STD_LOGIC_VECTOR((14*8)-1 downto 0);
    SIGNAL  eEMPTY1    : STD_LOGIC := '0';
    SIGNAL  eREAD1     : STD_LOGIC := '0';
    
    SIGNAL  eDATA_OUT2 : STD_LOGIC_VECTOR((14*8)-1 downto 0);
    SIGNAL  eEMPTY2    : STD_LOGIC := '0';
    SIGNAL  eREAD2     : STD_LOGIC := '0';   
    
    SIGNAL  eDATA_OUT3 : STD_LOGIC_VECTOR((14*8)-1 downto 0);
    SIGNAL  eEMPTY3    : STD_LOGIC := '0';
    SIGNAL  eREAD3     : STD_LOGIC := '0';   
    
    SIGNAL  eDATA_OUT4 : STD_LOGIC_VECTOR((14*8)-1 downto 0);
    SIGNAL  eEMPTY4    : STD_LOGIC := '0';
    SIGNAL  eREAD4     : STD_LOGIC := '0';          
    
             
    attribute keep : string; 
    
    
    attribute keep of eEMPTY1: signal is "true";   
    
    
    signal iCH0 :  std_logic_vector (15 downto 0);
    signal iCH1 :  std_logic_vector (15 downto 0);
    signal iCH2 :  std_logic_vector (15 downto 0);
    signal iCH3 :  std_logic_vector (15 downto 0);                                            
    signal iCH4 :  std_logic_vector (15 downto 0);
    signal iCH5 :  std_logic_vector (15 downto 0);
    signal iCH6 :  std_logic_vector (15 downto 0);
    signal iCH7 :  std_logic_vector (15 downto 0);  
begin


   dcm_ref: clk_wiz_0
port map
 (
   clk_out1 => clock_ref1,
   clk_out2 => clock_ref2,
   clk_out3 => clk25,
   clk_out4 => clock_ref3,
   clk_out5 => clock_ref4,
   reset => '0',
   locked =>locked_dcmref ,
   clk_in1  => sCLK_100
 );
 
 

SMADC_1_CSA <= ADC_CS;

SMADC_1_CSB <= ADC_CS;
    
adc_interface1:  adc_interface 
generic map(
    ADC_A_INV => "11111010",
    ADC_B_INV => "11101110",
    ADC_CLK_INV => '0',
    IODELAY_GROUP_NAME =>  "ADC_DESER_group1"
)
port map
( clock_ref => clock_ref1,
  locked_dcmref => locked_dcmref,
  SMADC_1_RESET => SMADC_1_RESET,
  sCLK_25 => clk25,
  
  ADC_BUS_CLK_A_P => ADC_1_CLK_A_P,
  ADC_BUS_CLK_A_N => ADC_1_CLK_A_N,
  
  ADC_BUS_FRAME_A_P => ADC_1_FRAME_A_P,
  ADC_BUS_FRAME_A_N => ADC_1_FRAME_A_N,
  
  ADC_BUS_DATA_A_P => ADC_1_DATA_A_P,
  ADC_BUS_DATA_A_N => ADC_1_DATA_A_N,
                          
  ADC_BUS_DATA_B_P => ADC_1_DATA_B_P,
  ADC_BUS_DATA_B_N => ADC_1_DATA_B_N,
  
  eDATA_OUT => eDATA_OUT1,
  eEMPTY => eEMPTY1, 
  eCLK =>  READOUT_CLK, 
  eREAD => eREAD1,
    
  SMADC_CSA => ADC_CS,
  SMADC_CSB => open,
  SMADC_CLK => SMADC_1_CLK,
  SMADC_MOSI=> SMADC_1_MOSI

  );
  
 eREAD1 <= NOT eEMPTY1;
 
 
    
iCH0 <= "00" & eDATA_OUT1( (14*1)-1 downto	(14*(1-1)));
iCH1 <= "00" & eDATA_OUT1( (14*2)-1 downto	(14*(2-1)));
iCH2 <= "00" & eDATA_OUT1( (14*3)-1 downto	(14*(3-1)));
iCH3 <= "00" & eDATA_OUT1( (14*4)-1 downto	(14*(4-1)));
iCH4 <= "00" & eDATA_OUT1( (14*5)-1 downto	(14*(5-1)));
iCH5 <= "00" & eDATA_OUT1( (14*6)-1 downto	(14*(6-1)));
iCH6 <= "00" & eDATA_OUT1( (14*7)-1 downto	(14*(7-1)));
iCH7 <= "00" & eDATA_OUT1( (14*8)-1 downto	(14*(8-1)));


inv : process (READOUT_CLK)
begin
    if rising_edge(READOUT_CLK) then
        if inversion(0) = '0' then
            CH0 <= iCH0;
        else
            CH0 <= x"3FFF" - iCH0;
        end if;
        
        if inversion(1) = '0' then
            CH1 <= iCH1;
        else
            CH1 <= x"3FFF" - iCH1;
        end if;        
        
        if inversion(2) = '0' then
            CH2 <= iCH2;
        else
            CH2 <= x"3FFF" - iCH2;
        end if;        
        
        if inversion(3) = '0' then
            CH3 <= iCH3;
        else
            CH3 <= x"3FFF" - iCH3;
        end if;
        
        if inversion(4) = '0' then
            CH4 <= iCH4;
        else
            CH4 <= x"3FFF" - iCH4;
        end if;
        
        if inversion(5) = '0' then
            CH5 <= iCH5;
        else
            CH5 <= x"3FFF" - iCH5;
        end if;        
        
        if inversion(6) = '0' then
            CH6 <= iCH6;
        else
            CH6 <= x"3FFF" - iCH6;
        end if;        
        
        if inversion(7) = '0' then
            CH7 <= iCH7;
        else
            CH7 <= x"3FFF" - iCH7;
        end if;        
        
              
    end if;
end process;

end Behavioral;
