----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.05.2017 17:29:18
-- Design Name: 
-- Module Name: TestFT600f - Behavioral
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

library UNISIM;
use UNISIM.VComponents.all;

Library xpm;
use xpm.vcomponents.all;
    
entity TopDT5550w is
    Port (  
--				CLK_P		: in STD_LOGIC;
--				CLK_N		: in STD_LOGIC;
		   FTDI_CLK : in  STD_LOGIC;
           FTDI_ADBUS : inout  STD_LOGIC_VECTOR (31 downto 0);
           FTDI_BE : inout  STD_LOGIC_VECTOR (3 downto 0);
           FTDI_RXFN : in  STD_LOGIC;
           FTDI_TXEN : in  STD_LOGIC;
           FTDI_TXN : out  STD_LOGIC;
           FTDI_SIWU : out  STD_LOGIC;
           FTDI_RDN : out  STD_LOGIC;
           FTDI_OEN : out  STD_LOGIC;
           
           --CDCE clock generator
           CK_SPI_LE : out  STD_LOGIC;
           CK_SPI_CLK : out  STD_LOGIC;
           CK_SPI_MOSI : out  STD_LOGIC;
           CK_SPI_NSYNC : out  STD_LOGIC;
           
           --i2c
           iic_scl : inout std_logic;
           iic_sda : inout std_logic;

           --petiroc A slow control
           PETIROC_A_CLK : out STD_LOGIC;
           PETIROC_A_MOSI : out STD_LOGIC;
           PETIROC_A_SLOAD : out STD_LOGIC;
           PETIROC_A_RESETB : out STD_LOGIC;
           PETIROC_A_SELECT : out STD_LOGIC;           

           --petiroc B slow control
           PETIROC_B_CLK : out STD_LOGIC;
           PETIROC_B_MOSI : out STD_LOGIC;
           PETIROC_B_SLOAD : out STD_LOGIC;
           PETIROC_B_RESETB : out STD_LOGIC;
           PETIROC_B_SELECT : out STD_LOGIC;           

           --petiroc C slow control
           PETIROC_C_CLK : out STD_LOGIC;
           PETIROC_C_MOSI : out STD_LOGIC;
           PETIROC_C_SLOAD : out STD_LOGIC;
           PETIROC_C_RESETB : out STD_LOGIC;
           PETIROC_C_SELECT : out STD_LOGIC;           

           --petiroc D slow control
           PETIROC_D_CLK : out STD_LOGIC;
           PETIROC_D_MOSI : out STD_LOGIC;
           PETIROC_D_SLOAD : out STD_LOGIC;
           PETIROC_D_RESETB : out STD_LOGIC;
           PETIROC_D_SELECT : out STD_LOGIC   ;
           
           
           A_VAL_EVT_P : out STD_LOGIC;
           A_VAL_EVT_N : out STD_LOGIC;
           B_VAL_EVT_P : out STD_LOGIC;
           B_VAL_EVT_N : out STD_LOGIC;
           C_VAL_EVT_P : out STD_LOGIC;
           C_VAL_EVT_N : out STD_LOGIC;
           D_VAL_EVT_P : out STD_LOGIC;
           D_VAL_EVT_N : out STD_LOGIC;
           
           
           A_RAZ_CHN_P : out STD_LOGIC;
           A_RAZ_CHN_N : out STD_LOGIC;
           B_RAZ_CHN_P : out STD_LOGIC;
           B_RAZ_CHN_N : out STD_LOGIC;
           C_RAZ_CHN_P : out STD_LOGIC;
           C_RAZ_CHN_N : out STD_LOGIC;
           D_RAZ_CHN_P : out STD_LOGIC;
           D_RAZ_CHN_N : out STD_LOGIC;
           
           
           A_TRIG_EXT : out STD_LOGIC;
           C_TRIG_EXT : out STD_LOGIC;
           B_TRIG_EXT : out STD_LOGIC;
           D_TRIG_EXT : out STD_LOGIC;
           
           PETIROC_A_RSTB : out STD_LOGIC;
           PETIROC_B_RSTB : out STD_LOGIC;
           PETIROC_C_RSTB : out STD_LOGIC;
           PETIROC_D_RSTB : out STD_LOGIC;
           
           A_START_CONV : out STD_LOGIC;
           B_START_CONV : out STD_LOGIC;
           C_START_CONV : out STD_LOGIC;
           D_START_CONV : out STD_LOGIC;        

           A_HOLD_EXT : out STD_LOGIC;
           B_HOLD_EXT : out STD_LOGIC;
           C_HOLD_EXT : out STD_LOGIC;
           D_HOLD_EXT : out STD_LOGIC;        


           A_STARTB_ADC_EXT : out STD_LOGIC;
           B_STARTB_ADC_EXT : out STD_LOGIC;
           C_STARTB_ADC_EXT : out STD_LOGIC;
           D_STARTB_ADC_EXT : out STD_LOGIC;
           
           A_TRASMIT_ON : in STD_LOGIC;
           B_TRASMIT_ON : in STD_LOGIC;
           C_TRASMIT_ON : in STD_LOGIC;
           D_TRASMIT_ON : in STD_LOGIC;
           
           A_LVDS_DOUT_P : in STD_LOGIC;
           A_LVDS_DOUT_N : in STD_LOGIC;      
           B_LVDS_DOUT_P : in STD_LOGIC;
           B_LVDS_DOUT_N : in STD_LOGIC;                           
           C_LVDS_DOUT_P : in STD_LOGIC;
           C_LVDS_DOUT_N : in STD_LOGIC;                    
           D_LVDS_DOUT_P : in STD_LOGIC;
           D_LVDS_DOUT_N : in STD_LOGIC;
           
           D_LVDS_DCLK_P :  in STD_LOGIC;
           D_LVDS_DCLK_N :  in STD_LOGIC;

           A_TRG : in STD_LOGIC_VECTOR(31 downto 0);          
           B_TRG : in STD_LOGIC_VECTOR(31 downto 0);
           C_TRG : in STD_LOGIC_VECTOR(31 downto 0);          
           D_TRG : in STD_LOGIC_VECTOR(31 downto 0);
           
                      
           A_ANALOG_DIN : out STD_LOGIC;
           B_ANALOG_DIN : out STD_LOGIC;
           C_ANALOG_DIN : out STD_LOGIC;
           D_ANALOG_DIN : out STD_LOGIC;
           
           A_ANALOG_CLK : out STD_LOGIC;
           B_ANALOG_CLK : out STD_LOGIC;
           C_ANALOG_CLK : out STD_LOGIC;
           D_ANALOG_CLK : out STD_LOGIC;

           chrage_trig_a : in STD_LOGIC;
           chrage_trig_b : in STD_LOGIC;
           chrage_trig_c : in STD_LOGIC;
           chrage_trig_d : in STD_LOGIC;

           dig_probe_a : in STD_LOGIC;
           dig_probe_b : in STD_LOGIC;
           dig_probe_c : in STD_LOGIC;
           dig_probe_d : in STD_LOGIC;   

           trigb_mux_a : in STD_LOGIC;
           trigb_mux_b : in STD_LOGIC;
           trigb_mux_c : in STD_LOGIC;
           trigb_mux_d : in STD_LOGIC;   
           
           LEMO0 : in STD_LOGIC;
           LEMO1 : in STD_LOGIC;
           LEMO2 : in STD_LOGIC;
           LEMO3 : in STD_LOGIC;
                     
           LEMO4 : out STD_LOGIC;
           LEMO5 : out STD_LOGIC;
           LEMO6 : out STD_LOGIC;
           LEMO7 : out STD_LOGIC;
           
           LEMO01_dir : out STD_LOGIC;
           LEMO23_dir : out STD_LOGIC;
           LEMO45_dir : out STD_LOGIC;
           LEMO67_dir : out STD_LOGIC;
           
           CLK_40_P : in STD_LOGIC;
           CLK_40_N : in STD_LOGIC;
           
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
           SMADC_1_CLK : out std_logic;
           SMADC_1_MOSI : out std_logic;
           SMADC_1_PD : out std_logic;
           
           
            FLASH_SPI_CS : out std_logic;
            FLASH_SPI_DIN : in std_logic;
            FLASH_SPI_DOUT : out std_logic;
                   
           clk_100 : std_logic
                              
			  ); 
end TopDT5550w;

architecture Behavioral of TopDT5550w is

    
    component ft600_fifo245_wrapper is
    Port ( 
          FTDI_ADBUS : inout STD_LOGIC_VECTOR (31 downto 0);
          FTDI_BE     : inout STD_LOGIC_VECTOR (3 downto 0);
          FTDI_RXFN : in STD_LOGIC;            --EMPTY
          FTDI_TXEN : in STD_LOGIC;         --FULL
          FTDI_RDN    : out STD_LOGIC;        --READ ENABLE
          FTDI_TXN    : out STD_LOGIC;        --WRITE ENABLE
          FTDI_CLK    : in STD_LOGIC;            --FTDI CLOCK
          FTDI_OEN    : out STD_LOGIC;        --OUTPUT ENABLE NEGATO LATO FTDI
          FTDI_SIWU : out STD_LOGIC;        --COMMIT A PACKET IMMEDIATLY
    
          -- Register interface          
            REG_ValEvt_RD : IN STD_LOGIC_VECTOR(31 downto 0); 
            REG_ValEvt_WR : OUT STD_LOGIC_VECTOR(31 downto 0); 
            INT_ValEvt_RD : OUT STD_LOGIC_VECTOR(0 downto 0); 
            INT_ValEvt_WR : OUT STD_LOGIC_VECTOR(0 downto 0); 
    
            REG_Rstb_RD : IN STD_LOGIC_VECTOR(31 downto 0); 
            REG_Rstb_WR : OUT STD_LOGIC_VECTOR(31 downto 0); 
            INT_Rstb_RD : OUT STD_LOGIC_VECTOR(0 downto 0); 
            INT_Rstb_WR : OUT STD_LOGIC_VECTOR(0 downto 0); 
    
            REG_Startb_RD : IN STD_LOGIC_VECTOR(31 downto 0); 
            REG_Startb_WR : OUT STD_LOGIC_VECTOR(31 downto 0); 
            INT_Startb_RD : OUT STD_LOGIC_VECTOR(0 downto 0); 
            INT_Startb_WR : OUT STD_LOGIC_VECTOR(0 downto 0); 
    
            REG_Fiforeset_RD : IN STD_LOGIC_VECTOR(31 downto 0); 
            REG_Fiforeset_WR : OUT STD_LOGIC_VECTOR(31 downto 0); 
            INT_Fiforeset_RD : OUT STD_LOGIC_VECTOR(0 downto 0); 
            INT_Fiforeset_WR : OUT STD_LOGIC_VECTOR(0 downto 0); 
            
	       	REG_SelfTrigger_RD : IN STD_LOGIC_VECTOR(31 downto 0); 
            REG_SelfTrigger_WR : OUT STD_LOGIC_VECTOR(31 downto 0); 
            INT_SelfTrigger_RD : OUT STD_LOGIC_VECTOR(0 downto 0); 
            INT_SelfTrigger_WR : OUT STD_LOGIC_VECTOR(0 downto 0); 
            
            REG_SelfTriggerPeriod_RD : IN STD_LOGIC_VECTOR(31 downto 0); 
            REG_SelfTriggerPeriod_WR : OUT STD_LOGIC_VECTOR(31 downto 0); 
            INT_SelfTriggerPeriod_RD : OUT STD_LOGIC_VECTOR(0 downto 0); 
            INT_SelfTriggerPeriod_WR : OUT STD_LOGIC_VECTOR(0 downto 0); 
    
            REG_TriggerMode_RD : IN STD_LOGIC_VECTOR(31 downto 0); 
            REG_TriggerMode_WR : OUT STD_LOGIC_VECTOR(31 downto 0); 
            INT_TriggerMode_RD : OUT STD_LOGIC_VECTOR(0 downto 0); 
            INT_TriggerMode_WR : OUT STD_LOGIC_VECTOR(0 downto 0); 
            
		    REG_T0sel_RD : IN STD_LOGIC_VECTOR(31 downto 0); 
            REG_T0sel_WR : OUT STD_LOGIC_VECTOR(31 downto 0); 
            INT_T0sel_RD : OUT STD_LOGIC_VECTOR(0 downto 0); 
            INT_T0sel_WR : OUT STD_LOGIC_VECTOR(0 downto 0); 
    
            REG_T0sw_RD : IN STD_LOGIC_VECTOR(31 downto 0); 
            REG_T0sw_WR : OUT STD_LOGIC_VECTOR(31 downto 0); 
            INT_T0sw_RD : OUT STD_LOGIC_VECTOR(0 downto 0); 
            INT_T0sw_WR : OUT STD_LOGIC_VECTOR(0 downto 0); 
    
            REG_T0sw_mode_RD : IN STD_LOGIC_VECTOR(31 downto 0); 
            REG_T0sw_mode_WR : OUT STD_LOGIC_VECTOR(31 downto 0); 
            INT_T0sw_mode_RD : OUT STD_LOGIC_VECTOR(0 downto 0); 
            INT_T0sw_mode_WR : OUT STD_LOGIC_VECTOR(0 downto 0); 
    
            REG_T0sw_freq_RD : IN STD_LOGIC_VECTOR(31 downto 0); 
            REG_T0sw_freq_WR : OUT STD_LOGIC_VECTOR(31 downto 0); 
            INT_T0sw_freq_RD : OUT STD_LOGIC_VECTOR(0 downto 0); 
            INT_T0sw_freq_WR : OUT STD_LOGIC_VECTOR(0 downto 0); 
            
	    	REG_AsicDisable_RD : IN STD_LOGIC_VECTOR(31 downto 0); 
            REG_AsicDisable_WR : OUT STD_LOGIC_VECTOR(31 downto 0); 
            INT_AsicDisable_RD : OUT STD_LOGIC_VECTOR(0 downto 0); 
            INT_AsicDisable_WR : OUT STD_LOGIC_VECTOR(0 downto 0); 
                                    
	    	REG_AnalogReadout_RD : IN STD_LOGIC_VECTOR(31 downto 0); 
            REG_AnalogReadout_WR : OUT STD_LOGIC_VECTOR(31 downto 0); 
            INT_AnalogReadout_RD : OUT STD_LOGIC_VECTOR(0 downto 0); 
            INT_AnalogReadout_WR : OUT STD_LOGIC_VECTOR(0 downto 0); 
                        
                        
	        REG_TRGsel_RD : IN STD_LOGIC_VECTOR(31 downto 0); 
            REG_TRGsel_WR : OUT STD_LOGIC_VECTOR(31 downto 0); 
            INT_TRGsel_RD : OUT STD_LOGIC_VECTOR(0 downto 0); 
            INT_TRGsel_WR : OUT STD_LOGIC_VECTOR(0 downto 0); 
            
            REG_EnableCommonTrigger_RD : in std_logic_Vector(31 downto 0);
            REG_EnableCommonTrigger_WR : out std_logic_Vector(31 downto 0);
            INT_EnableCommonTrigger_RD : out STD_LOGIC_VECTOR(0 downto 0);  
            INT_EnableCommonTrigger_WR : out STD_LOGIC_VECTOR(0 downto 0);     
            
            REG_EnableExtVeto_RD : in std_logic_Vector(31 downto 0);
            REG_EnableExtVeto_WR : out std_logic_Vector(31 downto 0);
            INT_EnableExtVeto_RD : out STD_LOGIC_VECTOR(0 downto 0);  
            INT_EnableExtVeto_WR : out STD_LOGIC_VECTOR(0 downto 0);       
        
            REG_EnableExtTrigger_RD : in std_logic_Vector(31 downto 0);
            REG_EnableExtTrigger_WR : out std_logic_Vector(31 downto 0);
            INT_EnableExtTrigger_RD : out STD_LOGIC_VECTOR(0 downto 0);  
            INT_EnableExtTrigger_WR : out STD_LOGIC_VECTOR(0 downto 0); 
            
            REG_ResetTDCOnT0_RD : IN STD_LOGIC_VECTOR(31 downto 0); 
            REG_ResetTDCOnT0_WR : OUT STD_LOGIC_VECTOR(31 downto 0); 
            INT_ResetTDCOnT0_RD : OUT STD_LOGIC_VECTOR(0 downto 0); 
            INT_ResetTDCOnT0_WR : OUT STD_LOGIC_VECTOR(0 downto 0);     
            
            REG_HOLD_DELAY_CNTR_RD : IN  STD_LOGIC_VECTOR(31 downto 0); 
            REG_HOLD_DELAY_CNTR_WR : OUT STD_LOGIC_VECTOR(31 downto 0); 
            INT_HOLD_DELAY_CNTR_RD : OUT STD_LOGIC_VECTOR(0 downto 0); 
            INT_HOLD_DELAY_CNTR_WR : OUT  STD_LOGIC_VECTOR(0 downto 0);  
        
            REG_EXT_HOLD_EN_RD : IN STD_LOGIC_VECTOR(31 downto 0); 
            REG_EXT_HOLD_EN_WR : OUT STD_LOGIC_VECTOR(31 downto 0); 
            INT_REG_EXT_HOLD_EN_RD : OUT  STD_LOGIC_VECTOR(0 downto 0); 
            INT_REG_EXT_HOLD_EN_WR : OUT  STD_LOGIC_VECTOR(0 downto 0);    
                                   
          -- Fifo Interface
                    
            BUS_ImageReadout_0_READ_DATA : IN STD_LOGIC_VECTOR(31 downto 0); 
            BUS_ImageReadout_0_WRITE_DATA : OUT STD_LOGIC_VECTOR(31 downto 0); 
            BUS_ImageReadout_0_W_INT : OUT STD_LOGIC_VECTOR(0 downto 0); 
            BUS_ImageReadout_0_R_INT : OUT STD_LOGIC_VECTOR(0 downto 0); 
            BUS_ImageReadout_0_VLD : IN STD_LOGIC_VECTOR(0 downto 0); 
            REG_ImageReadout_0_READ_STATUS_RD : IN STD_LOGIC_VECTOR(31 downto 0); 
            INT_ImageReadout_0_READ_STATUS_RD : OUT STD_LOGIC_VECTOR(0 downto 0); 
            
            --oscilloscope 
	        BUS_Oscilloscope_0_READ_DATA : IN STD_LOGIC_VECTOR(31 downto 0);
            BUS_Oscilloscope_0_ADDRESS : OUT STD_LOGIC_VECTOR(15 downto 0); 
            BUS_Oscilloscope_0_WRITE_DATA : OUT STD_LOGIC_VECTOR(31 downto 0); 
            BUS_Oscilloscope_0_W_INT : OUT STD_LOGIC_VECTOR(0 downto 0); 
            BUS_Oscilloscope_0_R_INT : OUT STD_LOGIC_VECTOR(0 downto 0); 
            BUS_Oscilloscope_0_VLD : IN STD_LOGIC_VECTOR(0 downto 0);              
             
        -- BUS Interface
    
            BUS_PROCCFG_0_READ_ADDRESS : OUT STD_LOGIC_VECTOR(15 downto 0);  
            BUS_PROCCFG_0_WRITE_DATA : OUT STD_LOGIC_VECTOR(31 downto 0); 
            BUS_PROCCFG_0_W_INT : OUT STD_LOGIC_VECTOR(0 downto 0); 
        
            BUS_PROCCFG_1_READ_ADDRESS : OUT STD_LOGIC_VECTOR(15 downto 0);  
            BUS_PROCCFG_1_WRITE_DATA : OUT STD_LOGIC_VECTOR(31 downto 0); 
            BUS_PROCCFG_1_W_INT : OUT STD_LOGIC_VECTOR(0 downto 0); 
        
            BUS_PROCCFG_2_READ_ADDRESS : OUT STD_LOGIC_VECTOR(15 downto 0);  
            BUS_PROCCFG_2_WRITE_DATA : OUT STD_LOGIC_VECTOR(31 downto 0); 
            BUS_PROCCFG_2_W_INT : OUT STD_LOGIC_VECTOR(0 downto 0); 
        
            BUS_PROCCFG_3_READ_ADDRESS : OUT STD_LOGIC_VECTOR(15 downto 0);  
            BUS_PROCCFG_3_WRITE_DATA : OUT STD_LOGIC_VECTOR(31 downto 0); 
            BUS_PROCCFG_3_W_INT : OUT STD_LOGIC_VECTOR(0 downto 0); 
            
	        BUS_CLKCFG_READ_ADDRESS : OUT STD_LOGIC_VECTOR(15 downto 0);  
            BUS_CLKCFG_WRITE_DATA : OUT STD_LOGIC_VECTOR(31 downto 0); 
            BUS_CLKCFG_W_INT : OUT STD_LOGIC_VECTOR(0 downto 0);             
    
        
        -- IIC Interface
            
            BUS_i2c_0_READ_DATA : IN STD_LOGIC_VECTOR(31 downto 0); 
            BUS_i2c_0_WRITE_DATA : OUT STD_LOGIC_VECTOR(31 downto 0); 
            BUS_i2c_0_W_INT : OUT STD_LOGIC_VECTOR(0 downto 0); 
            BUS_i2c_0_R_INT : OUT STD_LOGIC_VECTOR(0 downto 0); 
            BUS_i2c_0_VLD : IN STD_LOGIC_VECTOR(0 downto 0); 
            REG_i2c_0_REG_CTRL_WR : OUT STD_LOGIC_VECTOR(31 downto 0); 
            INT_i2c_0_REG_CTRL_WR : OUT STD_LOGIC_VECTOR(0 downto 0); 
            REG_i2c_0_REG_MON_RD : IN STD_LOGIC_VECTOR(31 downto 0); 
            INT_i2c_0_REG_MON_RD : OUT STD_LOGIC_VECTOR(0 downto 0); 
            
         --FLASH CONTROLLER   
	       BUS_Flash_0_READ_DATA : IN STD_LOGIC_VECTOR(31 downto 0);
            BUS_Flash_0_ADDRESS : OUT STD_LOGIC_VECTOR(15 downto 0); 
            BUS_Flash_0_WRITE_DATA : OUT STD_LOGIC_VECTOR(31 downto 0); 
            BUS_Flash_0_W_INT : OUT STD_LOGIC_VECTOR(0 downto 0); 
            BUS_Flash_0_R_INT : OUT STD_LOGIC_VECTOR(0 downto 0); 
            BUS_Flash_0_VLD : IN STD_LOGIC_VECTOR(0 downto 0); 
            
            REG_FLASH_CNTR_RD : IN STD_LOGIC_VECTOR(31 downto 0); 
            REG_FLASH_CNTR_WR : OUT STD_LOGIC_VECTOR(31 downto 0); 
            INT_FLASH_CNTR_RD : OUT STD_LOGIC_VECTOR(0 downto 0); 
            INT_FLASH_CNTR_WR : OUT STD_LOGIC_VECTOR(0 downto 0);               
            
            REG_FLASH_ADDRESS_RD : IN STD_LOGIC_VECTOR(31 downto 0); 
            REG_FLASH_ADDRESS_WR : OUT STD_LOGIC_VECTOR(31 downto 0); 
            INT_FLASH_ADDRESS_RD : OUT STD_LOGIC_VECTOR(0 downto 0); 
            INT_FLASH_ADDRESS_WR : OUT STD_LOGIC_VECTOR(0 downto 0);     
            
          --
            BUS_FQMETER_ADDRESS : OUT STD_LOGIC_VECTOR(15 downto 0);
            BUS_FQMETER_RD : IN STD_LOGIC_VECTOR(31 downto 0);
                        
            REG_UNIQUE_RD : IN STD_LOGIC_VECTOR(31 downto 0); 
            REG_UNIQUE_WR : OUT STD_LOGIC_VECTOR(31 downto 0); 
            
            REG_FIRMWARE_BUILD : IN STD_LOGIC_VECTOR(31 downto 0);
    
            --LATO FPGA
          f_CLK : IN STD_LOGIC;
          f_RESET : IN STD_LOGIC
                        
                  
    );
    
    end component;
    
    

    component adcs_top is
       Generic (test_mode :  STD_LOGIC := '0');
       Port (  
             Reset : in std_logic;
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
             ADC_CLK_OUT : out STD_LOGIC;
             
             CH0 : out std_logic_vector (15 downto 0);
             CH1 : out std_logic_vector (15 downto 0);
             CH2 : out std_logic_vector (15 downto 0);
             CH3 : out std_logic_vector (15 downto 0);                                            
             CH4 : out std_logic_vector (15 downto 0);
             CH5 : out std_logic_vector (15 downto 0);
             CH6 : out std_logic_vector (15 downto 0);
             CH7 : out std_logic_vector (15 downto 0);
             
             CHv0_7 : out STD_LOGIC;
            
             inversion : in std_logic_vector(7 downto 0);
             
             ADC_STATUS : out STD_LOGIC_VECTOR(11 downto 0);
             ADC_READY : out STD_LOGIC
                     
             );
    end component;    
    
    
    component init_clock_gen is
        Generic (ComponentBaseAddress : std_logic_vector(15 downto 0));
        Port ( clk : in  STD_LOGIC;
               CK_SPI_LE : out  STD_LOGIC;
               CK_SPI_CLK : out  STD_LOGIC;
               CK_SPI_MOSI : out  STD_LOGIC;
               CK_PD : out  STD_LOGIC;
               CK_LOCK : in  STD_LOGIC;
               CK_CONFIG_DONE : OUT  STD_LOGIC:='0';
               reset : in  STD_LOGIC;
               reset_out : out  STD_LOGIC;
               REG_addr : in STD_LOGIC_VECTOR (15 downto 0);
               REG_din : in STD_LOGIC_VECTOR (31 downto 0);
               REG_wrint : in STD_LOGIC
               );
    end component;
    


COMPONENT i2c_master_v01
Generic(
CLK_FREQ : natural := 80000000;
BAUD:     natural := 100000
);
PORT(
	      sys_clk    : IN     std_logic;
	      sys_rst    : IN     std_logic;
	      start      : IN     std_logic;
	      stop       : IN     std_logic;
	      read       : IN     std_logic;
	      write      : IN     std_logic;
	      send_ack   : IN     std_logic;
	      mstr_din   : IN     std_logic_vector (7 DOWNTO 0);
	      sda        : INOUT  std_logic;
	      scl        : INOUT  std_logic;
	      free       : OUT    std_logic;
	      rec_ack    : OUT    std_logic;
	      ready      : OUT    std_logic;
	 	  data_good  : OUT    std_logic;
	      core_state : OUT    std_logic_vector (5 DOWNTO 0);
	      mstr_dout  : OUT    std_logic_vector (7 DOWNTO 0)
	);
END COMPONENT;


    component PetirocSlowControl is
        Generic (   ComponentBaseAddress : std_logic_vector(15 downto 0);
                    Halfbit : integer := 10000);
        Port (    
                reset : in  STD_LOGIC;
                clk : in STD_LOGIC;
                PETIROC_CLK : out STD_LOGIC;
                PETIROC_MOSI : out STD_LOGIC;
                PETIROC_SLOAD : out STD_LOGIC;
                PETIROC_RESETB : out STD_LOGIC;
                PETIROC_SELECT : out STD_LOGIC;
                REG_addr : in STD_LOGIC_VECTOR (15 downto 0);
                REG_din : in STD_LOGIC_VECTOR (31 downto 0);
                REG_out : inout STD_LOGIC_VECTOR (31 downto 0);
                REG_wrint : in STD_LOGIC;
                REG_rdint : in STD_LOGIC;
                REG_rddv : out STD_LOGIC
                  );
    end component;
    
    component petiroc_datareceiver is
        Port (  
          clk : in std_logic;
        trigger_in : in std_logic;
        hold_ext_trigger : in std_logic;
        hold_external_hold : out std_logic;
        transmit_on : in std_logic;
        data_in : in std_logic;
        raz_chn_f : in std_logic;
        chrage_trig : in std_logic;
        start_conv : out std_logic;
        raz_chn : out std_logic;
        val_evnt : out std_logic;
        daq_veto : in std_logic;
        daq_stroed_event : out std_logic;
        daq_event : out std_logic;
        clk_timecode : in std_logic;
        T0 : in std_logic;
        fifo_clk : in std_logic;
        fifo_reset : in std_logic;
        fifo_rd : in std_logic;
        fifo_datavalid : out std_logic;
        fifo_busy : out std_logic;
        RunTimer : in std_logic_vector (64 -1 downto 0);
        fifo_data : out std_logic_vector(31 downto 0);
        delay_trigger : in std_logic_vector(15 downto 0);
        DataWordT0 : out std_logic_vector (32 -1 downto 0);
        DataWordRun : out std_logic_vector (64 -1 downto 0);
        DataWord : out std_logic_vector (32*32 -1 downto 0);
        ValidWord : out std_logic;
        ResetValidWord  : in std_logic;
        TriggerSelector : in std_logic
    );
    end component;

    COMPONENT RDO_LIST_FIFO IS
      PORT (
        rst : IN STD_LOGIC;
        wr_clk : IN STD_LOGIC;
        rd_clk : IN STD_LOGIC;
        din : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        wr_en : IN STD_LOGIC;
        rd_en : IN STD_LOGIC;
        dout : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        full : OUT STD_LOGIC;
        empty : OUT STD_LOGIC;
        prog_full : OUT STD_LOGIC;
        prog_empty : OUT STD_LOGIC
      );
    END COMPONENT;
    
    component FlashController is
        Port (
                clk : in STD_LOGIC;
                BUS_Flash_0_READ_DATA : OUT STD_LOGIC_VECTOR(31 downto 0);
                BUS_Flash_0_ADDRESS : IN STD_LOGIC_VECTOR(15 downto 0); 
                BUS_Flash_0_WRITE_DATA : IN STD_LOGIC_VECTOR(31 downto 0); 
                BUS_Flash_0_W_INT : IN STD_LOGIC_VECTOR(0 downto 0); 
                BUS_Flash_0_R_INT : IN STD_LOGIC_VECTOR(0 downto 0); 
                BUS_Flash_0_VLD : OUT STD_LOGIC_VECTOR(0 downto 0); 
                
                REG_FLASH_CNTR_RD : OUT STD_LOGIC_VECTOR(31 downto 0); 
                REG_FLASH_CNTR_WR : IN STD_LOGIC_VECTOR(31 downto 0); 
                INT_FLASH_CNTR_RD : IN STD_LOGIC_VECTOR(0 downto 0); 
                INT_FLASH_CNTR_WR : IN STD_LOGIC_VECTOR(0 downto 0);  
                    
                REG_FLASH_ADDRESS_RD : OUT STD_LOGIC_VECTOR(31 downto 0); 
                REG_FLASH_ADDRESS_WR : IN STD_LOGIC_VECTOR(31 downto 0); 
                INT_FLASH_ADDRESS_RD : IN STD_LOGIC_VECTOR(0 downto 0); 
                INT_FLASH_ADDRESS_WR : IN STD_LOGIC_VECTOR(0 downto 0);                 
                
                
                SPI_CS : out  STD_LOGIC;
                SPI_DIN : in  STD_LOGIC;
                SPI_DOUT : out  STD_LOGIC;
                SPI_CLK : out  STD_LOGIC 
        );
    end component;    
        
    component DTClockGenerator
    port
    (  
     signal clk_out1 : out std_logic;
     signal clk_out2 : out std_logic;
     signal clk_out3 : out std_logic;
     signal clk_out4 : out std_logic;
     signal locked : out std_logic;
     signal clk_in1  :  in std_logic
    );
    end component;
                
    component PetirocAsicOscilloscope 
        Port ( sample_clk : in STD_LOGIC;
                bus_clk : in STD_LOGIC;
                trgs_a : in STD_LOGIC_VECTOR (31 downto 0);
                trgs_b : in STD_LOGIC_VECTOR (31 downto 0);
                trgs_c : in STD_LOGIC_VECTOR (31 downto 0);
                trgs_d : in STD_LOGIC_VECTOR (31 downto 0);
                charge_mux_a : in STD_LOGIC_VECTOR (15 downto 0);
                charge_mux_b : in STD_LOGIC_VECTOR (15 downto 0);
                charge_mux_c : in STD_LOGIC_VECTOR (15 downto 0);
                charge_mux_d : in STD_LOGIC_VECTOR (15 downto 0);
                chrage_clk_a : in STD_LOGIC;
                chrage_clk_b : in STD_LOGIC;
                chrage_clk_c : in STD_LOGIC;
                chrage_clk_d : in STD_LOGIC;           
                chrage_srin_a : in STD_LOGIC;
                chrage_srin_b : in STD_LOGIC;
                chrage_srin_c : in STD_LOGIC;
                chrage_srin_d : in STD_LOGIC;
                chrage_trig_a : in STD_LOGIC;
                chrage_trig_b : in STD_LOGIC;
                chrage_trig_c : in STD_LOGIC;
                chrage_trig_d : in STD_LOGIC;
                an_probe_a : in STD_LOGIC_VECTOR (15 downto 0);
                an_probe_b : in STD_LOGIC_VECTOR (15 downto 0);
                an_probe_c : in STD_LOGIC_VECTOR (15 downto 0);
                an_probe_d : in STD_LOGIC_VECTOR (15 downto 0);
                dig_probe_a : in STD_LOGIC;
                dig_probe_b : in STD_LOGIC;
                dig_probe_c : in STD_LOGIC;
                dig_probe_d : in STD_LOGIC;
                lemo1 : in STD_LOGIC;
                lemo2 : in STD_LOGIC;
                lemo3 : in STD_LOGIC;
                lemo4 : in STD_LOGIC;
                trigger_a : in STD_LOGIC;
                trigger_b : in STD_LOGIC;
                trigger_c : in STD_LOGIC;
                trigger_d : in STD_LOGIC;
                trigb_mux_a : in STD_LOGIC;
                trigb_mux_b : in STD_LOGIC;
                trigb_mux_c : in STD_LOGIC;
                trigb_mux_d : in STD_LOGIC;                                       
                global_trigger : in STD_LOGIC;
	            BUS_Oscilloscope_0_READ_DATA : OUT STD_LOGIC_VECTOR(31 downto 0);
                BUS_Oscilloscope_0_ADDRESS : IN STD_LOGIC_VECTOR(15 downto 0); 
                BUS_Oscilloscope_0_WRITE_DATA : IN STD_LOGIC_VECTOR(31 downto 0); 
                BUS_Oscilloscope_0_W_INT : IN STD_LOGIC_VECTOR(0 downto 0); 
                BUS_Oscilloscope_0_R_INT : IN STD_LOGIC_VECTOR(0 downto 0); 
                BUS_Oscilloscope_0_VLD : OUT STD_LOGIC_VECTOR(0 downto 0)
               );
    end component;
    
    component PetirocAnalogMonitor 
        Generic (CLKDIV : integer := 10);
        Port (  clk : in STD_LOGIC;
                A_trigger_logic : in STD_LOGIC;
                chrage_srin_a : out STD_LOGIC;
                chrage_clk_a : out STD_LOGIC;
                raz_signal : out STD_LOGIC;
                enable : in STD_LOGIC
        );
    end component;  
    
    
    component MultichannelRateMeter is
        Generic(
                CHANNEL_COUNT : integer := 127;
                CLK_FREQ : integer := 160000000
                );
        Port ( clk : in STD_LOGIC;
               trigger : in STD_LOGIC_VECTOR (CHANNEL_COUNT-1 downto 0);
               reg_address : in STD_LOGIC_VECTOR (15 downto 0);
               reg_read : out STD_LOGIC_VECTOR (31 downto 0));
    end component;  

        
    component delay_box is
        Port ( 
               clk : in STD_LOGIC;
               input_signal : in STD_LOGIC;
               output_signal : out STD_LOGIC;
               delay_value : in STD_LOGIC_VECTOR (15 downto 0));
    end component;
            
    signal reset: std_logic := '0';
    
    signal f_BUS_ADDR 		 : STD_LOGIC_VECTOR(31 downto 0);	--INDIRIZZO DI LETTURA/SCRITTURA
    
    signal f_BUS_CLK     	 : STD_LOGIC;								--CLOCK BUS
    
    --DA FPGA A PC
    signal f_BUS_INT_RD 	 : STD_LOGIC;								--INTERRUPT DI LETTURA
    signal f_BUS_DATASTROBE : STD_LOGIC;								--CONFERMA CHE I DATI RICHIESTI SONO DISPONIBILI
    signal f_BUS_DATA_RD	 : STD_LOGIC_VECTOR(31 downto 0);	--DATI DA INVIARE AL PC
    signal f_MODE				 : STD_LOGIC;								--0 IL SEGNALE DATASROBE E' ABILITAO, 1 DATI CAMPIONATI UN CICLO DOPO INT_RD
  
  --DA PC A FPGA
    signal f_BUS_INT_WR 	 : STD_LOGIC;								--INTERRUPT DI SCRITTURA
    signal f_BUS_DATA_WR	 : STD_LOGIC_VECTOR(31 downto 0);		--DATI DA INVIATI DAL PC
    signal cntr	 : STD_LOGIC_VECTOR(31 downto 0);
    
    signal CK_CONFIG_DONE :  STD_LOGIC:='0';
   
    signal sys_reset : std_LOGIC;
    
    signal a_val_evt : std_logic := '0';
    signal a_val_evti : std_logic := '0';
    signal b_val_evt : std_logic := '0';
    signal c_val_evt : std_logic := '0'; 
    signal c_val_evti : std_logic := '0';
    signal d_val_evt : std_logic := '0';
        
    signal a_raz_chn : std_logic := '0';
    signal b_raz_chn : std_logic := '0';
    signal b_raz_chn_i : std_logic := '0';
    signal c_raz_chn : std_logic := '0';
    signal d_raz_chn : std_logic := '1';
    signal raz_chn_f : std_logic := '1';
    signal d_raz_chn_i : std_logic := '0';
    
    signal A_LVDS_DOUT : STD_LOGIC;
    signal B_LVDS_DOUT : STD_LOGIC;
    signal D_LVDS_DOUT : STD_LOGIC;
    signal D_LVDS_DOUTn : STD_LOGIC;        
    signal C_LVDS_DOUT : STD_LOGIC;
    signal C_LVDS_DOUTn : STD_LOGIC;
           
    signal D_LVDS_DCLK : STD_LOGIC;
    signal iD_LVDS_DCLK : STD_LOGIC;
      
    signal trg_ext_cnt : integer range 0 to 1000000 := 0;
    
    signal A_trigger_logic : std_logic;
    signal B_trigger_logic : std_logic;
    signal C_trigger_logic : std_logic := '0';
    signal D_trigger_logic : std_logic := '0';
    
    signal delay_trigger : std_logic_vector (15 downto 0) := x"0000";
    
    signal start_conv_glb : std_logic;
    signal TM : std_logic_vector (31 downto 0) := x"00000000";
    
    signal veto_in : std_logic;
    signal veto_enable_a : std_logic := '0';
    signal veto_enable_b : std_logic := '0';
    signal veto_enable_c : std_logic := '0';
    signal veto_enable_d : std_logic := '0';
    
    signal veto_a : std_logic;
    signal veto_b : std_logic;
    signal veto_c : std_logic;
    signal veto_d : std_logic;
    
    signal fifo_reset : std_logic := '0';
    
    signal daq_event_A : std_logic;
    signal daq_event_B : std_logic;
    signal daq_event_C : std_logic;
    signal daq_event_D : std_logic;
    
    signal daq_event_stored_A : std_logic;
    signal daq_event_stored_B : std_logic;
    signal daq_event_stored_C : std_logic;
    signal daq_event_stored_D : std_logic;
    
    signal fifo_busy_a : std_logic;
    signal fifo_busy_b : std_logic;
    signal fifo_busy_c : std_logic;
    signal fifo_busy_d : std_logic;
    
    signal timecode_clock : std_logic;
    signal itimecode_clock : std_logic;
    signal T0 : std_logic;
    
    signal T0sel : std_logic := '0';
    signal T0sw : std_logic := '0';
    
    signal LEMO4_cntr : std_logic_vector(15 downto 0) := x"0000";
    signal LEMO5_cntr : std_logic_vector(15 downto 0) := x"0000";
    signal LEMO6_cntr : std_logic_vector(15 downto 0) := x"0000";
    signal LEMO7_cntr : std_logic_vector(15 downto 0) := x"0000";
    
    signal outsig_len : std_logic_vector(15 downto 0) := x"0010";
    
    signal sw_veto : std_logic := '0';
    
    signal internal_pulser_pediod : integer := 160000;                            
    signal internal_pulser_enableA : std_logic := '0';
    signal internal_pulser_enableB : std_logic := '0';
    signal internal_pulser_enableC : std_logic := '0';
    signal internal_pulser_enableD : std_logic := '0';
    
    
    signal f_BUS_DATA_RD_A : std_logic_vector(31 downto 0);
        signal f_BUS_DATA_RD_B : std_logic_vector(31 downto 0);
        
        signal f_BUS_DATASTROBE_A : std_logic;
        signal f_BUS_DATASTROBE_B : std_logic;
    
        signal f_BUS_INT_RD_A : std_logic;
        signal f_BUS_INT_RD_B : std_logic;
    
    
    	signal BUS_i2c_0_READ_DATA : STD_LOGIC_VECTOR(31 downto 0); 
        signal BUS_i2c_0_WRITE_DATA : STD_LOGIC_VECTOR(31 downto 0); 
        signal BUS_i2c_0_W_INT : STD_LOGIC_VECTOR(0 downto 0); 
        signal BUS_i2c_0_R_INT : STD_LOGIC_VECTOR(0 downto 0); 
        signal BUS_i2c_0_VLD : STD_LOGIC_VECTOR(0 downto 0) := "1"; 
        signal REG_i2c_0_REG_CTRL_WR : STD_LOGIC_VECTOR(31 downto 0); 
        signal INT_i2c_0_REG_CTRL_WR : STD_LOGIC_VECTOR(0 downto 0); 
        signal REG_i2c_0_REG_MON_RD : STD_LOGIC_VECTOR(31 downto 0); 
        signal INT_i2c_0_REG_MON_RD : STD_LOGIC_VECTOR(0 downto 0); 
        
	    signal BUS_Oscilloscope_0_READ_DATA :  STD_LOGIC_VECTOR(31 downto 0);
        signal BUS_Oscilloscope_0_ADDRESS :  STD_LOGIC_VECTOR(15 downto 0); 
        signal BUS_Oscilloscope_0_WRITE_DATA :  STD_LOGIC_VECTOR(31 downto 0); 
        signal BUS_Oscilloscope_0_W_INT :  STD_LOGIC_VECTOR(0 downto 0); 
        signal BUS_Oscilloscope_0_R_INT :  STD_LOGIC_VECTOR(0 downto 0); 
        signal BUS_Oscilloscope_0_VLD :  STD_LOGIC_VECTOR(0 downto 0);         

    signal i2c_0_ready : std_logic_vector(0 downto 0) := (others => '0');
    signal i2c_0_data_good : std_logic_vector(0 downto 0) := (others => '0');
    signal i2c_0_rec_ack : std_logic_vector(0 downto 0) := (others => '0');
    signal i2c_0_dout : std_logic_vector(7 downto 0) := (others => '0');
    signal i2c_0_REG_CTRL_LATCHED : std_logic_vector(31 downto 0) := (others => '0');


	signal REG_ValEvt : std_logic_vector (31 downto 0) := (others => '0');
	signal REG_Rstb : std_logic_vector (31 downto 0) := (others => '0');
	signal REG_Startb : std_logic_vector (31 downto 0) := (others => '0');
	signal REG_Fiforeset : std_logic_vector (31 downto 0) := (others => '0');
	
	signal REG_T0sel_RD : STD_LOGIC_VECTOR(31 downto 0); 
    signal REG_T0sel_WR : STD_LOGIC_VECTOR(31 downto 0); 
    signal INT_T0sel_RD : STD_LOGIC_VECTOR(0 downto 0); 
    signal INT_T0sel_WR : STD_LOGIC_VECTOR(0 downto 0); 

    signal REG_T0sw_RD : STD_LOGIC_VECTOR(31 downto 0); 
    signal REG_T0sw_WR : STD_LOGIC_VECTOR(31 downto 0); 
    signal INT_T0sw_RD : STD_LOGIC_VECTOR(0 downto 0); 
    signal INT_T0sw_WR : STD_LOGIC_VECTOR(0 downto 0); 

    signal REG_T0sw_mode_RD : STD_LOGIC_VECTOR(31 downto 0); 
    signal REG_T0sw_mode_WR : STD_LOGIC_VECTOR(31 downto 0); 
    signal INT_T0sw_mode_RD : STD_LOGIC_VECTOR(0 downto 0); 
    signal INT_T0sw_mode_WR : STD_LOGIC_VECTOR(0 downto 0); 

    signal REG_T0sw_freq_RD : STD_LOGIC_VECTOR(31 downto 0); 
    signal REG_T0sw_freq_WR : STD_LOGIC_VECTOR(31 downto 0); 
    signal INT_T0sw_freq_RD : STD_LOGIC_VECTOR(0 downto 0); 
    signal INT_T0sw_freq_WR : STD_LOGIC_VECTOR(0 downto 0);       
    
	signal REG_TRGsel_RD : STD_LOGIC_VECTOR(31 downto 0); 
    signal REG_TRGsel_WR : STD_LOGIC_VECTOR(31 downto 0); 
    signal INT_TRGsel_RD : STD_LOGIC_VECTOR(0 downto 0); 
    signal INT_TRGsel_WR : STD_LOGIC_VECTOR(0 downto 0); 
    
    signal REG_EnableCommonTrigger_RD : std_logic_Vector(31 downto 0) := x"00000000";
    signal REG_EnableCommonTrigger_WR : std_logic_Vector(31 downto 0) := x"00000000";
    signal INT_EnableCommonTrigger_RD : STD_LOGIC_VECTOR(0 downto 0); 

    
    signal REG_EnableExtVeto_RD : std_logic_Vector(31 downto 0) := x"00000000";
    signal REG_EnableExtVeto_WR : std_logic_Vector(31 downto 0) := x"00000000";
    signal INT_EnableExtVeto_RD : STD_LOGIC_VECTOR(0 downto 0);  
    signal INT_EnableExtVeto_WR : STD_LOGIC_VECTOR(0 downto 0);       

    signal REG_EnableExtTrigger_RD :  std_logic_Vector(31 downto 0) := x"00000000";
    signal REG_EnableExtTrigger_WR :  std_logic_Vector(31 downto 0) := x"00000000";
    signal INT_EnableExtTrigger_RD :  STD_LOGIC_VECTOR(0 downto 0);  
    signal INT_EnableExtTrigger_WR :  STD_LOGIC_VECTOR(0 downto 0); 
    
    signal REG_AsicDisable :  STD_LOGIC_VECTOR(31 downto 0);  
    signal INT_AsicDisable :  STD_LOGIC_VECTOR(0 downto 0);  
    
     
    signal  REG_AnalogReadout : STD_LOGIC_VECTOR(31 downto 0); 
    signal  INT_AnalogReadout_RD : STD_LOGIC_VECTOR(0 downto 0); 
    signal  INT_AnalogReadout_WR : STD_LOGIC_VECTOR(0 downto 0); 

    signal L_AsicDisable :  STD_LOGIC_VECTOR(31 downto 0) := (others => '0');  
    signal cL_AsicDisable :  STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
	
	signal ImageReadout_0_READ_DATA : std_logic_vector (31 downto 0) := (others => '0');
	signal ImageReadout_0_RD : std_logic_vector (0 downto 0) := (others => '0');
	signal ImageReadout_0_VLD : std_logic_vector (0 downto 0) := (others => '0');
	signal ImageReadout_0_WCNT : std_logic_vector (31 downto 0) := (others => '0');
	signal BUS_PROCCFG_0_READ_ADDRESS : std_logic_vector (15 downto 0) := (others => '0');
	signal BUS_PROCCFG_0_WRITE_DATA : std_logic_vector (31 downto 0) := (others => '0');
	signal BUS_PROCCFG_0_W_INT : std_logic_vector (0 downto 0) := (others => '0');
	signal BUS_PROCCFG_1_READ_ADDRESS : std_logic_vector (15 downto 0) := (others => '0');
    signal BUS_PROCCFG_1_WRITE_DATA : std_logic_vector (31 downto 0) := (others => '0');
    signal BUS_PROCCFG_1_W_INT : std_logic_vector (0 downto 0) := (others => '0');
	signal BUS_PROCCFG_2_READ_ADDRESS : std_logic_vector (15 downto 0) := (others => '0');
    signal BUS_PROCCFG_2_WRITE_DATA : std_logic_vector (31 downto 0) := (others => '0');
    signal BUS_PROCCFG_2_W_INT : std_logic_vector (0 downto 0) := (others => '0');
	signal BUS_PROCCFG_3_READ_ADDRESS : std_logic_vector (15 downto 0) := (others => '0');
    signal BUS_PROCCFG_3_WRITE_DATA : std_logic_vector (31 downto 0) := (others => '0');
    signal BUS_PROCCFG_3_W_INT : std_logic_vector (0 downto 0) := (others => '0');
	signal BUS_CLKCFG_READ_ADDRESS : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');  
    signal BUS_CLKCFG_WRITE_DATA : STD_LOGIC_VECTOR(31 downto 0) := (others => '0'); 
    signal BUS_CLKCFG_W_INT : STD_LOGIC_VECTOR(0 downto 0):=(others =>'0'); 
    
    signal REG_SelfTrigger : STD_LOGIC_VECTOR(31 downto 0)  := (others => '0');          
    signal REG_SelfTriggerPeriod : STD_LOGIC_VECTOR(31 downto 0)  := (others => '0');        
    signal REG_TriggerMode : STD_LOGIC_VECTOR(31 downto 0)  := (others => '0'); 
    
    
    signal BUS_FQMETER_ADDRESS :  STD_LOGIC_VECTOR(15 downto 0);
    signal BUS_FQMETER_RD :  STD_LOGIC_VECTOR(31 downto 0);

    signal RunTimer : std_logic_vector(63 downto 0) := (others => '0');
                
    attribute keep : string;     
        
    attribute keep of BUS_PROCCFG_0_READ_ADDRESS: signal is "true";
    attribute keep of BUS_PROCCFG_1_READ_ADDRESS: signal is "true";
    attribute keep of BUS_PROCCFG_2_READ_ADDRESS: signal is "true";
    attribute keep of BUS_PROCCFG_3_READ_ADDRESS: signal is "true";
    
    attribute keep of BUS_PROCCFG_0_WRITE_DATA: signal is "true";
    attribute keep of BUS_PROCCFG_1_WRITE_DATA: signal is "true";
    attribute keep of BUS_PROCCFG_2_WRITE_DATA: signal is "true";
    attribute keep of BUS_PROCCFG_3_WRITE_DATA: signal is "true";

    attribute keep of BUS_PROCCFG_0_W_INT: signal is "true";
    attribute keep of BUS_PROCCFG_1_W_INT: signal is "true";
    attribute keep of BUS_PROCCFG_2_W_INT: signal is "true";
    attribute keep of BUS_PROCCFG_3_W_INT: signal is "true";

    signal TotalEventCounter : std_logic_vector (32 -1 downto 0) := (others => '0');
    signal ADataWordT0 : std_logic_vector (32 -1 downto 0);
    signal BDataWordT0 : std_logic_vector (32 -1 downto 0);
    signal CDataWordT0 : std_logic_vector (32 -1 downto 0);
    signal DDataWordT0 : std_logic_vector (32 -1 downto 0);
    signal ADataWordRun : std_logic_vector (64 -1 downto 0);
    signal BDataWordRun : std_logic_vector (64 -1 downto 0);
    signal CDataWordRun : std_logic_vector (64 -1 downto 0);
    signal DDataWordRun : std_logic_vector (64 -1 downto 0);

    signal ADataWord :  std_logic_vector (32*32 -1 downto 0);
    signal BDataWord :  std_logic_vector (32*32 -1 downto 0);
    signal CDataWord :  std_logic_vector (32*32 -1 downto 0);
    signal DDataWord :  std_logic_vector (32*32 -1 downto 0);
    signal AValidWord :  std_logic :='0';
    signal BValidWord :  std_logic :='0';
    signal CValidWord :  std_logic :='0';
    signal DValidWord :  std_logic :='0';
    signal AResetValidWord  :  std_logic:='0';
    signal BResetValidWord  :  std_logic:='0';
    signal CResetValidWord  :  std_logic:='0';
    signal DResetValidWord  :  std_logic:='0';
    signal sfifo_reset :std_logic:='0';
    signal ssfifo_reset :std_logic:='0';
    signal iT0 : std_logic;
    signal oT0 : std_logic;
    
    signal cFiforeset : std_logic :='0';
    
    
    signal clk_100_adc : std_logic := '0';
    signal clk_100_adc_ce : std_logic := '0';      

    
    signal CLK_80 : std_logic_vector(0 downto 0); 
    signal CLK_40 :  std_logic_vector(0 downto 0); 
    signal CLK_160 :  std_logic_vector(0 downto 0);   
    signal CLK_320 : std_logic_vector(0 downto 0); 
    
    signal async_clk : std_logic_vector (0 downto 0) := "0";
    signal GlobalReset : std_logic_vector (0 downto 0) := "0";
    signal GlobalDCMLock : std_logic; 
    signal CLK_ACQ : std_logic_vector (0 downto 0) := "0";
    
    
    signal ADC_A0 : std_logic_vector(15 downto 0);
    signal ADC_A1 : std_logic_vector(15 downto 0);
    signal ADC_A2 : std_logic_vector(15 downto 0);
    signal ADC_A3 : std_logic_vector(15 downto 0);
    signal ADC_A4 : std_logic_vector(15 downto 0);
    signal ADC_A5 : std_logic_vector(15 downto 0);
    signal ADC_A6 : std_logic_vector(15 downto 0);
    signal ADC_A7 : std_logic_vector(15 downto 0);

    signal ANALOG_INPUT_INVERSION : std_logic_vector(7 downto 0) := x"00";
    
    signal ADCreset :  std_logic := '0';
    signal EXT_READY : std_logic;
    
    
    signal chrage_clk_a :  STD_LOGIC;
    signal chrage_clk_b :  STD_LOGIC;
    signal chrage_clk_c :  STD_LOGIC;
    signal chrage_clk_d :  STD_LOGIC;           
    signal chrage_srin_a :  STD_LOGIC;
    signal chrage_srin_b :  STD_LOGIC;
    signal chrage_srin_c :  STD_LOGIC;
    signal chrage_srin_d :  STD_LOGIC;
    
    signal COMMON_TRIGGER : std_logic;
    
    
    attribute keep of ADC_A0: signal is "true";
    attribute keep of ADC_A1: signal is "true";
    attribute keep of ADC_A2: signal is "true";
    attribute keep of ADC_A3: signal is "true";
    attribute keep of ADC_A4: signal is "true";
    attribute keep of ADC_A5: signal is "true";
    attribute keep of ADC_A6: signal is "true";
    attribute keep of ADC_A7: signal is "true";
    
    
    signal BUS_Flash_0_READ_DATA :  STD_LOGIC_VECTOR(31 downto 0);
    signal BUS_Flash_0_ADDRESS :  STD_LOGIC_VECTOR(15 downto 0); 
    signal BUS_Flash_0_WRITE_DATA :  STD_LOGIC_VECTOR(31 downto 0); 
    signal BUS_Flash_0_W_INT :  STD_LOGIC_VECTOR(0 downto 0); 
    signal BUS_Flash_0_R_INT :  STD_LOGIC_VECTOR(0 downto 0); 
    signal BUS_Flash_0_VLD :  STD_LOGIC_VECTOR(0 downto 0);   
    
    signal REG_FLASH_CNTR_RD :  STD_LOGIC_VECTOR(31 downto 0); 
    signal REG_FLASH_CNTR_WR :  STD_LOGIC_VECTOR(31 downto 0); 
    signal INT_FLASH_CNTR_RD :  STD_LOGIC_VECTOR(0 downto 0); 
    signal INT_FLASH_CNTR_WR :  STD_LOGIC_VECTOR(0 downto 0); 
    
    
    signal REG_HOLD_DELAY_CNTR_RD :  STD_LOGIC_VECTOR(31 downto 0); 
    signal REG_HOLD_DELAY_CNTR_WR :  STD_LOGIC_VECTOR(31 downto 0); 
    signal INT_HOLD_DELAY_CNTR_RD :  STD_LOGIC_VECTOR(0 downto 0); 
    signal INT_HOLD_DELAY_CNTR_WR :  STD_LOGIC_VECTOR(0 downto 0);  

    signal REG_EXT_HOLD_EN_RD :  STD_LOGIC_VECTOR(31 downto 0); 
    signal REG_EXT_HOLD_EN_WR :  STD_LOGIC_VECTOR(31 downto 0); 
    signal INT_REG_EXT_HOLD_EN_RD :  STD_LOGIC_VECTOR(0 downto 0); 
    signal INT_REG_EXT_HOLD_EN_WR :  STD_LOGIC_VECTOR(0 downto 0);  
    
       
    
    signal REG_FLASH_ADDRESS_RD :  STD_LOGIC_VECTOR(31 downto 0); 
    signal REG_FLASH_ADDRESS_WR :  STD_LOGIC_VECTOR(31 downto 0); 
    signal INT_FLASH_ADDRESS_RD :  STD_LOGIC_VECTOR(0 downto 0); 
    signal INT_FLASH_ADDRESS_WR :  STD_LOGIC_VECTOR(0 downto 0);         
    
    signal FLASH_SPI_CLK : std_logic;
               
    signal clock_prog_mux_out : std_logic;
    signal done_sig : std_logic;
    signal cfg_clk : std_logic;
    
    signal trig_fake_pulse : std_logic := '0';
    signal all_trigger_signals : std_logic_vector ( 127 downto 0) ;
    
    signal ipulser : std_logic_vector (3 downto 0) := x"0";
    signal o_common_trigger : std_logic;
    signal i_common_trigger : std_logic;
    signal x_common_trigger : std_logic;
    signal counter_common_trigger : std_logic_vector(3 downto 0) := x"0";
    
    
    signal  REG_ResetTDCOnT0_RD : STD_LOGIC_VECTOR(31 downto 0) := x"00000000"; 
    signal  REG_ResetTDCOnT0_WR : STD_LOGIC_VECTOR(31 downto 0) := x"00000000"; 
    signal  INT_ResetTDCOnT0_RD : STD_LOGIC_VECTOR(0 downto 0); 
    signal  INT_ResetTDCOnT0_WR : STD_LOGIC_VECTOR(0 downto 0);     
    
    signal iT0Pulse : std_logic_vector (3 downto 0) := x"0";
    signal xT0 : std_logic := '0';
    
    signal TrigINDelayed : std_logic;
    signal EXT_Trig_FROM_HoldExt : std_logic;

    signal hold_external_hold : std_logic;
    signal hold_external_hold1 : std_logic;
    signal hold_external_hold2 : std_logic;
    signal hold_external_hold3 : std_logic;
    signal hold_external_hold4 : std_logic;
--    signal C_TRG :  STD_LOGIC_VECTOR(31 downto 0) := (others => '1');
--    signal D_TRG :  STD_LOGIC_VECTOR(31 downto 0) := (others => '1');
begin

   dcm_top: DTClockGenerator
    port map
     (
       clk_out1 => CLK_320(0),
       clk_out2 => CLK_160(0),
       clk_out3 => CLK_80(0),
       clk_out4 => CLK_40(0),
       locked => GlobalDCMLock,
       clk_in1  => D_LVDS_DCLK
     );
     GlobalReset(0) <= not GlobalDCMLock;


    A_ANALOG_CLK <= chrage_clk_a;
    A_ANALOG_DIN <= chrage_srin_a;

    B_ANALOG_CLK <= chrage_clk_b;
    B_ANALOG_DIN <= chrage_srin_b;

    C_ANALOG_CLK <= chrage_clk_c;
    C_ANALOG_DIN <= chrage_srin_c;

    D_ANALOG_CLK <= chrage_clk_d;
    D_ANALOG_DIN <= chrage_srin_d;
    
    PAM0 : PetirocAnalogMonitor 
    Generic Map (CLKDIV=>20)
    Port Map(  clk => CLK_ACQ(0),
            A_trigger_logic => A_trigger_logic,
            chrage_srin_a => chrage_srin_a, 
            chrage_clk_a => chrage_clk_a,
            raz_signal => open,
            enable => REG_AnalogReadout(0)
    );
     
    PAM1 : PetirocAnalogMonitor
    Generic Map (CLKDIV=>20)
    Port Map(  clk => CLK_ACQ(0),
            A_trigger_logic => B_trigger_logic,
            chrage_srin_a => chrage_srin_b, 
            chrage_clk_a => chrage_clk_b,
            raz_signal => open,
            enable => REG_AnalogReadout(0)
    );
    
    PAM2 : PetirocAnalogMonitor 
    Generic Map (CLKDIV=>20)
    Port Map(  clk => CLK_ACQ(0),
            A_trigger_logic => C_trigger_logic,
            chrage_srin_a => chrage_srin_c, 
            chrage_clk_a => chrage_clk_c,
            raz_signal => open,
            enable => REG_AnalogReadout(0)
    );
    
    PAM3 : PetirocAnalogMonitor 
    Generic Map (CLKDIV=>20)
    Port Map(  clk => CLK_ACQ(0),
            A_trigger_logic => D_trigger_logic,
            chrage_srin_a => chrage_srin_d, 
            chrage_clk_a => chrage_clk_d,
            raz_signal => open,
            enable => REG_AnalogReadout(0)
    );                

    
--    ANALOG_READOUT : block
--        signal BLKSM : std_logic_vector (3 downto 0) := x"0";
--        signal iA_trigger_logic : std_logic;
--        signal oA_trigger_logic : std_logic;
--        signal counter : integer;
--        signal bitcounter : integer;
--    begin
--        ANALOG_SM : process(timecode_clock)
--        begin
--            if rising_edge(timecode_clock) then
--                iA_trigger_logic <= A_trigger_logic;
--                oA_trigger_logic <= iA_trigger_logic;
--                case BLKSM is
--                    when x"0" =>
--                        if iA_trigger_logic = '0' and oA_trigger_logic = '1'  then
--                            BLKSM <= x"1";
--                            chrage_srin_a <= '1';
--                            chrage_clk_a  <= '0';
--                            counter <= 10;
--                            bitcounter <= 35;
--                        end if;
--                    when x"1" =>
--                        if counter = 0 then
--                            chrage_clk_a <= '1';
--                            counter <= 10;
--                            BLKSM <= x"2";
--                        else
--                            counter <= counter -1;
--                        end if; 
--                    when x"2" =>
--                        if counter = 0 then
--                            chrage_clk_a <= '0';
--                            counter <= 10;
--                            BLKSM <= x"3";
--                        else
--                            counter <= counter -1;
--                        end if; 
                    
--                    when x"3" =>
--                        chrage_srin_a <= '0';
--                        if bitcounter = 0 then
--                            BLKSM <= x"0";
--                        else
--                            BLKSM <= x"1";
--                            bitcounter <= bitcounter -1;
--                        end if;
                        
--                    when others =>
--                        BLKSM <= x"0";
--              end case;
--            end if;
--        end process;
--    end block;
-- End o


    LEMO01_dir <= '0';
    LEMO23_dir <= '0';
    LEMO45_dir <= '1';
    LEMO67_dir <= '1';
    
    LEMO6 <= fifo_reset;
    LEMO7 <= T0;
    LEMO5 <= common_trigger;
    
    T0 <= xT0 or fifo_reset;
    
    t0sync : process (D_LVDS_DCLK) 
    begin
        if rising_edge (D_LVDS_DCLK) then
            if T0sel = '1' then
                iT0 <= LEMO1;
            else
                iT0 <= T0sw;
            end if;
            oT0 <= iT0;
            
            
            if iT0Pulse = x"0" then
                xT0 <= '0';
            else
                xT0 <= '1';
                iT0Pulse <= iT0Pulse -1;  
            end if;
            if (iT0='1' and oT0 ='0') then
                iT0Pulse <= x"F";
            end if;
            
        end if;
    end process;



    runcounter : process (timecode_clock) 
    begin
        if fifo_reset = '1' then
                RunTimer <= (others => '0');
        elsif rising_edge (timecode_clock) then
                RunTimer <= RunTimer +1;           
        end if;
    end process;
    
    
    lemo_out_siggen : process (D_LVDS_DCLK)
    begin
        if rising_edge(D_LVDS_DCLK) then
            veto_in <= LEMO3;
            
            if LEMO4_cntr = x"0000" then
                LEMO4 <= '0';
            else
               LEMO4_cntr <= LEMO4_cntr -1; 
            end if;
                        
--            if LEMO5_cntr = x"0000" then
--                LEMO5 <= '0';
--            else
--                LEMO5_cntr <= LEMO5_cntr - 1;
--            end if;
                     
            if daq_event_A = '1' or daq_event_B = '1' or daq_event_C = '1' or daq_event_D = '1'   then
                LEMO4 <= '1';
                LEMO4_cntr <= outsig_len;
            end if;

--            if daq_event_b = '1' then
--                LEMO5 <= '1';
--                LEMO5_cntr <= outsig_len;
--            end if;

         
        end if;
    end process;
    
    all_trigger_signals <= (not D_TRG) & (not C_TRG) & (not B_TRG) & (not A_TRG); 
    
    
    
    A_trigger_logic <= ((A_TRG(0) or TM(0)) and (A_TRG(1) or TM(1)) and 
                       (A_TRG(2) or TM(2)) and (A_TRG(3) or TM(3)) and
                       (A_TRG(4) or TM(4)) and (A_TRG(5) or TM(5)) and
                       (A_TRG(6) or TM(6)) and (A_TRG(7) or TM(7)) and
                       (A_TRG(8) or TM(8)) and (A_TRG(9) or TM(9)) and
                       (A_TRG(10) or TM(10)) and (A_TRG(11) or TM(11)) and
                       (A_TRG(12) or TM(12)) and (A_TRG(13) or TM(13)) and
                       (A_TRG(14) or TM(14)) and (A_TRG(15) or TM(15)) and
                       (A_TRG(16) or TM(16)) and (A_TRG(17) or TM(17)) and
                       (A_TRG(18) or TM(18)) and (A_TRG(19) or TM(19)) and
                       (A_TRG(20) or TM(20)) and (A_TRG(21) or TM(21)) and
                       (A_TRG(22) or TM(22)) and (A_TRG(23) or TM(23)) and
                       (A_TRG(24) or TM(24)) and (A_TRG(25) or TM(25)) and
                       (A_TRG(26) or TM(26)) and (A_TRG(27) or TM(27)) and
                       (A_TRG(28) or TM(28)) and (A_TRG(29) or TM(29)) and
                       (A_TRG(30) or TM(30)) and (A_TRG(31) or TM(31))) or cL_AsicDisable(0);
                       
    B_trigger_logic <= ((B_TRG(0) or TM(0)) and (B_TRG(1) or TM(1)) and 
                       (B_TRG(2) or TM(2)) and (B_TRG(3) or TM(3)) and
                       (B_TRG(4) or TM(4)) and (B_TRG(5) or TM(5)) and
                       (B_TRG(6) or TM(6)) and (B_TRG(7) or TM(7)) and
                       (B_TRG(8) or TM(8)) and (B_TRG(9) or TM(9)) and
                       (B_TRG(10) or TM(10)) and (B_TRG(11) or TM(11)) and
                       (B_TRG(12) or TM(12)) and (B_TRG(13) or TM(13)) and
                       (B_TRG(14) or TM(14)) and (B_TRG(15) or TM(15)) and
                       (B_TRG(16) or TM(16)) and (B_TRG(17) or TM(17)) and
                       (B_TRG(18) or TM(18)) and (B_TRG(19) or TM(19)) and
                       (B_TRG(20) or TM(20)) and (B_TRG(21) or TM(21)) and
                       (B_TRG(22) or TM(22)) and (B_TRG(23) or TM(23)) and
                       (B_TRG(24) or TM(24)) and (B_TRG(25) or TM(25)) and
                       (B_TRG(26) or TM(26)) and (B_TRG(27) or TM(27)) and
                       (B_TRG(28) or TM(28)) and (B_TRG(29) or TM(29)) and
                       (B_TRG(30) or TM(30)) and (B_TRG(31) or TM(31))) or cL_AsicDisable(1);    
                                          
    C_trigger_logic <= ((C_TRG(0) or TM(0)) and (C_TRG(1) or TM(1)) and 
                       (C_TRG(2) or TM(2)) and (C_TRG(3) or TM(3)) and
                       (C_TRG(4) or TM(4)) and (C_TRG(5) or TM(5)) and
                       (C_TRG(6) or TM(6)) and (C_TRG(7) or TM(7)) and
                       (C_TRG(8) or TM(8)) and (C_TRG(9) or TM(9)) and
                       (C_TRG(10) or TM(10)) and (C_TRG(11) or TM(11)) and
                       (C_TRG(12) or TM(12)) and (C_TRG(13) or TM(13)) and
                       (C_TRG(14) or TM(14)) and (C_TRG(15) or TM(15)) and
                       (C_TRG(16) or TM(16)) and (C_TRG(17) or TM(17)) and
                       (C_TRG(18) or TM(18)) and (C_TRG(19) or TM(19)) and
                       (C_TRG(20) or TM(20)) and (C_TRG(21) or TM(21)) and
                       (C_TRG(22) or TM(22)) and (C_TRG(23) or TM(23)) and
                       (C_TRG(24) or TM(24)) and (C_TRG(25) or TM(25)) and
                       (C_TRG(26) or TM(26)) and (C_TRG(27) or TM(27)) and
                       (C_TRG(28) or TM(28)) and (C_TRG(29) or TM(29)) and
                       (C_TRG(30) or TM(30)) and (C_TRG(31) or TM(31))) or cL_AsicDisable(2);                                                                 
 
     d_trigger_logic <= ((D_TRG(0) or TM(0)) and (D_TRG(1) or TM(1)) and 
                       (D_TRG(2) or TM(2)) and (D_TRG(3) or TM(3)) and
                       (D_TRG(4) or TM(4)) and (D_TRG(5) or TM(5)) and
                       (D_TRG(6) or TM(6)) and (D_TRG(7) or TM(7)) and
                       (D_TRG(8) or TM(8)) and (D_TRG(9) or TM(9)) and
                       (D_TRG(10) or TM(10)) and (D_TRG(11) or TM(11)) and
                       (D_TRG(12) or TM(12)) and (D_TRG(13) or TM(13)) and
                       (D_TRG(14) or TM(14)) and (D_TRG(15) or TM(15)) and
                       (D_TRG(16) or TM(16)) and (D_TRG(17) or TM(17)) and
                       (D_TRG(18) or TM(18)) and (D_TRG(19) or TM(19)) and
                       (D_TRG(20) or TM(20)) and (D_TRG(21) or TM(21)) and
                       (D_TRG(22) or TM(22)) and (D_TRG(23) or TM(23)) and
                       (D_TRG(24) or TM(24)) and (D_TRG(25) or TM(25)) and
                       (D_TRG(26) or TM(26)) and (D_TRG(27) or TM(27)) and
                       (D_TRG(28) or TM(28)) and (D_TRG(29) or TM(29)) and
                       (D_TRG(30) or TM(30)) and (D_TRG(31) or TM(31))) or cL_AsicDisable(3); 
                       
     common_trigger <= not (A_trigger_logic  and B_trigger_logic  and C_trigger_logic and D_trigger_logic);                   
      

       common_trigger_pusle : process (D_LVDS_DCLK)
        begin
            if rising_edge(D_LVDS_DCLK) then
                i_common_trigger <= common_trigger;
                o_common_trigger <= i_common_trigger;
                if counter_common_trigger = x"0" then
                    x_common_trigger <= '0';
                else
                    x_common_trigger <= '1';
                    counter_common_trigger <= counter_common_trigger -1;
                end if;
                if o_common_trigger = '0' and i_common_trigger = '1' then
                    counter_common_trigger <= x"F";
                end if;
            end if;
        end process;                 
    
     D_TRIG_EXT <= ipulser(0) or (x_common_trigger and REG_EnableCommonTrigger_WR(0)) or (LEMO2 and REG_EnableExtTrigger_WR(0));
     C_TRIG_EXT <= ipulser(1) or (x_common_trigger and REG_EnableCommonTrigger_WR(1)) or (LEMO2 and REG_EnableExtTrigger_WR(0));
     B_TRIG_EXT <= ipulser(2) or (x_common_trigger and REG_EnableCommonTrigger_WR(2)) or (LEMO2 and REG_EnableExtTrigger_WR(0));
     A_TRIG_EXT <= ipulser(3) or (x_common_trigger and REG_EnableCommonTrigger_WR(3)) or (LEMO2 and REG_EnableExtTrigger_WR(0));

      veto_enable_a <= REG_EnableExtVeto_WR(0);
      veto_enable_b <= REG_EnableExtVeto_WR(0);
      veto_enable_c <= REG_EnableExtVeto_WR(0);
      veto_enable_d <= REG_EnableExtVeto_WR(0);
                                         
    veto_a <= (veto_enable_a and veto_in) or sw_veto  ;
    veto_b <= (veto_enable_b and veto_in) or sw_veto;
    veto_c <= (veto_enable_c and veto_in) or sw_veto;
    veto_d <= (veto_enable_d and veto_in) or sw_veto;
    
      
    
                       
    f_BUS_DATA_RD <=     f_BUS_DATA_RD_A when    f_BUS_ADDR(31 downto 28) = x"0" else
                            f_BUS_DATA_RD_B when    f_BUS_ADDR(31 downto 28) = x"1" else x"DEAFBEEF";
                            
    f_BUS_DATASTROBE <= f_BUS_DATASTROBE_A  when    f_BUS_ADDR(31 downto 28) = x"0" else
                        f_BUS_DATASTROBE_B when    f_BUS_ADDR(31 downto 28) = x"1" else '0';

    f_BUS_INT_RD_A <= f_BUS_INT_RD  when    f_BUS_ADDR(31 downto 28) = x"0" else '0';
    f_BUS_INT_RD_B <= f_BUS_INT_RD  when    f_BUS_ADDR(31 downto 28) = x"1" else '0';
                
   -- A_raz_chn <= '1';
   -- B_raz_chn <= '1';      
    PT0 : petiroc_datareceiver Port map (  
              clk => D_LVDS_DCLK,
              trigger_in => A_trigger_logic, --trig_fake_pulse,
              hold_ext_trigger => EXT_Trig_FROM_HoldExt,
              hold_external_hold => hold_external_hold1,
              transmit_on => A_TRASMIT_ON,
              data_in => A_LVDS_DOUT,
              raz_chn_f => raz_chn_f,
              chrage_trig => chrage_trig_a,
              start_conv => A_START_CONV,
              raz_chn => A_raz_chn,
              daq_veto => veto_a,
              val_evnt => a_val_evt,
              daq_stroed_event => daq_event_stored_A,
              daq_event => daq_event_A,
              clk_timecode => CLK_320(0), 
              T0 =>  T0,                          
              fifo_clk => f_BUS_CLK,
              fifo_reset => fifo_reset,
              fifo_rd =>'0',
              fifo_datavalid => open,
              fifo_busy => open,
              fifo_data => open,
              RunTimer  => RunTimer,
              DataWordRun => ADataWordRun,
              delay_trigger => delay_trigger,
              DataWordT0 => ADataWordT0,
              DataWord => ADataWord,
              ValidWord => AValidWord,
              ResetValidWord => AResetValidWord,
              TriggerSelector => REG_TRGsel_WR(0)
    );
    
    
    PT1 : petiroc_datareceiver Port map (  
              clk => D_LVDS_DCLK,
              trigger_in => B_trigger_logic, --B_trigger_logic,
              hold_ext_trigger => EXT_Trig_FROM_HoldExt,
              hold_external_hold => hold_external_hold2,
              transmit_on => B_TRASMIT_ON,
              data_in => B_LVDS_DOUT,
              raz_chn_f => raz_chn_f,
              chrage_trig => chrage_trig_B,
              start_conv => B_START_CONV,
              raz_chn => B_raz_chn,
              val_evnt => b_val_evt,
              daq_veto => veto_b,
              daq_stroed_event => daq_event_stored_b,
              daq_event => daq_event_b,
              clk_timecode => CLK_320(0), 
              T0 =>  T0,                          
              fifo_clk => f_BUS_CLK,
              fifo_reset => fifo_reset,
              fifo_rd =>'0',
              fifo_datavalid => open,
              fifo_busy => open,
              fifo_data => open,
              RunTimer  => RunTimer,
              DataWordRun => BDataWordRun,
              delay_trigger => delay_trigger,
              DataWordT0 => BDataWordT0,
              DataWord => BDataWord,
              ValidWord => BValidWord,
              ResetValidWord => BResetValidWord,
              TriggerSelector => REG_TRGsel_WR(0) 
    );    
    
    
    PT2 : petiroc_datareceiver Port map (  
              clk => D_LVDS_DCLK,
              trigger_in => C_trigger_logic,
              hold_ext_trigger => EXT_Trig_FROM_HoldExt,
              hold_external_hold => hold_external_hold3,
              transmit_on => C_TRASMIT_ON,
              data_in => C_LVDS_DOUT,
              raz_chn_f => raz_chn_f,
              chrage_trig => chrage_trig_c,
              start_conv => C_START_CONV,
              raz_chn => C_raz_chn,
              val_evnt => c_val_evt,
              daq_veto => veto_C,
              daq_stroed_event => daq_event_stored_C,
              daq_event => daq_event_C,
              clk_timecode => CLK_320(0), 
              T0 =>  T0,                          
              fifo_clk => f_BUS_CLK,
              fifo_reset => fifo_reset,
              fifo_rd =>'0',
              fifo_datavalid => open,
              fifo_busy => open,
              fifo_data => open,
              RunTimer  => RunTimer,
              DataWordRun => CDataWordRun,
              delay_trigger => delay_trigger,
              DataWordT0 => CDataWordT0,
              DataWord => CDataWord,
              ValidWord => CValidWord,
              ResetValidWord => CResetValidWord,
              TriggerSelector => REG_TRGsel_WR(0) 
    );        
    
 
     PT3 : petiroc_datareceiver Port map (  
              clk => D_LVDS_DCLK,
              trigger_in => D_trigger_logic,
              hold_ext_trigger => EXT_Trig_FROM_HoldExt,
              hold_external_hold => hold_external_hold4,
              transmit_on => D_TRASMIT_ON,
              data_in => D_LVDS_DOUT,
              raz_chn_f => raz_chn_f,
              chrage_trig => chrage_trig_d,
              start_conv => D_START_CONV,
              raz_chn => D_raz_chn,
              val_evnt => d_val_evt,
              daq_veto => veto_D,
              daq_stroed_event => daq_event_stored_D,
              daq_event => daq_event_D,
              clk_timecode => CLK_320(0), 
              T0 =>  T0,                          
              fifo_clk => f_BUS_CLK,
              fifo_reset => fifo_reset,
              fifo_rd =>'0',
              fifo_datavalid => open,
              fifo_busy => open,
              fifo_data => open,
              RunTimer  => RunTimer,
              DataWordRun => DDataWordRun,
              delay_trigger => delay_trigger,
              DataWordT0 => DDataWordT0,
              DataWord => DDataWord,
              ValidWord => DValidWord,
              ResetValidWord => DResetValidWord,
              TriggerSelector => REG_TRGsel_WR(0) 
    );   
    arbiter : block
        signal SMARBITER : std_logic_vector (3 downto 0) := x"0";
        signal ARBITERID : integer range 0 to 63 := 0;
        signal RDO_FIFO_DIN : std_logic_vector (31 downto 0);
        signal RDO_FIFO_WE : std_logic_vector (0 downto 0) := "0";
        signal RDO_FIFO_FREE : std_logic_vector (0 downto 0) := "0";
        signal FIFODATALATCH : std_logic_vector (38*32-1 downto 0);
        signal IwriteF : integer range 0 to 63 := 0;
        signal FIFODV : std_logic;
        signal FIFOPROGFULL : std_logic;
        signal FIFOPROGEMPTY : std_logic;
    begin
    
    instRDO_LIST_FIFO: RDO_LIST_FIFO 
      PORT MAP(
        rst => fifo_reset,
        wr_clk => D_LVDS_DCLK,
        rd_clk => f_BUS_CLK,
        din => RDO_FIFO_DIN,
        wr_en => RDO_FIFO_WE(0),
        rd_en =>  ImageReadout_0_RD(0),
        dout => ImageReadout_0_READ_DATA,
        full => open, 
        empty =>open ,
        prog_full => FIFOPROGFULL,
        prog_empty => FIFOPROGEMPTY
      );
    
    
    RDO_FIFO_FREE(0) <= not FIFOPROGFULL;
    ImageReadout_0_VLD(0) <= not FIFOPROGEMPTY;
    fifo_busy_a <=  not FIFOPROGFULL;
    
    READOUT_ARBITER : PROCESS (D_LVDS_DCLK)
    begin
        if rising_edge(D_LVDS_DCLK) then
            AResetValidWord <= '0';
            BResetValidWord <= '0';
            CResetValidWord <= '0';
            DResetValidWord <= '0';
            RDO_FIFO_WE <= "0";
            
            sfifo_reset <= fifo_reset;
            ssfifo_reset <= sfifo_reset;
            
            if cFiforeset='1' then
                TotalEventCounter <= (others =>'0');
            end if;
            
            case SMARBITER is
                when x"0" =>
                    
                    case ARBITERID is
                        when 0 =>
                             if AValidWord = '1' and cL_AsicDisable(0) = '0' then
                                FIFODATALATCH(32*1-1 downto 32*0) <= x"80000000";
                                FIFODATALATCH(32*2-1 downto 32*1) <= ADataWordT0;
                                FIFODATALATCH(32*3-1 downto 32*2) <= ADataWordRun(31 downto 0);
                                FIFODATALATCH(32*4-1 downto 32*3) <= ADataWordRun(63 downto 32);
                                FIFODATALATCH(32*5-1 downto 32*4) <= TotalEventCounter;
                                FIFODATALATCH(32*37-1 downto 32*5) <= ADataWord;
                                FIFODATALATCH(32*38-1 downto 32*37) <= x"C0000000";
                                if RDO_FIFO_FREE = "1" then
                                    SMARBITER <= x"1";
                                end if; 
                                AResetValidWord <= '1';
                                IwriteF <= 0;
                                TotalEventCounter <= TotalEventCounter +1;
                             end if;
                             ARBITERID <= 1;
                        when 1 =>
                            if BValidWord = '1' and cL_AsicDisable(1) = '0' then
                               FIFODATALATCH(32*1-1 downto 32*0) <= x"80000001";
                               FIFODATALATCH(32*2-1 downto 32*1) <= BDataWordT0;
                               FIFODATALATCH(32*3-1 downto 32*2) <= BDataWordRun(31 downto 0);
                               FIFODATALATCH(32*4-1 downto 32*3) <= BDataWordRun(63 downto 32);
                               FIFODATALATCH(32*5-1 downto 32*4) <= TotalEventCounter;
                               FIFODATALATCH(32*37-1 downto 32*5) <= BDataWord;
                               FIFODATALATCH(32*38-1 downto 32*37) <= x"C0000000";
                               if RDO_FIFO_FREE = "1" then
                                    SMARBITER <= x"1";
                               end if; 
                               BResetValidWord <= '1';
                               IwriteF <= 0;
                               TotalEventCounter <= TotalEventCounter +1;
                            end if;
                            ARBITERID <= 2;                         
                        when 2 =>
                            if CValidWord = '1' and cL_AsicDisable(2) = '0' then
                               FIFODATALATCH(32*1-1 downto 32*0) <= x"80000002";
                               FIFODATALATCH(32*2-1 downto 32*1) <= CDataWordT0;
                               FIFODATALATCH(32*3-1 downto 32*2) <= CDataWordRun(31 downto 0);
                               FIFODATALATCH(32*4-1 downto 32*3) <= CDataWordRun(63 downto 32);
                               FIFODATALATCH(32*5-1 downto 32*4) <= TotalEventCounter;
                               FIFODATALATCH(32*37-1 downto 32*5) <= CDataWord;
                               FIFODATALATCH(32*38-1 downto 32*37) <= x"C0000000";
                               if RDO_FIFO_FREE = "1" then
                                    SMARBITER <= x"1";
                               end if; 
                               CResetValidWord <= '1';
                               IwriteF <= 0;
                               TotalEventCounter <= TotalEventCounter +1;
                            end if;
                            ARBITERID <= 3; 
                        when 3 => 
                            if DValidWord = '1' and cL_AsicDisable(3) = '0' then
                               FIFODATALATCH(32*1-1 downto 32*0) <= x"80000003";
                               FIFODATALATCH(32*2-1 downto 32*1) <= DDataWordT0;
                               FIFODATALATCH(32*3-1 downto 32*2) <= DDataWordRun(31 downto 0);
                               FIFODATALATCH(32*4-1 downto 32*3) <= DDataWordRun(63 downto 32);
                               FIFODATALATCH(32*5-1 downto 32*4) <= TotalEventCounter;
                               FIFODATALATCH(32*37-1 downto 32*5) <= DDataWord;
                               FIFODATALATCH(32*38-1 downto 32*37) <= x"C0000000";
                               if RDO_FIFO_FREE = "1" then
                                    SMARBITER <= x"1";
                               end if; 
                               DResetValidWord <= '1';
                               IwriteF <= 0;
                               TotalEventCounter <= TotalEventCounter +1;
                            end if;
                            ARBITERID <= 0; 
                        when others =>
                            ARBITERID <= 0;
                    end case;
                when x"1" =>
                
                    RDO_FIFO_DIN <= FIFODATALATCH((IwriteF+1)*32 -1 downto IwriteF*32);
                    RDO_FIFO_WE <= "1";
                    if IwriteF = 37 then
                        SMARBITER <= x"0";
                    else
                        IwriteF <= IwriteF +1;
                    end if;
                when others => 
                    SMARBITER <= x"0";
            end case;
        end if;
    end process;
    end block;
--    A_raz_chn <= D_raz_chn;
   --A_START_CONV <=  start_conv_glb;
--    D_START_CONV <= start_conv_glb;

    DB_Trig: delay_box
        Port Map( 
           clk => CLK_320(0),
           input_signal => LEMO2,
           output_signal => TrigINDelayed,
           delay_value => REG_HOLD_DELAY_CNTR_WR(15 downto 0)
           );

    EXT_Trig_FROM_HoldExt <= TrigINDelayed when REG_EXT_HOLD_EN_WR(0) = '1' else '0';


    hold_external_hold <= (hold_external_hold1 and (not cL_AsicDisable(0))) or
                            (hold_external_hold2 and (not cL_AsicDisable(1))) or
                            (hold_external_hold3 and (not cL_AsicDisable(2))) or
                            (hold_external_hold4 and (not cL_AsicDisable(3))) or
                             TrigINDelayed;
    A_HOLD_EXT <= hold_external_hold when REG_EXT_HOLD_EN_WR(0) = '1' else '0';
    B_HOLD_EXT <= hold_external_hold when REG_EXT_HOLD_EN_WR(0) = '1' else '0';
    C_HOLD_EXT <= hold_external_hold when REG_EXT_HOLD_EN_WR(0) = '1' else '0';
    D_HOLD_EXT <= hold_external_hold when REG_EXT_HOLD_EN_WR(0) = '1' else '0';
    
   D_DOUT_LVDS : IBUFDS
   generic map (
      DIFF_TERM => TRUE, 
      IBUF_LOW_PWR => TRUE,
      IOSTANDARD => "LVDS25")
   port map (
      O => D_LVDS_DOUTn, 
      I => D_LVDS_DOUT_P,
      IB => D_LVDS_DOUT_N
   );
   D_LVDS_DOUT <= not D_LVDS_DOUTn;
   
   D_CLK_LVDS : IBUFDS
   generic map (
      DIFF_TERM => TRUE, 
      IBUF_LOW_PWR => TRUE,
      IOSTANDARD => "LVDS25")
   port map (
      O => iD_LVDS_DCLK, 
      I => D_LVDS_DCLK_P,
      IB => D_LVDS_DCLK_N
   );   
   D_LVDS_DCLK <= not iD_LVDS_DCLK;
   
   C_DOUT_LVDS : IBUFDS
   generic map (
      DIFF_TERM => TRUE, 
      IBUF_LOW_PWR => TRUE,
      IOSTANDARD => "LVDS25")
   port map (
      O => C_LVDS_DOUTn, 
      I => C_LVDS_DOUT_P,
      IB => C_LVDS_DOUT_N
   );
     C_LVDS_DOUT <= not C_LVDS_DOUTn;
     
  A_DOUT_LVDS : IBUFDS
      generic map (
         DIFF_TERM => TRUE, 
         IBUF_LOW_PWR => TRUE,
         IOSTANDARD => "LVDS25")
      port map (
         O => A_LVDS_DOUT, 
         I => A_LVDS_DOUT_P,
         IB => A_LVDS_DOUT_N
      );
      
      
  B_DOUT_LVDS : IBUFDS
          generic map (
             DIFF_TERM => TRUE, 
             IBUF_LOW_PWR => TRUE,
             IOSTANDARD => "LVDS25")
          port map (
             O => B_LVDS_DOUT, 
             I => B_LVDS_DOUT_P,
             IB => B_LVDS_DOUT_N
          );
                
  CLK_40_LVDS : IBUFDS
          generic map (
             DIFF_TERM => TRUE, 
             IBUF_LOW_PWR => TRUE,
             IOSTANDARD => "LVDS25")
          port map (
             O => itimecode_clock, 
             I => CLK_40_P,
             IB => CLK_40_N
          );      
    timecode_clock <= not itimecode_clock;         
   
    
   pulse_gen : process(D_LVDS_DCLK)
   begin
    if rising_edge(D_LVDS_DCLK) then
    
        
        if trg_ext_cnt >= internal_pulser_pediod then
            trig_fake_pulse <= '0';
           -- A_START_CONV <= internal_pulser_enableA;
           -- B_START_CONV <= internal_pulser_enableB;
            ipulser(0) <= internal_pulser_enableA;
            ipulser(1) <= internal_pulser_enableB;
            ipulser(2) <= internal_pulser_enableC;
            ipulser(3) <= internal_pulser_enableD;
            
            trg_ext_cnt <= 0;
            
        else
            if trg_ext_cnt = 20 then
                trig_fake_pulse <= '1';
           --     A_START_CONV <= '0';
           --     B_START_CONV <= '0';
                ipulser(0) <= '0';
                ipulser(1) <= '0';
                ipulser(2) <= '0';
                ipulser(3) <= '0';
            end if;
            trg_ext_cnt <= trg_ext_cnt +1;
        end if;
    end if;
   end process;
   
   
   xpm_cdc_array_single_inst: xpm_cdc_array_single
     generic map (
   
       -- Common module generics
       DEST_SYNC_FF   => 4, -- integer; range: 2-10
       INIT_SYNC_FF   => 0, -- integer; 0=disable simulation init values, 1=enable simulation init values
       SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
       SRC_INPUT_REG  => 1, -- integer; 0=do not register input, 1=register input
       WIDTH          => 32  -- integer; range: 1-1024
   
     )
     port map (
   
       src_clk  => f_BUS_CLK,  -- optional; required when SRC_INPUT_REG = 1
       src_in   => L_AsicDisable,
       dest_clk => D_LVDS_DCLK,
       dest_out => cL_AsicDisable
     );

    xpm_cdc_single_inst: xpm_cdc_single
      generic map (
         DEST_SYNC_FF   => 4, -- integer; range: 2-10
         INIT_SYNC_FF   => 0, -- integer; 0=disable simulation init values, 1=enable simulation init values
         SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
         SRC_INPUT_REG  => 1  -- integer; 0=do not register input, 1=register input
      )
      port map (
         src_clk  => f_BUS_CLK,  -- optional; required when SRC_INPUT_REG = 1
         src_in   => REG_Fiforeset(0),
         dest_clk => D_LVDS_DCLK,
         dest_out => cFiforeset
      );


    latch_registers : process(f_BUS_CLK)
    begin
        if rising_edge(f_BUS_CLK) then
            if INT_AsicDisable = "1" then
                L_AsicDisable <= REG_AsicDisable;
            end if;
        end if;
    end process;

   T0sel <= REG_T0sel_WR(0);
   T0sw <= REG_T0sw_WR(0);

    f_BUS_CLK <= D_LVDS_DCLK;--FTDI_CLK;
	reset <= '0';
--
		
	USBInterface: ft600_fifo245_wrapper PORT MAP(
		FTDI_ADBUS => FTDI_ADBUS,
        FTDI_RXFN => FTDI_RXFN,
        FTDI_TXEN => FTDI_TXEN,
        FTDI_RDN => FTDI_RDN,
        FTDI_TXN => FTDI_TXN,
        FTDI_CLK => FTDI_CLK,
        FTDI_OEN => FTDI_OEN,
        FTDI_SIWU => FTDI_SIWU,
        FTDI_BE => FTDI_BE,
        f_CLK => f_BUS_CLK,

      -- Register interface          
        REG_ValEvt_RD => REG_ValEvt,
        REG_ValEvt_WR => REG_ValEvt,
        INT_ValEvt_RD => open,
        INT_ValEvt_WR => open,

        REG_Rstb_RD => REG_Rstb, 
        REG_Rstb_WR => REG_Rstb,
        INT_Rstb_RD => open,
        INT_Rstb_WR => open,

        REG_Startb_RD => REG_Startb, 
        REG_Startb_WR => REG_Startb,
        INT_Startb_RD => open,
        INT_Startb_WR => open,

        REG_Fiforeset_RD => REG_Fiforeset, 
        REG_Fiforeset_WR => REG_Fiforeset, 
        INT_Fiforeset_RD => open, 
        INT_Fiforeset_WR => open,
        
        REG_SelfTrigger_RD => REG_SelfTrigger, 
        REG_SelfTrigger_WR => REG_SelfTrigger, 
        INT_SelfTrigger_RD => open, 
        INT_SelfTrigger_WR => open, 
        
        REG_SelfTriggerPeriod_RD => REG_SelfTriggerPeriod, 
        REG_SelfTriggerPeriod_WR => REG_SelfTriggerPeriod, 
        INT_SelfTriggerPeriod_RD => open, 
        INT_SelfTriggerPeriod_WR => open, 

        REG_TriggerMode_RD => REG_TriggerMode,  
        REG_TriggerMode_WR => REG_TriggerMode, 
        INT_TriggerMode_RD => open,
        INT_TriggerMode_WR => open,         
        
        
        REG_T0sel_RD => REG_T0sel_WR,
        REG_T0sel_WR => REG_T0sel_WR,
        INT_T0sel_RD => open,
        INT_T0sel_WR => open,
                                
        REG_T0sw_RD => REG_T0sw_WR,
        REG_T0sw_WR => REG_T0sw_WR, 
        INT_T0sw_RD => open, 
        INT_T0sw_WR => open, 
                                
        REG_T0sw_mode_RD => REG_T0sw_mode_WR,
        REG_T0sw_mode_WR => REG_T0sw_mode_WR,
        INT_T0sw_mode_RD => open,
        INT_T0sw_mode_WR => open,
                                
        REG_T0sw_freq_RD => REG_T0sw_freq_WR,
        REG_T0sw_freq_WR => REG_T0sw_freq_WR,
        INT_T0sw_freq_RD => open,
        INT_T0sw_freq_WR => open,
        
	    REG_AsicDisable_RD => REG_AsicDisable, 
        REG_AsicDisable_WR => REG_AsicDisable, 
        INT_AsicDisable_RD => open, 
        INT_AsicDisable_WR => INT_AsicDisable, 
        
	    REG_AnalogReadout_RD => REG_AnalogReadout, 
        REG_AnalogReadout_WR => REG_AnalogReadout, 
        INT_AnalogReadout_RD => INT_AnalogReadout_RD, 
        INT_AnalogReadout_WR => INT_AnalogReadout_WR, 
                
	    REG_TRGsel_RD => REG_TRGsel_RD,
        REG_TRGsel_WR => REG_TRGsel_WR,
        INT_TRGsel_RD => INT_TRGsel_RD, 
        INT_TRGsel_WR => INT_TRGsel_WR, 
                
        REG_EnableCommonTrigger_RD => REG_EnableCommonTrigger_RD,
        REG_EnableCommonTrigger_WR => REG_EnableCommonTrigger_WR,
        INT_EnableCommonTrigger_RD => INT_EnableCommonTrigger_RD, 
        INT_EnableCommonTrigger_WR => open,
        
        REG_EnableExtVeto_RD => REG_EnableExtVeto_RD,
        REG_EnableExtVeto_WR => REG_EnableExtVeto_WR,
        INT_EnableExtVeto_RD => INT_EnableExtVeto_RD,  
        INT_EnableExtVeto_WR => INT_EnableExtVeto_WR,       
    
        REG_EnableExtTrigger_RD => REG_EnableExtTrigger_RD,
        REG_EnableExtTrigger_WR => REG_EnableExtTrigger_WR,
        INT_EnableExtTrigger_RD => INT_EnableExtTrigger_RD,  
        INT_EnableExtTrigger_WR => INT_EnableExtTrigger_WR, 
              
        REG_ResetTDCOnT0_RD => REG_ResetTDCOnT0_RD, 
        REG_ResetTDCOnT0_WR => REG_ResetTDCOnT0_WR, 
        INT_ResetTDCOnT0_RD => INT_ResetTDCOnT0_RD, 
        INT_ResetTDCOnT0_WR => INT_ResetTDCOnT0_WR,


        REG_HOLD_DELAY_CNTR_RD => REG_HOLD_DELAY_CNTR_RD, 
        REG_HOLD_DELAY_CNTR_WR => REG_HOLD_DELAY_CNTR_WR, 
        INT_HOLD_DELAY_CNTR_RD => INT_HOLD_DELAY_CNTR_RD, 
        INT_HOLD_DELAY_CNTR_WR => INT_HOLD_DELAY_CNTR_WR, 
        
        REG_EXT_HOLD_EN_RD => REG_EXT_HOLD_EN_RD, 
        REG_EXT_HOLD_EN_WR => REG_EXT_HOLD_EN_WR, 
        INT_REG_EXT_HOLD_EN_RD => INT_REG_EXT_HOLD_EN_RD, 
        INT_REG_EXT_HOLD_EN_WR => INT_REG_EXT_HOLD_EN_WR,    
                                                
      -- Fifo Interface
                
        BUS_ImageReadout_0_READ_DATA => ImageReadout_0_READ_DATA, 
        BUS_ImageReadout_0_WRITE_DATA => open,
        BUS_ImageReadout_0_W_INT => open,
        BUS_ImageReadout_0_R_INT => ImageReadout_0_RD, 
        BUS_ImageReadout_0_VLD => ImageReadout_0_VLD,
        REG_ImageReadout_0_READ_STATUS_RD => ImageReadout_0_WCNT,
        INT_ImageReadout_0_READ_STATUS_RD => open,
        
        --oscilloscope interface
          BUS_Oscilloscope_0_READ_DATA => BUS_Oscilloscope_0_READ_DATA,
          BUS_Oscilloscope_0_ADDRESS => BUS_Oscilloscope_0_ADDRESS, 
          BUS_Oscilloscope_0_WRITE_DATA => BUS_Oscilloscope_0_WRITE_DATA, 
          BUS_Oscilloscope_0_W_INT => BUS_Oscilloscope_0_W_INT, 
          BUS_Oscilloscope_0_R_INT => BUS_Oscilloscope_0_R_INT, 
          BUS_Oscilloscope_0_VLD => BUS_Oscilloscope_0_VLD,
          
          
    -- BUS Interface

        BUS_PROCCFG_0_READ_ADDRESS => BUS_PROCCFG_0_READ_ADDRESS,  
        BUS_PROCCFG_0_WRITE_DATA => BUS_PROCCFG_0_WRITE_DATA, 
        BUS_PROCCFG_0_W_INT => BUS_PROCCFG_0_W_INT, 
    
        BUS_PROCCFG_1_READ_ADDRESS => BUS_PROCCFG_1_READ_ADDRESS,  
        BUS_PROCCFG_1_WRITE_DATA => BUS_PROCCFG_1_WRITE_DATA, 
        BUS_PROCCFG_1_W_INT => BUS_PROCCFG_1_W_INT, 
    
        BUS_PROCCFG_2_READ_ADDRESS => BUS_PROCCFG_2_READ_ADDRESS,  
        BUS_PROCCFG_2_WRITE_DATA => BUS_PROCCFG_2_WRITE_DATA, 
        BUS_PROCCFG_2_W_INT => BUS_PROCCFG_2_W_INT, 
    
        BUS_PROCCFG_3_READ_ADDRESS => BUS_PROCCFG_3_READ_ADDRESS,  
        BUS_PROCCFG_3_WRITE_DATA => BUS_PROCCFG_3_WRITE_DATA, 
        BUS_PROCCFG_3_W_INT => BUS_PROCCFG_3_W_INT, 

        BUS_CLKCFG_READ_ADDRESS => BUS_CLKCFG_READ_ADDRESS,  
        BUS_CLKCFG_WRITE_DATA => BUS_CLKCFG_WRITE_DATA, 
        BUS_CLKCFG_W_INT => BUS_CLKCFG_W_INT, 

    
    -- IIC Interface
        
        BUS_i2c_0_READ_DATA => BUS_i2c_0_READ_DATA, 
        BUS_i2c_0_WRITE_DATA => BUS_i2c_0_WRITE_DATA, 
        BUS_i2c_0_W_INT => BUS_i2c_0_W_INT, 
        BUS_i2c_0_R_INT => BUS_i2c_0_R_INT, 
        BUS_i2c_0_VLD => BUS_i2c_0_VLD, 
        REG_i2c_0_REG_CTRL_WR => REG_i2c_0_REG_CTRL_WR, 
        INT_i2c_0_REG_CTRL_WR => INT_i2c_0_REG_CTRL_WR, 
        REG_i2c_0_REG_MON_RD => REG_i2c_0_REG_MON_RD, 
        INT_i2c_0_REG_MON_RD => INT_i2c_0_REG_MON_RD, 
        
        REG_UNIQUE_RD =>x"1234FFAA", 
        REG_UNIQUE_WR => open, 

         
        REG_FIRMWARE_BUILD =>x"18100201",
        
      --FLASH CONTROLLER
        BUS_Flash_0_READ_DATA => BUS_Flash_0_READ_DATA,
        BUS_Flash_0_ADDRESS => BUS_Flash_0_ADDRESS, 
        BUS_Flash_0_WRITE_DATA => BUS_Flash_0_WRITE_DATA, 
        BUS_Flash_0_W_INT => BUS_Flash_0_W_INT, 
        BUS_Flash_0_R_INT => BUS_Flash_0_R_INT, 
        BUS_Flash_0_VLD => BUS_Flash_0_VLD, 
        
        REG_FLASH_CNTR_RD => REG_FLASH_CNTR_RD, 
        REG_FLASH_CNTR_WR => REG_FLASH_CNTR_WR, 
        INT_FLASH_CNTR_RD => INT_FLASH_CNTR_RD, 
        INT_FLASH_CNTR_WR => INT_FLASH_CNTR_WR, 
        
        REG_FLASH_ADDRESS_RD => REG_FLASH_ADDRESS_RD, 
        REG_FLASH_ADDRESS_WR => REG_FLASH_ADDRESS_WR, 
        INT_FLASH_ADDRESS_RD => INT_FLASH_ADDRESS_RD, 
        INT_FLASH_ADDRESS_WR => INT_FLASH_ADDRESS_WR,     
        
        
           
        
      --RATE METERS
      
        BUS_FQMETER_ADDRESS => BUS_FQMETER_ADDRESS,
        BUS_FQMETER_RD =>BUS_FQMETER_RD,        
        --LATO FPGA
        
        f_RESET => reset

                            
                      
        );
        
	--clk_100_adc_ce <= CK_CONFIG_DONE;
	CK_SPI_NSYNC <= '1';
	
	EXT_ready <= CK_CONFIG_DONE;
--    CDCE0 : init_clock_gen 
--        Generic map (ComponentBaseAddress => x"0000")
--        Port Map( clk => f_BUS_CLK,
--               CK_SPI_LE => CK_SPI_LE,
--               CK_SPI_CLK => CK_SPI_CLK,
--               CK_SPI_MOSI => CK_SPI_MOSI,
--               CK_PD => open,
--               CK_LOCK => '1',
--               CK_CONFIG_DONE => CK_CONFIG_DONE,
--               reset => '0',
--               reset_out => sys_reset,
--               REG_addr => BUS_CLKCFG_READ_ADDRESS,
--               REG_din => BUS_CLKCFG_WRITE_DATA,
--               REG_wrint => BUS_CLKCFG_W_INT(0)
--               );
    
    
        CDCE0 : init_clock_gen 
                   Generic map (ComponentBaseAddress => x"0000")
                   Port Map( clk => clk_100,
                          CK_SPI_LE => CK_SPI_LE,
                          CK_SPI_CLK => CK_SPI_CLK,
                          CK_SPI_MOSI => CK_SPI_MOSI,
                          CK_PD => open,
                          CK_LOCK => '1',
                          CK_CONFIG_DONE => CK_CONFIG_DONE,
                          reset => '0',
                          reset_out => sys_reset,
                          REG_addr => x"0000",
                          REG_din => x"00000000",
                          REG_wrint => '0'
                          );
               
    
               U47: i2c_master_v01
               Generic map(
                   CLK_FREQ =>80000000 ,
                   BAUD =>100000 )
               PORT MAP(
                   sys_clk => f_BUS_CLK,
                   sys_rst => '0',
                   start => i2c_0_REG_CTRL_LATCHED(8),
                   stop =>  i2c_0_REG_CTRL_LATCHED(9),
                   read => i2c_0_REG_CTRL_LATCHED(11),
                   write => i2c_0_REG_CTRL_LATCHED(12),
                   send_ack => i2c_0_REG_CTRL_LATCHED(10),
                   mstr_din => i2c_0_REG_CTRL_LATCHED(7 downto 0),
                   sda => iic_sda,
                   scl => iic_scl,
                   free => REG_i2c_0_REG_MON_RD(18),
                   rec_ack => REG_i2c_0_REG_MON_RD(16),
                   ready => REG_i2c_0_REG_MON_RD(17),
                   data_good => i2c_0_data_good(0),
                   core_state => open,
                   mstr_dout => i2c_0_dout
               );
               i2c_0_ready(0) <= REG_i2c_0_REG_MON_RD(9);
               U47_process_latch : process(f_BUS_CLK)
               begin
                   if rising_edge(f_BUS_CLK) then
                       if INT_i2c_0_REG_CTRL_WR = "1" then
                           i2c_0_REG_CTRL_LATCHED <= REG_i2c_0_REG_CTRL_WR; 
                       else
                           i2c_0_REG_CTRL_LATCHED <= (others => '0'); 
                       end if;
                       if i2c_0_data_good = "1" then
                           REG_i2c_0_REG_MON_RD(7 downto 0) <= i2c_0_dout; 
                       end if;
                   end if;
               end process;
               

  
    psc0: PetirocSlowControl 
           Generic map ( 
                  ComponentBaseAddress  => x"0000",
                  Halfbit => 10000)
           Port map (    
                   reset => '0',
                   clk => f_BUS_CLK,
                   PETIROC_CLK  => PETIROC_A_CLK, 
                   PETIROC_MOSI => PETIROC_A_MOSI, 
                   PETIROC_SLOAD => PETIROC_A_SLOAD, 
                   PETIROC_RESETB => PETIROC_A_RESETB, 
                   PETIROC_SELECT => PETIROC_A_SELECT,
                   REG_addr => BUS_PROCCFG_0_READ_ADDRESS,
                   REG_din => BUS_PROCCFG_0_WRITE_DATA,
                   REG_out => open,
                   REG_wrint => BUS_PROCCFG_0_W_INT(0),
                   REG_rdint => '0',
                   REG_rddv => open
                     );
    
       
    psc1: PetirocSlowControl 
            Generic map ( 
                   ComponentBaseAddress  => x"0000",
                   Halfbit => 10000)
            Port map (    
                    reset => '0',
                    clk => f_BUS_CLK,
                    PETIROC_CLK  => PETIROC_B_CLK, 
                    PETIROC_MOSI => PETIROC_B_MOSI, 
                    PETIROC_SLOAD => PETIROC_B_SLOAD, 
                    PETIROC_RESETB => PETIROC_B_RESETB, 
                    PETIROC_SELECT => PETIROC_B_SELECT,
                    REG_addr => BUS_PROCCFG_1_READ_ADDRESS,
                    REG_din => BUS_PROCCFG_1_WRITE_DATA,
                    REG_out => open,
                    REG_wrint => BUS_PROCCFG_1_W_INT(0),
                    REG_rdint => '0',
                    REG_rddv => open
                      );
                     
    psc2: PetirocSlowControl 
              Generic map ( 
                     ComponentBaseAddress  => x"0000",
                     Halfbit => 10000)
              Port map (    
                      reset => '0',
                      clk => f_BUS_CLK,
                      PETIROC_CLK  => PETIROC_C_CLK, 
                      PETIROC_MOSI => PETIROC_C_MOSI, 
                      PETIROC_SLOAD => PETIROC_C_SLOAD, 
                      PETIROC_RESETB => PETIROC_C_RESETB, 
                      PETIROC_SELECT => PETIROC_C_SELECT,
                      REG_addr => BUS_PROCCFG_2_READ_ADDRESS,
                      REG_din => BUS_PROCCFG_2_WRITE_DATA,
                      REG_out => open,
                      REG_wrint => BUS_PROCCFG_2_W_INT(0),
                      REG_rdint => '0',
                      REG_rddv => open
                        );                        

    psc3: PetirocSlowControl 
              Generic map ( 
                     ComponentBaseAddress  => x"0000",
                     Halfbit => 10000)
              Port map (    
                      reset => '0',
                      clk => f_BUS_CLK,
                      PETIROC_CLK  => PETIROC_D_CLK, 
                      PETIROC_MOSI => PETIROC_D_MOSI, 
                      PETIROC_SLOAD => PETIROC_D_SLOAD, 
                      PETIROC_RESETB => PETIROC_D_RESETB, 
                      PETIROC_SELECT => PETIROC_D_SELECT,
                      REG_addr => BUS_PROCCFG_3_READ_ADDRESS,
                      REG_din => BUS_PROCCFG_3_WRITE_DATA,
                      REG_out => open,
                      REG_wrint => BUS_PROCCFG_3_W_INT(0),
                      REG_rdint => '0',
                      REG_rddv => open
                        );    
                        

   
--   A_VAL_EVT_P <= a_val_evt;
--   A_VAL_EVT_N <= not a_val_evt;
   
   
--   B_VAL_EVT_P <=  b_val_evt;
--   B_VAL_EVT_N <=  not b_val_evt;

--   C_VAL_EVT_P <=c_val_evti;
--   C_VAL_EVT_N <= not c_val_evti;

--   D_VAL_EVT_P <= d_val_evt;
--   D_VAL_EVT_N <= not d_val_evt;
      
--   A_RAZ_CHN_P <=a_raz_chn;
--   A_RAZ_CHN_N <= not a_raz_chn;
   
   
--   b_raz_chn_i <= not b_raz_chn;
--   B_RAZ_CHN_P <= b_raz_chn_i;
--   B_RAZ_CHN_N <= not b_raz_chn_i;
   
   
--   C_RAZ_CHN_P <= c_raz_chn;
--   C_RAZ_CHN_N <= not c_raz_chn;
      
--   D_RAZ_CHN_P <= d_raz_chn_i;
--   D_RAZ_CHN_N <= not d_raz_chn_i;
   
   d_raz_chn_i <= not d_raz_chn;
   c_val_evti <= not c_val_evt;
   b_raz_chn_i <= not b_raz_chn;
   
   A_VAL : OBUFDS
   generic map (
      IOSTANDARD => "LVDS",
      SLEW => "SLOW")  
   port map (
      O => A_VAL_EVT_P,
      OB => A_VAL_EVT_N,
      I => a_val_evt 
   );
   
   
      
   B_VAL : OBUFDS
   generic map (
      IOSTANDARD => "LVDS",
      SLEW => "SLOW")  
   port map (
      O => B_VAL_EVT_P,
      OB => B_VAL_EVT_N,
      I => b_val_evt 
   );
  

   C_VAL : OBUFDS
   generic map (
      IOSTANDARD => "LVDS",
      SLEW => "SLOW")  
   port map (
      O => C_VAL_EVT_P,
      OB => C_VAL_EVT_N,
      I => c_val_evti 
   );  
   
 
   D_VAL : OBUFDS
   generic map (
      IOSTANDARD => "LVDS",
      SLEW => "SLOW")  
   port map (
      O => D_VAL_EVT_P,
      OB => D_VAL_EVT_N,
      I => d_val_evt 
   );   
   
   
   A_RAZ : OBUFDS
   generic map (
      IOSTANDARD => "LVDS",
      SLEW => "SLOW")  
   port map (
      O => A_RAZ_CHN_P,
      OB => A_RAZ_CHN_N,
      I => a_raz_chn 
   );
   
   B_RAZ : OBUFDS
   generic map (
      IOSTANDARD => "LVDS",
      SLEW => "SLOW")  
   port map (
      O => B_RAZ_CHN_P,
      OB => B_RAZ_CHN_N,
      I => b_raz_chn_i 
   );
      
   C_RAZ : OBUFDS
   generic map (
      IOSTANDARD => "LVDS",
      SLEW => "SLOW")  
   port map (
      O => C_RAZ_CHN_P,
      OB => C_RAZ_CHN_N,
      I => c_raz_chn 
   );     
      
   D_RAZ : OBUFDS
   generic map (
      IOSTANDARD => "LVDS",
      SLEW => "SLOW")  
   port map (
      O => D_RAZ_CHN_P,
      OB => D_RAZ_CHN_N,
      I => d_raz_chn_i 
   );      
   
   --a_val_evt <= REG_ValEvt(0);
   --b_val_evt <= REG_ValEvt(1);
   --c_val_evt <= REG_ValEvt(2);
   --d_val_evt <= REG_ValEvt(3);
   
   PETIROC_A_RSTB <= REG_Rstb(0) and (not fifo_reset) and ((not T0) or REG_ResetTDCOnT0_WR(0));
   PETIROC_B_RSTB <= REG_Rstb(1) and (not fifo_reset) and ((not T0) or REG_ResetTDCOnT0_WR(0));
   PETIROC_C_RSTB <= REG_Rstb(2) and (not fifo_reset) and ((not T0) or REG_ResetTDCOnT0_WR(0));
   PETIROC_D_RSTB <= REG_Rstb(3) and (not fifo_reset) and ((not T0) or REG_ResetTDCOnT0_WR(0));
   
                     
   A_STARTB_ADC_EXT <= REG_Startb(0);
   B_STARTB_ADC_EXT <= REG_Startb(1);
   C_STARTB_ADC_EXT <= REG_Startb(2);
   D_STARTB_ADC_EXT <= REG_Startb(3);
   
   
   fifo_reset <=  REG_Fiforeset(0);
   
   internal_pulser_enableA <= REG_SelfTrigger(0);
   internal_pulser_enableB <= REG_SelfTrigger(0);
   internal_pulser_enableC <= REG_SelfTrigger(0);
   internal_pulser_enableD <= REG_SelfTrigger(0);

   internal_pulser_pediod <= conv_integer(REG_SelfTriggerPeriod);
       
         
--       BUFGCE_1_inst : BUFGCE_1
--   port map (
--      O => clk_100_adc,   -- 1-bit output: Clock output
--      CE => clk_100_adc_ce, -- 1-bit input: Clock enable input for I0
--      I => clk_100    -- 1-bit input: Primary clock
--   );     
         
    ADCreset <=not EXT_READY;
   adcs:   adcs_top 
       Port map(
           
           reset => ADCreset,
           sCLK_100 => clk_100,
           ADC_1_CLK_A_P => ADC_1_CLK_A_P,
           ADC_1_CLK_A_N => ADC_1_CLK_A_N,
           ADC_1_FRAME_A_P => ADC_1_FRAME_A_P,
           ADC_1_FRAME_A_N => ADC_1_FRAME_A_N,
           ADC_1_DATA_A_P => ADC_1_DATA_A_P,
           ADC_1_DATA_A_N => ADC_1_DATA_A_N,
           ADC_1_DATA_B_P => ADC_1_DATA_B_P,
           ADC_1_DATA_B_N => ADC_1_DATA_B_N,
           SMADC_1_CSA => SMADC_1_CSA,
           SMADC_1_CSB => open,
           SMADC_1_CLK => SMADC_1_CLK,
           SMADC_1_MOSI => SMADC_1_MOSI,
           SMADC_1_RESET => SMADC_1_RESET,
           READOUT_CLK => CLK_ACQ(0),
           ADC_CLK_OUT => open,
           CH0 => ADC_A0,
           CH1 => ADC_A1,
           CH2 => ADC_A2,
           CH3 => ADC_A3, 
           CH4 => ADC_A4,
           CH5 => ADC_A5,
           CH6 => ADC_A6,
           CH7 => ADC_A7,
           CHv0_7 => open,
           inversion => ANALOG_INPUT_INVERSION,
           ADC_STATUS => open,
           ADC_READY => open
    );         
   
   CLK_ACQ <= CLK_80;
            
            
 --  CLK_ACQ(0) <=CLK_80;
   SMADC_1_PD <= '0';
   
   
       PAO : PetirocAsicOscilloscope 
           Port Map( sample_clk => CLK_ACQ(0),
                  bus_clk => f_BUS_CLK,
                  trgs_a => A_TRG,
                  trgs_b => B_TRG,
                  trgs_c => C_TRG,
                  trgs_d => D_TRG,
                  charge_mux_a => ADC_A1,
                  charge_mux_b => ADC_A3,
                  charge_mux_c => ADC_A5,
                  charge_mux_d => ADC_A7,
                  chrage_trig_a => chrage_trig_a,
                  chrage_trig_b => chrage_trig_b,
                  chrage_trig_c => chrage_trig_c,
                  chrage_trig_d => chrage_trig_d,
                  chrage_clk_a => chrage_clk_a,
                  chrage_clk_b => chrage_clk_b,
                  chrage_clk_c => chrage_clk_c,
                  chrage_clk_d => chrage_clk_d,           
                  chrage_srin_a => chrage_srin_a,
                  chrage_srin_b => chrage_srin_b,
                  chrage_srin_c => chrage_srin_c,
                  chrage_srin_d => chrage_srin_d,                  
                  an_probe_a => ADC_A0,
                  an_probe_b => ADC_A2,
                  an_probe_c => ADC_A4,
                  an_probe_d => ADC_A6,
                  dig_probe_a => dig_probe_a,
                  dig_probe_b => dig_probe_b,
                  dig_probe_c => dig_probe_c,
                  dig_probe_d => dig_probe_d,
                  lemo1 => LEMO0,
                  lemo2 => LEMO1,
                  lemo3 => LEMO2,
                  lemo4 => LEMO3,
                  trigger_a => A_trigger_logic,
                  trigger_b => B_trigger_logic,
                  trigger_c => C_trigger_logic,
                  trigger_d => D_trigger_logic,
                  trigb_mux_a => trigb_mux_a,
                  trigb_mux_b => trigb_mux_b,
                  trigb_mux_c => trigb_mux_c,
                  trigb_mux_d => trigb_mux_d,                                      
                  global_trigger => '0',
                  BUS_Oscilloscope_0_READ_DATA => BUS_Oscilloscope_0_READ_DATA,
                  BUS_Oscilloscope_0_ADDRESS => BUS_Oscilloscope_0_ADDRESS, 
                  BUS_Oscilloscope_0_WRITE_DATA => BUS_Oscilloscope_0_WRITE_DATA, 
                  BUS_Oscilloscope_0_W_INT => BUS_Oscilloscope_0_W_INT, 
                  BUS_Oscilloscope_0_R_INT => BUS_Oscilloscope_0_R_INT, 
                  BUS_Oscilloscope_0_VLD => BUS_Oscilloscope_0_VLD

                  );
       
--    bus_control : process (f_BUS_CLK)
--       begin
--           if rising_edge(f_BUS_CLK) then

--              if f_BUS_INT_WR = '1' then

--                if f_BUS_ADDR = x"00000000" then
--                    sw_veto <= '0';
--                end if;
                
--                 if f_BUS_ADDR = x"FFFFF900" then
--                   a_val_evt <= f_BUS_DATA_WR(0);
--                   b_val_evt <= f_BUS_DATA_WR(1);
--                   c_val_evt <= f_BUS_DATA_WR(2);
--                   d_val_evt <= f_BUS_DATA_WR(3);
--                 end if;                        
                                    
                 
--                 if f_BUS_ADDR = x"FFFFF902" then      
--                   PETIROC_A_RSTB <= f_BUS_DATA_WR(0);
--                   PETIROC_B_RSTB <= f_BUS_DATA_WR(1);
--                   PETIROC_C_RSTB <= f_BUS_DATA_WR(2);
--                   PETIROC_D_RSTB <= f_BUS_DATA_WR(3);
--                end if;
                
--               if f_BUS_ADDR = x"FFFFF903" then      
--                  raz_chn_f <= f_BUS_DATA_WR(0);
--               end if;   
 
              
--               if f_BUS_ADDR = x"FFFFF905" then      
--                 A_STARTB_ADC_EXT <= f_BUS_DATA_WR(0);
--                 B_STARTB_ADC_EXT <= f_BUS_DATA_WR(1);
--                 C_STARTB_ADC_EXT <= f_BUS_DATA_WR(2);
--                 D_STARTB_ADC_EXT <= f_BUS_DATA_WR(3);
--               end if;   
               
               
--               if f_BUS_ADDR = x"FFFFF906" then      
--                 delay_trigger <= f_BUS_DATA_WR(15 downto 0);
--               end if; 
               
--               if f_BUS_ADDR = x"FFFFF907" then      
--                 veto_enable_a <= f_BUS_DATA_WR(0);
--                 veto_enable_b <= f_BUS_DATA_WR(1);
--                 veto_enable_c <= f_BUS_DATA_WR(2);
--                 veto_enable_d <= f_BUS_DATA_WR(3);
--               end if;   

--               if f_BUS_ADDR = x"FFFFF908" then      
--                 fifo_reset <= f_BUS_DATA_WR(0);
--               end if;     
               
--               if f_BUS_ADDR = x"FFFFF909" then      
--                 T0sel <= f_BUS_DATA_WR(0);
--               end if;                                                               

--               if f_BUS_ADDR = x"FFFFF90A" then      
--                 T0sw <= f_BUS_DATA_WR(0);
--               end if;                                                               
                  
--               if f_BUS_ADDR = x"FFFFF90B" then      
--                 sw_veto <= f_BUS_DATA_WR(0);
--               end if;      
               
--               if f_BUS_ADDR = x"FFFFF90C" then      
--                 outsig_len <= f_BUS_DATA_WR(15 downto 0);
--               end if;      
               
--               if f_BUS_ADDR = x"FFFFF90D" then      
--                 internal_pulser_enableA <= f_BUS_DATA_WR(0);
--                 internal_pulser_enableB <= f_BUS_DATA_WR(0);
--                 internal_pulser_enableC <= f_BUS_DATA_WR(0);
--                 internal_pulser_enableD <= f_BUS_DATA_WR(0);
--               end if;                                   
               
--               if f_BUS_ADDR = x"FFFFF90E" then      
--                 internal_pulser_pediod <= conv_integer(f_BUS_DATA_WR);
--               end if;                                   
                         
                                      
--              end if;
              
--           end if;
           
--       end process;
       
   
    
FC : FlashController 
    Port Map(
            clk => f_BUS_CLK,
            BUS_Flash_0_READ_DATA => BUS_Flash_0_READ_DATA,
            BUS_Flash_0_ADDRESS => BUS_Flash_0_ADDRESS, 
            BUS_Flash_0_WRITE_DATA => BUS_Flash_0_WRITE_DATA, 
            BUS_Flash_0_W_INT => BUS_Flash_0_W_INT, 
            BUS_Flash_0_R_INT => BUS_Flash_0_R_INT, 
            BUS_Flash_0_VLD => BUS_Flash_0_VLD, 
            
            REG_FLASH_CNTR_RD => REG_FLASH_CNTR_RD, 
            REG_FLASH_CNTR_WR => REG_FLASH_CNTR_WR, 
            INT_FLASH_CNTR_RD => INT_FLASH_CNTR_RD, 
            INT_FLASH_CNTR_WR => INT_FLASH_CNTR_WR,  
            
            REG_FLASH_ADDRESS_RD => REG_FLASH_ADDRESS_RD, 
            REG_FLASH_ADDRESS_WR => REG_FLASH_ADDRESS_WR, 
            INT_FLASH_ADDRESS_RD => INT_FLASH_ADDRESS_RD, 
            INT_FLASH_ADDRESS_WR => INT_FLASH_ADDRESS_WR,             
            
            SPI_CS => FLASH_SPI_CS,
            SPI_DIN => FLASH_SPI_DIN,
            SPI_DOUT => FLASH_SPI_DOUT,
            SPI_CLK => FLASH_SPI_CLK 
    );
    
    
   STARTUPE2_inst : STARTUPE2
    generic map (
       PROG_USR => "FALSE",  -- Activate program event security feature. Requires encrypted bitstreams.
       SIM_CCLK_FREQ => 0.0  -- Set the Configuration Clock Frequency(ns) for simulation.
    )
    port map (
       CFGCLK => OPEN,       -- 1-bit output: Configuration main clock output
       CFGMCLK => cfg_clk,     -- 1-bit output: Configuration internal oscillator clock output
       EOS => done_sig,             -- 1-bit output: Active high output signal indicating the End Of Startup.
       PREQ => OPEN,           -- 1-bit output: PROGRAM request to fabric output
       CLK => cfg_clk,             -- 1-bit input: User start-up clock input
       GSR => '0',             -- 1-bit input: Global Set/Reset input (GSR cannot be used for the port name)
       GTS => '0',             -- 1-bit input: Global 3-state input (GTS cannot be used for the port name)
       KEYCLEARB => '0', -- 1-bit input: Clear AES Decrypter Key input from Battery-Backed RAM (BBRAM)
       PACK => '0',           -- 1-bit input: PROGRAM acknowledge input
       USRCCLKO => clock_prog_mux_out,   -- 1-bit input: User CCLK input
       USRCCLKTS => '0', -- 1-bit input: User CCLK 3-state enable input
       USRDONEO => '1',   -- 1-bit input: User DONE pin output control
       USRDONETS => '0'  -- 1-bit input: User DONE 3-state enable output
    );
         
     clock_prog_mux_out <= cfg_clk when done_sig = '0' else FLASH_SPI_CLK;
     
    MRM : MultichannelRateMeter 
         Generic MAP(
                 CHANNEL_COUNT => 128,
                 CLK_FREQ => 160000000
                 )
         Port MAP( clk => f_BUS_CLK,
                trigger => all_trigger_signals,
                reg_address => BUS_FQMETER_ADDRESS,
                reg_read => BUS_FQMETER_RD
     );
end Behavioral;

 