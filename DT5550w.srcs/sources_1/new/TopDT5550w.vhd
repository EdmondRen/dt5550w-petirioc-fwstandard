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

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

LIBRARY UNISIM;
USE UNISIM.VComponents.ALL;

LIBRARY xpm;
USE xpm.vcomponents.ALL;

ENTITY TopDT5550w IS
    PORT (
        --				CLK_P		: in STD_LOGIC;
        --				CLK_N		: in STD_LOGIC;
        --CLK_AUX_OUT_25 : OUT STD_LOGIC;

        CLK_AUX_OUT_1khz : OUT STD_LOGIC;

        FTDI_CLK : IN STD_LOGIC;
        FTDI_ADBUS : INOUT STD_LOGIC_VECTOR (31 DOWNTO 0);
        FTDI_BE : INOUT STD_LOGIC_VECTOR (3 DOWNTO 0);
        FTDI_RXFN : IN STD_LOGIC;
        FTDI_TXEN : IN STD_LOGIC;
        FTDI_TXN : OUT STD_LOGIC;
        FTDI_SIWU : OUT STD_LOGIC;
        FTDI_RDN : OUT STD_LOGIC;
        FTDI_OEN : OUT STD_LOGIC;

        --CDCE clock generator
        CK_SPI_LE : OUT STD_LOGIC;
        CK_SPI_CLK : OUT STD_LOGIC;
        CK_SPI_MOSI : OUT STD_LOGIC;
        CK_SPI_NSYNC : OUT STD_LOGIC;

        --i2c
        iic_scl : INOUT STD_LOGIC;
        iic_sda : INOUT STD_LOGIC;

        --petiroc A slow control
        PETIROC_A_CLK : OUT STD_LOGIC;
        PETIROC_A_MOSI : OUT STD_LOGIC;
        PETIROC_A_SLOAD : OUT STD_LOGIC;
        PETIROC_A_RESETB : OUT STD_LOGIC;
        PETIROC_A_SELECT : OUT STD_LOGIC;

        --petiroc B slow control
        PETIROC_B_CLK : OUT STD_LOGIC;
        PETIROC_B_MOSI : OUT STD_LOGIC;
        PETIROC_B_SLOAD : OUT STD_LOGIC;
        PETIROC_B_RESETB : OUT STD_LOGIC;
        PETIROC_B_SELECT : OUT STD_LOGIC;

        --petiroc C slow control
        PETIROC_C_CLK : OUT STD_LOGIC;
        PETIROC_C_MOSI : OUT STD_LOGIC;
        PETIROC_C_SLOAD : OUT STD_LOGIC;
        PETIROC_C_RESETB : OUT STD_LOGIC;
        PETIROC_C_SELECT : OUT STD_LOGIC;

        --petiroc D slow control
        PETIROC_D_CLK : OUT STD_LOGIC;
        PETIROC_D_MOSI : OUT STD_LOGIC;
        PETIROC_D_SLOAD : OUT STD_LOGIC;
        PETIROC_D_RESETB : OUT STD_LOGIC;
        PETIROC_D_SELECT : OUT STD_LOGIC;
        A_VAL_EVT_P : OUT STD_LOGIC;
        A_VAL_EVT_N : OUT STD_LOGIC;
        B_VAL_EVT_P : OUT STD_LOGIC;
        B_VAL_EVT_N : OUT STD_LOGIC;
        C_VAL_EVT_P : OUT STD_LOGIC;
        C_VAL_EVT_N : OUT STD_LOGIC;
        D_VAL_EVT_P : OUT STD_LOGIC;
        D_VAL_EVT_N : OUT STD_LOGIC;
        A_RAZ_CHN_P : OUT STD_LOGIC;
        A_RAZ_CHN_N : OUT STD_LOGIC;
        B_RAZ_CHN_P : OUT STD_LOGIC;
        B_RAZ_CHN_N : OUT STD_LOGIC;
        C_RAZ_CHN_P : OUT STD_LOGIC;
        C_RAZ_CHN_N : OUT STD_LOGIC;
        D_RAZ_CHN_P : OUT STD_LOGIC;
        D_RAZ_CHN_N : OUT STD_LOGIC;
        A_TRIG_EXT : OUT STD_LOGIC;
        C_TRIG_EXT : OUT STD_LOGIC;
        B_TRIG_EXT : OUT STD_LOGIC;
        D_TRIG_EXT : OUT STD_LOGIC;

        PETIROC_A_RSTB : OUT STD_LOGIC;
        PETIROC_B_RSTB : OUT STD_LOGIC;
        PETIROC_C_RSTB : OUT STD_LOGIC;
        PETIROC_D_RSTB : OUT STD_LOGIC;

        A_START_CONV : OUT STD_LOGIC;
        B_START_CONV : OUT STD_LOGIC;
        C_START_CONV : OUT STD_LOGIC;
        D_START_CONV : OUT STD_LOGIC;

        A_HOLD_EXT : OUT STD_LOGIC;
        B_HOLD_EXT : OUT STD_LOGIC;
        C_HOLD_EXT : OUT STD_LOGIC;
        D_HOLD_EXT : OUT STD_LOGIC;
        A_STARTB_ADC_EXT : OUT STD_LOGIC;
        B_STARTB_ADC_EXT : OUT STD_LOGIC;
        C_STARTB_ADC_EXT : OUT STD_LOGIC;
        D_STARTB_ADC_EXT : OUT STD_LOGIC;

        A_TRASMIT_ON : IN STD_LOGIC;
        B_TRASMIT_ON : IN STD_LOGIC;
        C_TRASMIT_ON : IN STD_LOGIC;
        D_TRASMIT_ON : IN STD_LOGIC;

        A_LVDS_DOUT_P : IN STD_LOGIC;
        A_LVDS_DOUT_N : IN STD_LOGIC;
        B_LVDS_DOUT_P : IN STD_LOGIC;
        B_LVDS_DOUT_N : IN STD_LOGIC;
        C_LVDS_DOUT_P : IN STD_LOGIC;
        C_LVDS_DOUT_N : IN STD_LOGIC;
        D_LVDS_DOUT_P : IN STD_LOGIC;
        D_LVDS_DOUT_N : IN STD_LOGIC;

        D_LVDS_DCLK_P : IN STD_LOGIC;
        D_LVDS_DCLK_N : IN STD_LOGIC;

        A_TRG : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        B_TRG : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        C_TRG : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        D_TRG : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        A_ANALOG_DIN : OUT STD_LOGIC;
        B_ANALOG_DIN : OUT STD_LOGIC;
        C_ANALOG_DIN : OUT STD_LOGIC;
        D_ANALOG_DIN : OUT STD_LOGIC;

        A_ANALOG_CLK : OUT STD_LOGIC;
        B_ANALOG_CLK : OUT STD_LOGIC;
        C_ANALOG_CLK : OUT STD_LOGIC;
        D_ANALOG_CLK : OUT STD_LOGIC;

        chrage_trig_a : IN STD_LOGIC;
        chrage_trig_b : IN STD_LOGIC;
        chrage_trig_c : IN STD_LOGIC;
        chrage_trig_d : IN STD_LOGIC;

        dig_probe_a : IN STD_LOGIC;
        dig_probe_b : IN STD_LOGIC;
        dig_probe_c : IN STD_LOGIC;
        dig_probe_d : IN STD_LOGIC;

        trigb_mux_a : IN STD_LOGIC;
        trigb_mux_b : IN STD_LOGIC;
        trigb_mux_c : IN STD_LOGIC;
        trigb_mux_d : IN STD_LOGIC;

        LEMO0 : IN STD_LOGIC;
        LEMO1 : IN STD_LOGIC;
        LEMO2 : IN STD_LOGIC;
        LEMO3 : IN STD_LOGIC;

        LEMO4 : OUT STD_LOGIC;
        LEMO5 : OUT STD_LOGIC;
        LEMO6 : OUT STD_LOGIC;
        LEMO7 : OUT STD_LOGIC;

        LEMO01_dir : OUT STD_LOGIC;
        LEMO23_dir : OUT STD_LOGIC;
        LEMO45_dir : OUT STD_LOGIC;
        LEMO67_dir : OUT STD_LOGIC;

        CLK_40_P : IN STD_LOGIC;
        CLK_40_N : IN STD_LOGIC;

        SMADC_1_RESET : OUT STD_LOGIC;
        ADC_1_CLK_A_P : IN STD_LOGIC;
        ADC_1_CLK_A_N : IN STD_LOGIC;
        ADC_1_FRAME_A_P : IN STD_LOGIC;
        ADC_1_FRAME_A_N : IN STD_LOGIC;
        ADC_1_DATA_A_P : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        ADC_1_DATA_A_N : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        ADC_1_DATA_B_P : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        ADC_1_DATA_B_N : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        SMADC_1_CSA : OUT STD_LOGIC;
        SMADC_1_CLK : OUT STD_LOGIC;
        SMADC_1_MOSI : OUT STD_LOGIC;
        SMADC_1_PD : OUT STD_LOGIC;
        FLASH_SPI_CS : OUT STD_LOGIC;
        FLASH_SPI_DIN : IN STD_LOGIC;
        FLASH_SPI_DOUT : OUT STD_LOGIC;

        UART_TTL_TX : OUT STD_LOGIC;
        UART_TTL_RX : OUT STD_LOGIC;

        clk_100 : STD_LOGIC

    );
END TopDT5550w;

ARCHITECTURE Behavioral OF TopDT5550w IS
    COMPONENT ft600_fifo245_wrapper IS
        PORT (
            FTDI_ADBUS : INOUT STD_LOGIC_VECTOR (31 DOWNTO 0);
            FTDI_BE : INOUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            FTDI_RXFN : IN STD_LOGIC; --EMPTY
            FTDI_TXEN : IN STD_LOGIC; --FULL
            FTDI_RDN : OUT STD_LOGIC; --READ ENABLE
            FTDI_TXN : OUT STD_LOGIC; --WRITE ENABLE
            FTDI_CLK : IN STD_LOGIC; --FTDI CLOCK
            FTDI_OEN : OUT STD_LOGIC; --OUTPUT ENABLE NEGATO LATO FTDI
            FTDI_SIWU : OUT STD_LOGIC; --COMMIT A PACKET IMMEDIATLY

            -- Register interface          
            REG_ValEvt_RD : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            REG_ValEvt_WR : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            INT_ValEvt_RD : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
            INT_ValEvt_WR : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);

            REG_Rstb_RD : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            REG_Rstb_WR : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            INT_Rstb_RD : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
            INT_Rstb_WR : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);

            REG_Startb_RD : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            REG_Startb_WR : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            INT_Startb_RD : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
            INT_Startb_WR : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);

            REG_Fiforeset_RD : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            REG_Fiforeset_WR : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            INT_Fiforeset_RD : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
            INT_Fiforeset_WR : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);

            REG_SelfTrigger_RD : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            REG_SelfTrigger_WR : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            INT_SelfTrigger_RD : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
            INT_SelfTrigger_WR : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);

            REG_SelfTriggerPeriod_RD : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            REG_SelfTriggerPeriod_WR : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            INT_SelfTriggerPeriod_RD : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
            INT_SelfTriggerPeriod_WR : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);

            REG_TriggerMode_RD : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            REG_TriggerMode_WR : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            INT_TriggerMode_RD : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
            INT_TriggerMode_WR : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);

            REG_T0sel_RD : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            REG_T0sel_WR : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            INT_T0sel_RD : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
            INT_T0sel_WR : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
            REG_RUNsel_RD : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            REG_RUNsel_WR : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            INT_RUNsel_RD : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
            INT_RUNsel_WR : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);

            REG_T0sw_RD : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            REG_T0sw_WR : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            INT_T0sw_RD : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
            INT_T0sw_WR : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);

            REG_T0sw_mode_RD : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            REG_T0sw_mode_WR : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            INT_T0sw_mode_RD : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
            INT_T0sw_mode_WR : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);

            REG_T0sw_freq_RD : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            REG_T0sw_freq_WR : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            INT_T0sw_freq_RD : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
            INT_T0sw_freq_WR : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);

            REG_AsicDisable_RD : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            REG_AsicDisable_WR : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            INT_AsicDisable_RD : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
            INT_AsicDisable_WR : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);

            REG_AnalogReadout_RD : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            REG_AnalogReadout_WR : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            INT_AnalogReadout_RD : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
            INT_AnalogReadout_WR : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
            REG_TRGsel_RD : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            REG_TRGsel_WR : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            INT_TRGsel_RD : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
            INT_TRGsel_WR : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);

            REG_EnableCommonTrigger_RD : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            REG_EnableCommonTrigger_WR : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            INT_EnableCommonTrigger_RD : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
            INT_EnableCommonTrigger_WR : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);

            REG_EnableExtVeto_RD : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            REG_EnableExtVeto_WR : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            INT_EnableExtVeto_RD : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
            INT_EnableExtVeto_WR : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);

            REG_EnableExtTrigger_RD : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            REG_EnableExtTrigger_WR : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            INT_EnableExtTrigger_RD : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
            INT_EnableExtTrigger_WR : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);

            REG_ResetTDCOnT0_RD : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            REG_ResetTDCOnT0_WR : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            INT_ResetTDCOnT0_RD : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
            INT_ResetTDCOnT0_WR : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);

            REG_HOLD_DELAY_CNTR_RD : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            REG_HOLD_DELAY_CNTR_WR : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            INT_HOLD_DELAY_CNTR_RD : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
            INT_HOLD_DELAY_CNTR_WR : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);

            REG_EXT_HOLD_EN_RD : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            REG_EXT_HOLD_EN_WR : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            INT_REG_EXT_HOLD_EN_RD : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
            INT_REG_EXT_HOLD_EN_WR : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);

            -- Fifo Interface

            BUS_ImageReadout_0_READ_DATA : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            BUS_ImageReadout_0_WRITE_DATA : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            BUS_ImageReadout_0_W_INT : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
            BUS_ImageReadout_0_R_INT : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
            BUS_ImageReadout_0_VLD : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
            REG_ImageReadout_0_READ_STATUS_RD : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            INT_ImageReadout_0_READ_STATUS_RD : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);

            --oscilloscope 
            BUS_Oscilloscope_0_READ_DATA : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            BUS_Oscilloscope_0_ADDRESS : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            BUS_Oscilloscope_0_WRITE_DATA : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            BUS_Oscilloscope_0_W_INT : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
            BUS_Oscilloscope_0_R_INT : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
            BUS_Oscilloscope_0_VLD : IN STD_LOGIC_VECTOR(0 DOWNTO 0);

            -- BUS Interface

            BUS_PROCCFG_0_READ_ADDRESS : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            BUS_PROCCFG_0_WRITE_DATA : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            BUS_PROCCFG_0_W_INT : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);

            BUS_PROCCFG_1_READ_ADDRESS : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            BUS_PROCCFG_1_WRITE_DATA : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            BUS_PROCCFG_1_W_INT : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);

            BUS_PROCCFG_2_READ_ADDRESS : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            BUS_PROCCFG_2_WRITE_DATA : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            BUS_PROCCFG_2_W_INT : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);

            BUS_PROCCFG_3_READ_ADDRESS : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            BUS_PROCCFG_3_WRITE_DATA : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            BUS_PROCCFG_3_W_INT : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);

            BUS_CLKCFG_READ_ADDRESS : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            BUS_CLKCFG_WRITE_DATA : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            BUS_CLKCFG_W_INT : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
            -- IIC Interface

            BUS_i2c_0_READ_DATA : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            BUS_i2c_0_WRITE_DATA : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            BUS_i2c_0_W_INT : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
            BUS_i2c_0_R_INT : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
            BUS_i2c_0_VLD : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
            REG_i2c_0_REG_CTRL_WR : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            INT_i2c_0_REG_CTRL_WR : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
            REG_i2c_0_REG_MON_RD : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            INT_i2c_0_REG_MON_RD : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);

            --FLASH CONTROLLER   
            BUS_Flash_0_READ_DATA : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            BUS_Flash_0_ADDRESS : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            BUS_Flash_0_WRITE_DATA : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            BUS_Flash_0_W_INT : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
            BUS_Flash_0_R_INT : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
            BUS_Flash_0_VLD : IN STD_LOGIC_VECTOR(0 DOWNTO 0);

            REG_FLASH_CNTR_RD : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            REG_FLASH_CNTR_WR : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            INT_FLASH_CNTR_RD : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
            INT_FLASH_CNTR_WR : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);

            REG_FLASH_ADDRESS_RD : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            REG_FLASH_ADDRESS_WR : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            INT_FLASH_ADDRESS_RD : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
            INT_FLASH_ADDRESS_WR : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);

            --
            BUS_FQMETER_ADDRESS : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            BUS_FQMETER_RD : IN STD_LOGIC_VECTOR(31 DOWNTO 0);

            REG_UNIQUE_RD : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            REG_UNIQUE_WR : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);

            REG_FIRMWARE_BUILD : IN STD_LOGIC_VECTOR(31 DOWNTO 0);

            --LATO FPGA
            f_CLK : IN STD_LOGIC;
            f_RESET : IN STD_LOGIC
        );

    END COMPONENT;

    COMPONENT adcs_top IS
        GENERIC (test_mode : STD_LOGIC := '0');
        PORT (
            Reset : IN STD_LOGIC;
            sCLK_100 : IN STD_LOGIC;

            SMADC_1_RESET : OUT STD_LOGIC;

            ADC_1_CLK_A_P : IN STD_LOGIC;
            ADC_1_CLK_A_N : IN STD_LOGIC;

            ADC_1_FRAME_A_P : IN STD_LOGIC;
            ADC_1_FRAME_A_N : IN STD_LOGIC;

            ADC_1_DATA_A_P : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            ADC_1_DATA_A_N : IN STD_LOGIC_VECTOR(7 DOWNTO 0);

            ADC_1_DATA_B_P : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            ADC_1_DATA_B_N : IN STD_LOGIC_VECTOR(7 DOWNTO 0);

            SMADC_1_CSA : OUT STD_LOGIC;
            SMADC_1_CSB : OUT STD_LOGIC;
            SMADC_1_CLK : OUT STD_LOGIC;
            SMADC_1_MOSI : OUT STD_LOGIC;

            READOUT_CLK : IN STD_LOGIC;
            ADC_CLK_OUT : OUT STD_LOGIC;

            CH0 : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
            CH1 : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
            CH2 : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
            CH3 : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
            CH4 : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
            CH5 : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
            CH6 : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
            CH7 : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);

            CHv0_7 : OUT STD_LOGIC;

            inversion : IN STD_LOGIC_VECTOR(7 DOWNTO 0);

            ADC_STATUS : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
            ADC_READY : OUT STD_LOGIC

        );
    END COMPONENT;
    COMPONENT init_clock_gen IS
        GENERIC (ComponentBaseAddress : STD_LOGIC_VECTOR(15 DOWNTO 0));
        PORT (
            clk : IN STD_LOGIC;
            CK_SPI_LE : OUT STD_LOGIC;
            CK_SPI_CLK : OUT STD_LOGIC;
            CK_SPI_MOSI : OUT STD_LOGIC;
            CK_PD : OUT STD_LOGIC;
            CK_LOCK : IN STD_LOGIC;
            CK_CONFIG_DONE : OUT STD_LOGIC := '0';
            reset : IN STD_LOGIC;
            reset_out : OUT STD_LOGIC;
            REG_addr : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
            REG_din : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
            REG_wrint : IN STD_LOGIC
        );
    END COMPONENT;

    COMPONENT Clock_Divider is
        PORT (
            clk : IN STD_LOGIC;
            reset : IN STD_LOGIC;
            clock_out : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT i2c_master_v01
        GENERIC (
            CLK_FREQ : NATURAL := 80000000;
            BAUD : NATURAL := 100000
        );
        PORT (
            sys_clk : IN STD_LOGIC;
            sys_rst : IN STD_LOGIC;
            start : IN STD_LOGIC;
            stop : IN STD_LOGIC;
            read : IN STD_LOGIC;
            write : IN STD_LOGIC;
            send_ack : IN STD_LOGIC;
            mstr_din : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
            sda : INOUT STD_LOGIC;
            scl : INOUT STD_LOGIC;
            free : OUT STD_LOGIC;
            rec_ack : OUT STD_LOGIC;
            ready : OUT STD_LOGIC;
            data_good : OUT STD_LOGIC;
            core_state : OUT STD_LOGIC_VECTOR (5 DOWNTO 0);
            mstr_dout : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
        );
    END COMPONENT;
    COMPONENT PetirocSlowControl IS
        GENERIC (
            ComponentBaseAddress : STD_LOGIC_VECTOR(15 DOWNTO 0);
            Halfbit : INTEGER := 10000);
        PORT (
            reset : IN STD_LOGIC;
            clk : IN STD_LOGIC;
            PETIROC_CLK : OUT STD_LOGIC;
            PETIROC_MOSI : OUT STD_LOGIC;
            PETIROC_SLOAD : OUT STD_LOGIC;
            PETIROC_RESETB : OUT STD_LOGIC;
            PETIROC_SELECT : OUT STD_LOGIC;
            REG_addr : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
            REG_din : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
            REG_out : INOUT STD_LOGIC_VECTOR (31 DOWNTO 0);
            REG_wrint : IN STD_LOGIC;
            REG_rdint : IN STD_LOGIC;
            REG_rddv : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT petiroc_datareceiver IS
        PORT (
            clk : IN STD_LOGIC;
            trigger_in : IN STD_LOGIC;
            hold_ext_trigger : IN STD_LOGIC;
            hold_external_hold : OUT STD_LOGIC;
            transmit_on : IN STD_LOGIC;
            data_in : IN STD_LOGIC;
            raz_chn_f : IN STD_LOGIC;
            chrage_trig : IN STD_LOGIC;
            start_conv : OUT STD_LOGIC;
            raz_chn : OUT STD_LOGIC;
            val_evnt : OUT STD_LOGIC;
            daq_veto : IN STD_LOGIC;
            daq_stroed_event : OUT STD_LOGIC;
            daq_event : OUT STD_LOGIC;
            clk_timecode : IN STD_LOGIC;
            T0 : IN STD_LOGIC;
            fifo_clk : IN STD_LOGIC;
            fifo_reset : IN STD_LOGIC;
            fifo_rd : IN STD_LOGIC;
            fifo_datavalid : OUT STD_LOGIC;
            fifo_busy : OUT STD_LOGIC;
            RunTimer : IN STD_LOGIC_VECTOR (64 - 1 DOWNTO 0);
            fifo_data : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            delay_trigger : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            DataWordT0 : OUT STD_LOGIC_VECTOR (32 - 1 DOWNTO 0);
            DataWordRun : OUT STD_LOGIC_VECTOR (64 - 1 DOWNTO 0);
            DataWord : OUT STD_LOGIC_VECTOR (32 * 32 - 1 DOWNTO 0);
            ValidWord : OUT STD_LOGIC;
            ResetValidWord : IN STD_LOGIC;
            TriggerSelector : IN STD_LOGIC
        );
    END COMPONENT;

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

    COMPONENT FlashController IS
        PORT (
            clk : IN STD_LOGIC;
            BUS_Flash_0_READ_DATA : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            BUS_Flash_0_ADDRESS : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            BUS_Flash_0_WRITE_DATA : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            BUS_Flash_0_W_INT : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
            BUS_Flash_0_R_INT : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
            BUS_Flash_0_VLD : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);

            REG_FLASH_CNTR_RD : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            REG_FLASH_CNTR_WR : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            INT_FLASH_CNTR_RD : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
            INT_FLASH_CNTR_WR : IN STD_LOGIC_VECTOR(0 DOWNTO 0);

            REG_FLASH_ADDRESS_RD : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            REG_FLASH_ADDRESS_WR : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            INT_FLASH_ADDRESS_RD : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
            INT_FLASH_ADDRESS_WR : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
            SPI_CS : OUT STD_LOGIC;
            SPI_DIN : IN STD_LOGIC;
            SPI_DOUT : OUT STD_LOGIC;
            SPI_CLK : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT DTClockGenerator
        PORT (
            SIGNAL clk_out1 : OUT STD_LOGIC;
            SIGNAL clk_out2 : OUT STD_LOGIC;
            SIGNAL clk_out3 : OUT STD_LOGIC;
            SIGNAL clk_out4 : OUT STD_LOGIC;
            SIGNAL clk_out5 : OUT STD_LOGIC;
            SIGNAL locked : OUT STD_LOGIC;
            SIGNAL clk_in1 : IN STD_LOGIC
        );
    END COMPONENT;

    COMPONENT PetirocAsicOscilloscope
        PORT (
            sample_clk : IN STD_LOGIC;
            bus_clk : IN STD_LOGIC;
            trgs_a : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
            trgs_b : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
            trgs_c : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
            trgs_d : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
            charge_mux_a : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
            charge_mux_b : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
            charge_mux_c : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
            charge_mux_d : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
            chrage_clk_a : IN STD_LOGIC;
            chrage_clk_b : IN STD_LOGIC;
            chrage_clk_c : IN STD_LOGIC;
            chrage_clk_d : IN STD_LOGIC;
            chrage_srin_a : IN STD_LOGIC;
            chrage_srin_b : IN STD_LOGIC;
            chrage_srin_c : IN STD_LOGIC;
            chrage_srin_d : IN STD_LOGIC;
            chrage_trig_a : IN STD_LOGIC;
            chrage_trig_b : IN STD_LOGIC;
            chrage_trig_c : IN STD_LOGIC;
            chrage_trig_d : IN STD_LOGIC;
            an_probe_a : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
            an_probe_b : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
            an_probe_c : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
            an_probe_d : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
            dig_probe_a : IN STD_LOGIC;
            dig_probe_b : IN STD_LOGIC;
            dig_probe_c : IN STD_LOGIC;
            dig_probe_d : IN STD_LOGIC;
            lemo1 : IN STD_LOGIC;
            lemo2 : IN STD_LOGIC;
            lemo3 : IN STD_LOGIC;
            lemo4 : IN STD_LOGIC;
            trigger_a : IN STD_LOGIC;
            trigger_b : IN STD_LOGIC;
            trigger_c : IN STD_LOGIC;
            trigger_d : IN STD_LOGIC;
            trigb_mux_a : IN STD_LOGIC;
            trigb_mux_b : IN STD_LOGIC;
            trigb_mux_c : IN STD_LOGIC;
            trigb_mux_d : IN STD_LOGIC;
            global_trigger : IN STD_LOGIC;
            BUS_Oscilloscope_0_READ_DATA : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            BUS_Oscilloscope_0_ADDRESS : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            BUS_Oscilloscope_0_WRITE_DATA : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            BUS_Oscilloscope_0_W_INT : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
            BUS_Oscilloscope_0_R_INT : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
            BUS_Oscilloscope_0_VLD : OUT STD_LOGIC_VECTOR(0 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT PetirocAnalogMonitor
        GENERIC (CLKDIV : INTEGER := 10);
        PORT (
            clk : IN STD_LOGIC;
            A_trigger_logic : IN STD_LOGIC;
            chrage_srin_a : OUT STD_LOGIC;
            chrage_clk_a : OUT STD_LOGIC;
            raz_signal : OUT STD_LOGIC;
            enable : IN STD_LOGIC
        );
    END COMPONENT;
    COMPONENT MultichannelRateMeter IS
        GENERIC (
            CHANNEL_COUNT : INTEGER := 127;
            CLK_FREQ : INTEGER := 160000000
        );
        PORT (
            clk : IN STD_LOGIC;
            trigger : IN STD_LOGIC_VECTOR (CHANNEL_COUNT - 1 DOWNTO 0);
            reg_address : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
            reg_read : OUT STD_LOGIC_VECTOR (31 DOWNTO 0));
    END COMPONENT;
    COMPONENT delay_box IS
        PORT (
            clk : IN STD_LOGIC;
            input_signal : IN STD_LOGIC;
            output_signal : OUT STD_LOGIC;
            delay_value : IN STD_LOGIC_VECTOR (15 DOWNTO 0));
    END COMPONENT;

    SIGNAL CLK_AUX_OUT_25 : STD_LOGIC;

    SIGNAL reset : STD_LOGIC := '0';

    SIGNAL f_BUS_ADDR : STD_LOGIC_VECTOR(31 DOWNTO 0); --INDIRIZZO DI LETTURA/SCRITTURA

    SIGNAL f_BUS_CLK : STD_LOGIC; --CLOCK BUS

    --DA FPGA A PC
    SIGNAL f_BUS_INT_RD : STD_LOGIC; --INTERRUPT DI LETTURA
    SIGNAL f_BUS_DATASTROBE : STD_LOGIC; --CONFERMA CHE I DATI RICHIESTI SONO DISPONIBILI
    SIGNAL f_BUS_DATA_RD : STD_LOGIC_VECTOR(31 DOWNTO 0); --DATI DA INVIARE AL PC
    SIGNAL f_MODE : STD_LOGIC; --0 IL SEGNALE DATASROBE E' ABILITAO, 1 DATI CAMPIONATI UN CICLO DOPO INT_RD

    --DA PC A FPGA
    SIGNAL f_BUS_INT_WR : STD_LOGIC; --INTERRUPT DI SCRITTURA
    SIGNAL f_BUS_DATA_WR : STD_LOGIC_VECTOR(31 DOWNTO 0); --DATI DA INVIATI DAL PC
    SIGNAL cntr : STD_LOGIC_VECTOR(31 DOWNTO 0);

    SIGNAL CK_CONFIG_DONE : STD_LOGIC := '0';

    SIGNAL sys_reset : STD_LOGIC;

    SIGNAL a_val_evt : STD_LOGIC := '0';
    SIGNAL a_val_evti : STD_LOGIC := '0';
    SIGNAL b_val_evt : STD_LOGIC := '0';
    SIGNAL c_val_evt : STD_LOGIC := '0';
    SIGNAL c_val_evti : STD_LOGIC := '0';
    SIGNAL d_val_evt : STD_LOGIC := '0';

    SIGNAL a_raz_chn : STD_LOGIC := '0';
    SIGNAL b_raz_chn : STD_LOGIC := '0';
    SIGNAL b_raz_chn_i : STD_LOGIC := '0';
    SIGNAL c_raz_chn : STD_LOGIC := '0';
    SIGNAL d_raz_chn : STD_LOGIC := '1';
    SIGNAL raz_chn_f : STD_LOGIC := '1';
    SIGNAL d_raz_chn_i : STD_LOGIC := '0';

    SIGNAL A_LVDS_DOUT : STD_LOGIC;
    SIGNAL B_LVDS_DOUT : STD_LOGIC;
    SIGNAL D_LVDS_DOUT : STD_LOGIC;
    SIGNAL D_LVDS_DOUTn : STD_LOGIC;
    SIGNAL C_LVDS_DOUT : STD_LOGIC;
    SIGNAL C_LVDS_DOUTn : STD_LOGIC;

    SIGNAL D_LVDS_DCLK : STD_LOGIC;
    SIGNAL iD_LVDS_DCLK : STD_LOGIC;

    SIGNAL trg_ext_cnt : INTEGER RANGE 0 TO 1000000 := 0;

    SIGNAL A_trigger_logic : STD_LOGIC := '0';
    SIGNAL B_trigger_logic : STD_LOGIC := '0';
    SIGNAL C_trigger_logic : STD_LOGIC := '0';
    SIGNAL D_trigger_logic : STD_LOGIC := '0';

    SIGNAL delay_trigger : STD_LOGIC_VECTOR (15 DOWNTO 0) := x"0000";

    SIGNAL start_conv_glb : STD_LOGIC;
    SIGNAL TM : STD_LOGIC_VECTOR (31 DOWNTO 0) := x"00000000";

    SIGNAL veto_in : STD_LOGIC;
    SIGNAL veto_enable_a : STD_LOGIC := '0';
    SIGNAL veto_enable_b : STD_LOGIC := '0';
    SIGNAL veto_enable_c : STD_LOGIC := '0';
    SIGNAL veto_enable_d : STD_LOGIC := '0';

    SIGNAL veto_a : STD_LOGIC;
    SIGNAL veto_b : STD_LOGIC;
    SIGNAL veto_c : STD_LOGIC;
    SIGNAL veto_d : STD_LOGIC;

    SIGNAL fifo_reset : STD_LOGIC := '0';

    SIGNAL daq_event_A : STD_LOGIC;
    SIGNAL daq_event_B : STD_LOGIC;
    SIGNAL daq_event_C : STD_LOGIC;
    SIGNAL daq_event_D : STD_LOGIC;

    SIGNAL daq_event_stored_A : STD_LOGIC;
    SIGNAL daq_event_stored_B : STD_LOGIC;
    SIGNAL daq_event_stored_C : STD_LOGIC;
    SIGNAL daq_event_stored_D : STD_LOGIC;

    SIGNAL fifo_busy_a : STD_LOGIC;
    SIGNAL fifo_busy_b : STD_LOGIC;
    SIGNAL fifo_busy_c : STD_LOGIC;
    SIGNAL fifo_busy_d : STD_LOGIC;

    SIGNAL timecode_clock : STD_LOGIC;
    SIGNAL itimecode_clock : STD_LOGIC;
    SIGNAL T0 : STD_LOGIC;

    SIGNAL T0sel : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";
    SIGNAL T0sw : STD_LOGIC := '0';

    SIGNAL LEMO4_cntr : STD_LOGIC_VECTOR(15 DOWNTO 0) := x"0000";
    SIGNAL LEMO5_cntr : STD_LOGIC_VECTOR(15 DOWNTO 0) := x"0000";
    SIGNAL LEMO6_cntr : STD_LOGIC_VECTOR(15 DOWNTO 0) := x"0000";
    SIGNAL LEMO7_cntr : STD_LOGIC_VECTOR(15 DOWNTO 0) := x"0000";

    SIGNAL outsig_len : STD_LOGIC_VECTOR(15 DOWNTO 0) := x"0010";

    SIGNAL sw_veto : STD_LOGIC := '0';

    SIGNAL internal_pulser_pediod : INTEGER := 160000;
    SIGNAL internal_pulser_enableA : STD_LOGIC := '0';
    SIGNAL internal_pulser_enableB : STD_LOGIC := '0';
    SIGNAL internal_pulser_enableC : STD_LOGIC := '0';
    SIGNAL internal_pulser_enableD : STD_LOGIC := '0';
    SIGNAL f_BUS_DATA_RD_A : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL f_BUS_DATA_RD_B : STD_LOGIC_VECTOR(31 DOWNTO 0);

    SIGNAL f_BUS_DATASTROBE_A : STD_LOGIC;
    SIGNAL f_BUS_DATASTROBE_B : STD_LOGIC;

    SIGNAL f_BUS_INT_RD_A : STD_LOGIC;
    SIGNAL f_BUS_INT_RD_B : STD_LOGIC;
    SIGNAL BUS_i2c_0_READ_DATA : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL BUS_i2c_0_WRITE_DATA : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL BUS_i2c_0_W_INT : STD_LOGIC_VECTOR(0 DOWNTO 0);
    SIGNAL BUS_i2c_0_R_INT : STD_LOGIC_VECTOR(0 DOWNTO 0);
    SIGNAL BUS_i2c_0_VLD : STD_LOGIC_VECTOR(0 DOWNTO 0) := "1";
    SIGNAL REG_i2c_0_REG_CTRL_WR : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL INT_i2c_0_REG_CTRL_WR : STD_LOGIC_VECTOR(0 DOWNTO 0);
    SIGNAL REG_i2c_0_REG_MON_RD : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL INT_i2c_0_REG_MON_RD : STD_LOGIC_VECTOR(0 DOWNTO 0);

    SIGNAL BUS_Oscilloscope_0_READ_DATA : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL BUS_Oscilloscope_0_ADDRESS : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL BUS_Oscilloscope_0_WRITE_DATA : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL BUS_Oscilloscope_0_W_INT : STD_LOGIC_VECTOR(0 DOWNTO 0);
    SIGNAL BUS_Oscilloscope_0_R_INT : STD_LOGIC_VECTOR(0 DOWNTO 0);
    SIGNAL BUS_Oscilloscope_0_VLD : STD_LOGIC_VECTOR(0 DOWNTO 0);

    SIGNAL i2c_0_ready : STD_LOGIC_VECTOR(0 DOWNTO 0) := (OTHERS => '0');
    SIGNAL i2c_0_data_good : STD_LOGIC_VECTOR(0 DOWNTO 0) := (OTHERS => '0');
    SIGNAL i2c_0_rec_ack : STD_LOGIC_VECTOR(0 DOWNTO 0) := (OTHERS => '0');
    SIGNAL i2c_0_dout : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
    SIGNAL i2c_0_REG_CTRL_LATCHED : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
    SIGNAL REG_ValEvt : STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
    SIGNAL REG_Rstb : STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
    SIGNAL REG_Startb : STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
    SIGNAL REG_Fiforeset : STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');

    SIGNAL REG_T0sel_RD : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL REG_T0sel_WR : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL INT_T0sel_RD : STD_LOGIC_VECTOR(0 DOWNTO 0);
    SIGNAL INT_T0sel_WR : STD_LOGIC_VECTOR(0 DOWNTO 0);

    SIGNAL REG_RUNsel_RD : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL REG_RUNsel_WR : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL INT_RUNsel_RD : STD_LOGIC_VECTOR(0 DOWNTO 0);
    SIGNAL INT_RUNsel_WR : STD_LOGIC_VECTOR(0 DOWNTO 0);

    SIGNAL REG_T0sw_RD : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL REG_T0sw_WR : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL INT_T0sw_RD : STD_LOGIC_VECTOR(0 DOWNTO 0);
    SIGNAL INT_T0sw_WR : STD_LOGIC_VECTOR(0 DOWNTO 0);

    SIGNAL REG_T0sw_mode_RD : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL REG_T0sw_mode_WR : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL INT_T0sw_mode_RD : STD_LOGIC_VECTOR(0 DOWNTO 0);
    SIGNAL INT_T0sw_mode_WR : STD_LOGIC_VECTOR(0 DOWNTO 0);

    SIGNAL REG_T0sw_freq_RD : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL REG_T0sw_freq_WR : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL INT_T0sw_freq_RD : STD_LOGIC_VECTOR(0 DOWNTO 0);
    SIGNAL INT_T0sw_freq_WR : STD_LOGIC_VECTOR(0 DOWNTO 0);

    SIGNAL REG_TRGsel_RD : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL REG_TRGsel_WR : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL INT_TRGsel_RD : STD_LOGIC_VECTOR(0 DOWNTO 0);
    SIGNAL INT_TRGsel_WR : STD_LOGIC_VECTOR(0 DOWNTO 0);

    SIGNAL REG_EnableCommonTrigger_RD : STD_LOGIC_VECTOR(31 DOWNTO 0) := x"00000000";
    SIGNAL REG_EnableCommonTrigger_WR : STD_LOGIC_VECTOR(31 DOWNTO 0) := x"00000000";
    SIGNAL INT_EnableCommonTrigger_RD : STD_LOGIC_VECTOR(0 DOWNTO 0);
    SIGNAL REG_EnableExtVeto_RD : STD_LOGIC_VECTOR(31 DOWNTO 0) := x"00000000";
    SIGNAL REG_EnableExtVeto_WR : STD_LOGIC_VECTOR(31 DOWNTO 0) := x"00000000";
    SIGNAL INT_EnableExtVeto_RD : STD_LOGIC_VECTOR(0 DOWNTO 0);
    SIGNAL INT_EnableExtVeto_WR : STD_LOGIC_VECTOR(0 DOWNTO 0);

    SIGNAL REG_EnableExtTrigger_RD : STD_LOGIC_VECTOR(31 DOWNTO 0) := x"00000000";
    SIGNAL REG_EnableExtTrigger_WR : STD_LOGIC_VECTOR(31 DOWNTO 0) := x"00000000";
    SIGNAL INT_EnableExtTrigger_RD : STD_LOGIC_VECTOR(0 DOWNTO 0);
    SIGNAL INT_EnableExtTrigger_WR : STD_LOGIC_VECTOR(0 DOWNTO 0);

    SIGNAL REG_AsicDisable : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL INT_AsicDisable : STD_LOGIC_VECTOR(0 DOWNTO 0);
    SIGNAL REG_AnalogReadout : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL INT_AnalogReadout_RD : STD_LOGIC_VECTOR(0 DOWNTO 0);
    SIGNAL INT_AnalogReadout_WR : STD_LOGIC_VECTOR(0 DOWNTO 0);

    SIGNAL L_AsicDisable : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
    SIGNAL cL_AsicDisable : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');

    SIGNAL ImageReadout_0_READ_DATA : STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
    SIGNAL ImageReadout_0_RD : STD_LOGIC_VECTOR (0 DOWNTO 0) := (OTHERS => '0');
    SIGNAL ImageReadout_0_VLD : STD_LOGIC_VECTOR (0 DOWNTO 0) := (OTHERS => '0');
    SIGNAL ImageReadout_0_WCNT : STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
    SIGNAL BUS_PROCCFG_0_READ_ADDRESS : STD_LOGIC_VECTOR (15 DOWNTO 0) := (OTHERS => '0');
    SIGNAL BUS_PROCCFG_0_WRITE_DATA : STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
    SIGNAL BUS_PROCCFG_0_W_INT : STD_LOGIC_VECTOR (0 DOWNTO 0) := (OTHERS => '0');
    SIGNAL BUS_PROCCFG_1_READ_ADDRESS : STD_LOGIC_VECTOR (15 DOWNTO 0) := (OTHERS => '0');
    SIGNAL BUS_PROCCFG_1_WRITE_DATA : STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
    SIGNAL BUS_PROCCFG_1_W_INT : STD_LOGIC_VECTOR (0 DOWNTO 0) := (OTHERS => '0');
    SIGNAL BUS_PROCCFG_2_READ_ADDRESS : STD_LOGIC_VECTOR (15 DOWNTO 0) := (OTHERS => '0');
    SIGNAL BUS_PROCCFG_2_WRITE_DATA : STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
    SIGNAL BUS_PROCCFG_2_W_INT : STD_LOGIC_VECTOR (0 DOWNTO 0) := (OTHERS => '0');
    SIGNAL BUS_PROCCFG_3_READ_ADDRESS : STD_LOGIC_VECTOR (15 DOWNTO 0) := (OTHERS => '0');
    SIGNAL BUS_PROCCFG_3_WRITE_DATA : STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
    SIGNAL BUS_PROCCFG_3_W_INT : STD_LOGIC_VECTOR (0 DOWNTO 0) := (OTHERS => '0');
    SIGNAL BUS_CLKCFG_READ_ADDRESS : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
    SIGNAL BUS_CLKCFG_WRITE_DATA : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
    SIGNAL BUS_CLKCFG_W_INT : STD_LOGIC_VECTOR(0 DOWNTO 0) := (OTHERS => '0');

    SIGNAL REG_SelfTrigger : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
    SIGNAL REG_SelfTriggerPeriod : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
    SIGNAL REG_TriggerMode : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
    SIGNAL BUS_FQMETER_ADDRESS : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL BUS_FQMETER_RD : STD_LOGIC_VECTOR(31 DOWNTO 0);

    SIGNAL RunTimer : STD_LOGIC_VECTOR(63 DOWNTO 0) := (OTHERS => '0');

    ATTRIBUTE keep : STRING;

    ATTRIBUTE keep OF BUS_PROCCFG_0_READ_ADDRESS : SIGNAL IS "true";
    ATTRIBUTE keep OF BUS_PROCCFG_1_READ_ADDRESS : SIGNAL IS "true";
    ATTRIBUTE keep OF BUS_PROCCFG_2_READ_ADDRESS : SIGNAL IS "true";
    ATTRIBUTE keep OF BUS_PROCCFG_3_READ_ADDRESS : SIGNAL IS "true";

    ATTRIBUTE keep OF BUS_PROCCFG_0_WRITE_DATA : SIGNAL IS "true";
    ATTRIBUTE keep OF BUS_PROCCFG_1_WRITE_DATA : SIGNAL IS "true";
    ATTRIBUTE keep OF BUS_PROCCFG_2_WRITE_DATA : SIGNAL IS "true";
    ATTRIBUTE keep OF BUS_PROCCFG_3_WRITE_DATA : SIGNAL IS "true";

    ATTRIBUTE keep OF BUS_PROCCFG_0_W_INT : SIGNAL IS "true";
    ATTRIBUTE keep OF BUS_PROCCFG_1_W_INT : SIGNAL IS "true";
    ATTRIBUTE keep OF BUS_PROCCFG_2_W_INT : SIGNAL IS "true";
    ATTRIBUTE keep OF BUS_PROCCFG_3_W_INT : SIGNAL IS "true";

    SIGNAL TotalEventCounter : STD_LOGIC_VECTOR (32 - 1 DOWNTO 0) := (OTHERS => '0');
    SIGNAL ADataWordT0 : STD_LOGIC_VECTOR (32 - 1 DOWNTO 0);
    SIGNAL BDataWordT0 : STD_LOGIC_VECTOR (32 - 1 DOWNTO 0);
    SIGNAL CDataWordT0 : STD_LOGIC_VECTOR (32 - 1 DOWNTO 0);
    SIGNAL DDataWordT0 : STD_LOGIC_VECTOR (32 - 1 DOWNTO 0);
    SIGNAL ADataWordRun : STD_LOGIC_VECTOR (64 - 1 DOWNTO 0);
    SIGNAL BDataWordRun : STD_LOGIC_VECTOR (64 - 1 DOWNTO 0);
    SIGNAL CDataWordRun : STD_LOGIC_VECTOR (64 - 1 DOWNTO 0);
    SIGNAL DDataWordRun : STD_LOGIC_VECTOR (64 - 1 DOWNTO 0);

    SIGNAL ADataWord : STD_LOGIC_VECTOR (32 * 32 - 1 DOWNTO 0);
    SIGNAL BDataWord : STD_LOGIC_VECTOR (32 * 32 - 1 DOWNTO 0);
    SIGNAL CDataWord : STD_LOGIC_VECTOR (32 * 32 - 1 DOWNTO 0);
    SIGNAL DDataWord : STD_LOGIC_VECTOR (32 * 32 - 1 DOWNTO 0);
    SIGNAL AValidWord : STD_LOGIC := '0';
    SIGNAL BValidWord : STD_LOGIC := '0';
    SIGNAL CValidWord : STD_LOGIC := '0';
    SIGNAL DValidWord : STD_LOGIC := '0';
    SIGNAL AResetValidWord : STD_LOGIC := '0';
    SIGNAL BResetValidWord : STD_LOGIC := '0';
    SIGNAL CResetValidWord : STD_LOGIC := '0';
    SIGNAL DResetValidWord : STD_LOGIC := '0';
    SIGNAL sfifo_reset : STD_LOGIC := '0';
    SIGNAL ssfifo_reset : STD_LOGIC := '0';
    SIGNAL iT0 : STD_LOGIC;
    SIGNAL oT0 : STD_LOGIC;

    SIGNAL cFiforeset : STD_LOGIC := '0';
    SIGNAL clk_100_adc : STD_LOGIC := '0';
    SIGNAL clk_100_adc_ce : STD_LOGIC := '0';
    SIGNAL CLK_80 : STD_LOGIC_VECTOR(0 DOWNTO 0);
    SIGNAL CLK_40 : STD_LOGIC_VECTOR(0 DOWNTO 0);
    SIGNAL CLK_160 : STD_LOGIC_VECTOR(0 DOWNTO 0);
    SIGNAL CLK_320 : STD_LOGIC_VECTOR(0 DOWNTO 0);

    SIGNAL async_clk : STD_LOGIC_VECTOR (0 DOWNTO 0) := "0";
    SIGNAL GlobalReset : STD_LOGIC_VECTOR (0 DOWNTO 0) := "0";
    SIGNAL GlobalDCMLock : STD_LOGIC;
    SIGNAL CLK_ACQ : STD_LOGIC_VECTOR (0 DOWNTO 0) := "0";
    SIGNAL ADC_A0 : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL ADC_A1 : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL ADC_A2 : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL ADC_A3 : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL ADC_A4 : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL ADC_A5 : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL ADC_A6 : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL ADC_A7 : STD_LOGIC_VECTOR(15 DOWNTO 0);

    SIGNAL ANALOG_INPUT_INVERSION : STD_LOGIC_VECTOR(7 DOWNTO 0) := x"00";

    SIGNAL ADCreset : STD_LOGIC := '0';
    SIGNAL EXT_READY : STD_LOGIC;
    SIGNAL chrage_clk_a : STD_LOGIC;
    SIGNAL chrage_clk_b : STD_LOGIC;
    SIGNAL chrage_clk_c : STD_LOGIC;
    SIGNAL chrage_clk_d : STD_LOGIC;
    SIGNAL chrage_srin_a : STD_LOGIC;
    SIGNAL chrage_srin_b : STD_LOGIC;
    SIGNAL chrage_srin_c : STD_LOGIC;
    SIGNAL chrage_srin_d : STD_LOGIC;

    SIGNAL COMMON_TRIGGER : STD_LOGIC;
    ATTRIBUTE keep OF ADC_A0 : SIGNAL IS "true";
    ATTRIBUTE keep OF ADC_A1 : SIGNAL IS "true";
    ATTRIBUTE keep OF ADC_A2 : SIGNAL IS "true";
    ATTRIBUTE keep OF ADC_A3 : SIGNAL IS "true";
    ATTRIBUTE keep OF ADC_A4 : SIGNAL IS "true";
    ATTRIBUTE keep OF ADC_A5 : SIGNAL IS "true";
    ATTRIBUTE keep OF ADC_A6 : SIGNAL IS "true";
    ATTRIBUTE keep OF ADC_A7 : SIGNAL IS "true";
    SIGNAL BUS_Flash_0_READ_DATA : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL BUS_Flash_0_ADDRESS : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL BUS_Flash_0_WRITE_DATA : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL BUS_Flash_0_W_INT : STD_LOGIC_VECTOR(0 DOWNTO 0);
    SIGNAL BUS_Flash_0_R_INT : STD_LOGIC_VECTOR(0 DOWNTO 0);
    SIGNAL BUS_Flash_0_VLD : STD_LOGIC_VECTOR(0 DOWNTO 0);

    SIGNAL REG_FLASH_CNTR_RD : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL REG_FLASH_CNTR_WR : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL INT_FLASH_CNTR_RD : STD_LOGIC_VECTOR(0 DOWNTO 0);
    SIGNAL INT_FLASH_CNTR_WR : STD_LOGIC_VECTOR(0 DOWNTO 0);
    SIGNAL REG_HOLD_DELAY_CNTR_RD : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL REG_HOLD_DELAY_CNTR_WR : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL INT_HOLD_DELAY_CNTR_RD : STD_LOGIC_VECTOR(0 DOWNTO 0);
    SIGNAL INT_HOLD_DELAY_CNTR_WR : STD_LOGIC_VECTOR(0 DOWNTO 0);

    SIGNAL REG_EXT_HOLD_EN_RD : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL REG_EXT_HOLD_EN_WR : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL INT_REG_EXT_HOLD_EN_RD : STD_LOGIC_VECTOR(0 DOWNTO 0);
    SIGNAL INT_REG_EXT_HOLD_EN_WR : STD_LOGIC_VECTOR(0 DOWNTO 0);

    SIGNAL REG_FLASH_ADDRESS_RD : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL REG_FLASH_ADDRESS_WR : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL INT_FLASH_ADDRESS_RD : STD_LOGIC_VECTOR(0 DOWNTO 0);
    SIGNAL INT_FLASH_ADDRESS_WR : STD_LOGIC_VECTOR(0 DOWNTO 0);

    SIGNAL FLASH_SPI_CLK : STD_LOGIC;

    SIGNAL clock_prog_mux_out : STD_LOGIC;
    SIGNAL done_sig : STD_LOGIC;
    SIGNAL cfg_clk : STD_LOGIC;

    SIGNAL trig_fake_pulse : STD_LOGIC := '0';
    SIGNAL all_trigger_signals : STD_LOGIC_VECTOR (127 DOWNTO 0);

    SIGNAL ipulser : STD_LOGIC_VECTOR (3 DOWNTO 0) := x"0";
    SIGNAL o_common_trigger : STD_LOGIC;
    SIGNAL i_common_trigger : STD_LOGIC;
    SIGNAL x_common_trigger : STD_LOGIC;
    SIGNAL counter_common_trigger : STD_LOGIC_VECTOR(3 DOWNTO 0) := x"0";
    SIGNAL REG_ResetTDCOnT0_RD : STD_LOGIC_VECTOR(31 DOWNTO 0) := x"00000000";
    SIGNAL REG_ResetTDCOnT0_WR : STD_LOGIC_VECTOR(31 DOWNTO 0) := x"00000000";
    SIGNAL INT_ResetTDCOnT0_RD : STD_LOGIC_VECTOR(0 DOWNTO 0);
    SIGNAL INT_ResetTDCOnT0_WR : STD_LOGIC_VECTOR(0 DOWNTO 0);

    SIGNAL iT0Pulse : STD_LOGIC_VECTOR (3 DOWNTO 0) := x"0";
    SIGNAL xT0 : STD_LOGIC := '0';

    SIGNAL TrigINDelayed : STD_LOGIC;
    SIGNAL EXT_Trig_FROM_HoldExt : STD_LOGIC;

    SIGNAL hold_external_hold : STD_LOGIC;
    SIGNAL hold_external_hold1 : STD_LOGIC;
    SIGNAL hold_external_hold2 : STD_LOGIC;
    SIGNAL hold_external_hold3 : STD_LOGIC;
    SIGNAL hold_external_hold4 : STD_LOGIC;
    SIGNAL RUNsel : STD_LOGIC := '0';
    SIGNAL RUNSignal : STD_LOGIC := '0';
    --    signal C_TRG :  STD_LOGIC_VECTOR(31 downto 0) := (others => '1');
    --    signal D_TRG :  STD_LOGIC_VECTOR(31 downto 0) := (others => '1');
BEGIN

    UART_TTL_TX <= '1';

    dcm_top : DTClockGenerator
    PORT MAP
    (
        clk_out1 => CLK_320(0),
        clk_out2 => CLK_160(0),
        clk_out3 => CLK_80(0),
        clk_out4 => CLK_40(0),
        clk_out5 => CLK_AUX_OUT_25,
        locked => GlobalDCMLock,
        clk_in1 => D_LVDS_DCLK
    );

    clk_divider : Clock_Divider
    PORT MAP
    (
        clk => CLK_AUX_OUT_25,
        reset => '0',
        clock_out => CLK_AUX_OUT_1khz
    );

    GlobalReset(0) <= NOT GlobalDCMLock;
    A_ANALOG_CLK <= chrage_clk_a;
    A_ANALOG_DIN <= chrage_srin_a;

    B_ANALOG_CLK <= chrage_clk_b;
    B_ANALOG_DIN <= chrage_srin_b;

    C_ANALOG_CLK <= chrage_clk_c;
    C_ANALOG_DIN <= chrage_srin_c;

    D_ANALOG_CLK <= chrage_clk_d;
    D_ANALOG_DIN <= chrage_srin_d;

    PAM0 : PetirocAnalogMonitor
    GENERIC MAP(CLKDIV => 20)
    PORT MAP(
        clk => CLK_ACQ(0),
        A_trigger_logic => A_trigger_logic,
        chrage_srin_a => chrage_srin_a,
        chrage_clk_a => chrage_clk_a,
        raz_signal => OPEN,
        enable => REG_AnalogReadout(0)
    );

    PAM1 : PetirocAnalogMonitor
    GENERIC MAP(CLKDIV => 20)
    PORT MAP(
        clk => CLK_ACQ(0),
        A_trigger_logic => B_trigger_logic,
        chrage_srin_a => chrage_srin_b,
        chrage_clk_a => chrage_clk_b,
        raz_signal => OPEN,
        enable => REG_AnalogReadout(0)
    );

    PAM2 : PetirocAnalogMonitor
    GENERIC MAP(CLKDIV => 20)
    PORT MAP(
        clk => CLK_ACQ(0),
        A_trigger_logic => C_trigger_logic,
        chrage_srin_a => chrage_srin_c,
        chrage_clk_a => chrage_clk_c,
        raz_signal => OPEN,
        enable => REG_AnalogReadout(0)
    );

    PAM3 : PetirocAnalogMonitor
    GENERIC MAP(CLKDIV => 20)
    PORT MAP(
        clk => CLK_ACQ(0),
        A_trigger_logic => D_trigger_logic,
        chrage_srin_a => chrage_srin_d,
        chrage_clk_a => chrage_clk_d,
        raz_signal => OPEN,
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

    T0 <= xT0;

    t0sync : PROCESS (D_LVDS_DCLK)
        VARIABLE cnt_pulser : INTEGER := 0;
    BEGIN
        IF rising_edge (D_LVDS_DCLK) THEN
            CASE T0sel IS
                WHEN "00" =>
                    iT0 <= fifo_reset;
                    cnt_pulser := 0;
                WHEN "01" =>
                    iT0 <= T0sw;
                    cnt_pulser := 0;
                WHEN "10" =>
                    iT0 <= '0';
                    IF cnt_pulser >= REG_T0sw_freq_WR THEN
                        cnt_pulser := 0;
                        iT0 <= '1';
                    ELSE
                        cnt_pulser := cnt_pulser + 1;
                    END IF;
                WHEN "11" =>
                    iT0 <= LEMO1;
                    cnt_pulser := 0;
                WHEN OTHERS =>

            END CASE;

            oT0 <= iT0;
            IF iT0Pulse = x"0" THEN
                xT0 <= '0';
            ELSE
                iT0Pulse <= iT0Pulse - 1;
            END IF;
            IF (iT0 = '1' AND oT0 = '0') THEN
                xT0 <= '1';
                iT0Pulse <= x"F";
            END IF;

        END IF;
    END PROCESS;

    RUNsel <= REG_RUNsel_WR(0);
    RUNSignal <= (RUNsel AND LEMO0);
    fifo_reset <= REG_Fiforeset(0) OR RunSignal;

    runcounter : PROCESS (timecode_clock)
    BEGIN
        IF fifo_reset = '1' THEN
            RunTimer <= (OTHERS => '0');
        ELSIF rising_edge (timecode_clock) THEN
            RunTimer <= RunTimer + 1;
        END IF;
    END PROCESS;
    lemo_out_siggen : PROCESS (D_LVDS_DCLK)
    BEGIN
        IF rising_edge(D_LVDS_DCLK) THEN
            veto_in <= LEMO3;

            IF LEMO4_cntr = x"0000" THEN
                LEMO4 <= '0';
            ELSE
                LEMO4_cntr <= LEMO4_cntr - 1;
            END IF;

            --            if LEMO5_cntr = x"0000" then
            --                LEMO5 <= '0';
            --            else
            --                LEMO5_cntr <= LEMO5_cntr - 1;
            --            end if;

            IF daq_event_A = '1' OR daq_event_B = '1' OR daq_event_C = '1' OR daq_event_D = '1' THEN
                LEMO4 <= '1';
                LEMO4_cntr <= outsig_len;
            END IF;

            --            if daq_event_b = '1' then
            --                LEMO5 <= '1';
            --                LEMO5_cntr <= outsig_len;
            --            end if;
        END IF;
    END PROCESS;

    all_trigger_signals <= (NOT D_TRG) & (NOT C_TRG) & (NOT B_TRG) & (NOT A_TRG);

    A_trigger_logic <= ((A_TRG(0) OR TM(0)) AND (A_TRG(1) OR TM(1)) AND
        (A_TRG(2) OR TM(2)) AND (A_TRG(3) OR TM(3)) AND
        (A_TRG(4) OR TM(4)) AND (A_TRG(5) OR TM(5)) AND
        (A_TRG(6) OR TM(6)) AND (A_TRG(7) OR TM(7)) AND
        (A_TRG(8) OR TM(8)) AND (A_TRG(9) OR TM(9)) AND
        (A_TRG(10) OR TM(10)) AND (A_TRG(11) OR TM(11)) AND
        (A_TRG(12) OR TM(12)) AND (A_TRG(13) OR TM(13)) AND
        (A_TRG(14) OR TM(14)) AND (A_TRG(15) OR TM(15)) AND
        (A_TRG(16) OR TM(16)) AND (A_TRG(17) OR TM(17)) AND
        (A_TRG(18) OR TM(18)) AND (A_TRG(19) OR TM(19)) AND
        (A_TRG(20) OR TM(20)) AND (A_TRG(21) OR TM(21)) AND
        (A_TRG(22) OR TM(22)) AND (A_TRG(23) OR TM(23)) AND
        (A_TRG(24) OR TM(24)) AND (A_TRG(25) OR TM(25)) AND
        (A_TRG(26) OR TM(26)) AND (A_TRG(27) OR TM(27)) AND
        (A_TRG(28) OR TM(28)) AND (A_TRG(29) OR TM(29)) AND
        (A_TRG(30) OR TM(30)) AND (A_TRG(31) OR TM(31))) OR cL_AsicDisable(0);

    B_trigger_logic <= ((B_TRG(0) OR TM(0)) AND (B_TRG(1) OR TM(1)) AND
        (B_TRG(2) OR TM(2)) AND (B_TRG(3) OR TM(3)) AND
        (B_TRG(4) OR TM(4)) AND (B_TRG(5) OR TM(5)) AND
        (B_TRG(6) OR TM(6)) AND (B_TRG(7) OR TM(7)) AND
        (B_TRG(8) OR TM(8)) AND (B_TRG(9) OR TM(9)) AND
        (B_TRG(10) OR TM(10)) AND (B_TRG(11) OR TM(11)) AND
        (B_TRG(12) OR TM(12)) AND (B_TRG(13) OR TM(13)) AND
        (B_TRG(14) OR TM(14)) AND (B_TRG(15) OR TM(15)) AND
        (B_TRG(16) OR TM(16)) AND (B_TRG(17) OR TM(17)) AND
        (B_TRG(18) OR TM(18)) AND (B_TRG(19) OR TM(19)) AND
        (B_TRG(20) OR TM(20)) AND (B_TRG(21) OR TM(21)) AND
        (B_TRG(22) OR TM(22)) AND (B_TRG(23) OR TM(23)) AND
        (B_TRG(24) OR TM(24)) AND (B_TRG(25) OR TM(25)) AND
        (B_TRG(26) OR TM(26)) AND (B_TRG(27) OR TM(27)) AND
        (B_TRG(28) OR TM(28)) AND (B_TRG(29) OR TM(29)) AND
        (B_TRG(30) OR TM(30)) AND (B_TRG(31) OR TM(31))) OR cL_AsicDisable(1);

    C_trigger_logic <= ((C_TRG(0) OR TM(0)) AND (C_TRG(1) OR TM(1)) AND
        (C_TRG(2) OR TM(2)) AND (C_TRG(3) OR TM(3)) AND
        (C_TRG(4) OR TM(4)) AND (C_TRG(5) OR TM(5)) AND
        (C_TRG(6) OR TM(6)) AND (C_TRG(7) OR TM(7)) AND
        (C_TRG(8) OR TM(8)) AND (C_TRG(9) OR TM(9)) AND
        (C_TRG(10) OR TM(10)) AND (C_TRG(11) OR TM(11)) AND
        (C_TRG(12) OR TM(12)) AND (C_TRG(13) OR TM(13)) AND
        (C_TRG(14) OR TM(14)) AND (C_TRG(15) OR TM(15)) AND
        (C_TRG(16) OR TM(16)) AND (C_TRG(17) OR TM(17)) AND
        (C_TRG(18) OR TM(18)) AND (C_TRG(19) OR TM(19)) AND
        (C_TRG(20) OR TM(20)) AND (C_TRG(21) OR TM(21)) AND
        (C_TRG(22) OR TM(22)) AND (C_TRG(23) OR TM(23)) AND
        (C_TRG(24) OR TM(24)) AND (C_TRG(25) OR TM(25)) AND
        (C_TRG(26) OR TM(26)) AND (C_TRG(27) OR TM(27)) AND
        (C_TRG(28) OR TM(28)) AND (C_TRG(29) OR TM(29)) AND
        (C_TRG(30) OR TM(30)) AND (C_TRG(31) OR TM(31))) OR cL_AsicDisable(2);

    d_trigger_logic <= ((D_TRG(0) OR TM(0)) AND (D_TRG(1) OR TM(1)) AND
        (D_TRG(2) OR TM(2)) AND (D_TRG(3) OR TM(3)) AND
        (D_TRG(4) OR TM(4)) AND (D_TRG(5) OR TM(5)) AND
        (D_TRG(6) OR TM(6)) AND (D_TRG(7) OR TM(7)) AND
        (D_TRG(8) OR TM(8)) AND (D_TRG(9) OR TM(9)) AND
        (D_TRG(10) OR TM(10)) AND (D_TRG(11) OR TM(11)) AND
        (D_TRG(12) OR TM(12)) AND (D_TRG(13) OR TM(13)) AND
        (D_TRG(14) OR TM(14)) AND (D_TRG(15) OR TM(15)) AND
        (D_TRG(16) OR TM(16)) AND (D_TRG(17) OR TM(17)) AND
        (D_TRG(18) OR TM(18)) AND (D_TRG(19) OR TM(19)) AND
        (D_TRG(20) OR TM(20)) AND (D_TRG(21) OR TM(21)) AND
        (D_TRG(22) OR TM(22)) AND (D_TRG(23) OR TM(23)) AND
        (D_TRG(24) OR TM(24)) AND (D_TRG(25) OR TM(25)) AND
        (D_TRG(26) OR TM(26)) AND (D_TRG(27) OR TM(27)) AND
        (D_TRG(28) OR TM(28)) AND (D_TRG(29) OR TM(29)) AND
        (D_TRG(30) OR TM(30)) AND (D_TRG(31) OR TM(31))) OR cL_AsicDisable(3);

    common_trigger <= NOT (A_trigger_logic AND B_trigger_logic AND C_trigger_logic AND D_trigger_logic);
    common_trigger_pusle : PROCESS (D_LVDS_DCLK)
    BEGIN
        IF rising_edge(D_LVDS_DCLK) THEN
            i_common_trigger <= common_trigger;
            o_common_trigger <= i_common_trigger;
            IF counter_common_trigger = x"0" THEN
                x_common_trigger <= '0';
            ELSE
                x_common_trigger <= '1';
                counter_common_trigger <= counter_common_trigger - 1;
            END IF;
            IF o_common_trigger = '0' AND i_common_trigger = '1' THEN
                counter_common_trigger <= x"F";
            END IF;
        END IF;
    END PROCESS;

    D_TRIG_EXT <= ipulser(0) OR (x_common_trigger AND REG_EnableCommonTrigger_WR(0)) OR (LEMO2 AND REG_EnableExtTrigger_WR(0));
    C_TRIG_EXT <= ipulser(1) OR (x_common_trigger AND REG_EnableCommonTrigger_WR(1)) OR (LEMO2 AND REG_EnableExtTrigger_WR(0));
    B_TRIG_EXT <= ipulser(2) OR (x_common_trigger AND REG_EnableCommonTrigger_WR(2)) OR (LEMO2 AND REG_EnableExtTrigger_WR(0));
    A_TRIG_EXT <= ipulser(3) OR (x_common_trigger AND REG_EnableCommonTrigger_WR(3)) OR (LEMO2 AND REG_EnableExtTrigger_WR(0));

    veto_enable_a <= REG_EnableExtVeto_WR(0);
    veto_enable_b <= REG_EnableExtVeto_WR(0);
    veto_enable_c <= REG_EnableExtVeto_WR(0);
    veto_enable_d <= REG_EnableExtVeto_WR(0);

    veto_a <= (veto_enable_a AND veto_in) OR sw_veto;
    veto_b <= (veto_enable_b AND veto_in) OR sw_veto;
    veto_c <= (veto_enable_c AND veto_in) OR sw_veto;
    veto_d <= (veto_enable_d AND veto_in) OR sw_veto;
    f_BUS_DATA_RD <= f_BUS_DATA_RD_A WHEN f_BUS_ADDR(31 DOWNTO 28) = x"0" ELSE
        f_BUS_DATA_RD_B WHEN f_BUS_ADDR(31 DOWNTO 28) = x"1" ELSE
        x"DEAFBEEF";

    f_BUS_DATASTROBE <= f_BUS_DATASTROBE_A WHEN f_BUS_ADDR(31 DOWNTO 28) = x"0" ELSE
        f_BUS_DATASTROBE_B WHEN f_BUS_ADDR(31 DOWNTO 28) = x"1" ELSE
        '0';

    f_BUS_INT_RD_A <= f_BUS_INT_RD WHEN f_BUS_ADDR(31 DOWNTO 28) = x"0" ELSE
        '0';
    f_BUS_INT_RD_B <= f_BUS_INT_RD WHEN f_BUS_ADDR(31 DOWNTO 28) = x"1" ELSE
        '0';

    -- A_raz_chn <= '1';
    -- B_raz_chn <= '1';      
    PT0 : petiroc_datareceiver PORT MAP(
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
        T0 => T0,
        fifo_clk => f_BUS_CLK,
        fifo_reset => fifo_reset,
        fifo_rd => '0',
        fifo_datavalid => OPEN,
        fifo_busy => OPEN,
        fifo_data => OPEN,
        RunTimer => RunTimer,
        DataWordRun => ADataWordRun,
        delay_trigger => delay_trigger,
        DataWordT0 => ADataWordT0,
        DataWord => ADataWord,
        ValidWord => AValidWord,
        ResetValidWord => AResetValidWord,
        TriggerSelector => REG_TRGsel_WR(0)
    );
    PT1 : petiroc_datareceiver PORT MAP(
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
        T0 => T0,
        fifo_clk => f_BUS_CLK,
        fifo_reset => fifo_reset,
        fifo_rd => '0',
        fifo_datavalid => OPEN,
        fifo_busy => OPEN,
        fifo_data => OPEN,
        RunTimer => RunTimer,
        DataWordRun => BDataWordRun,
        delay_trigger => delay_trigger,
        DataWordT0 => BDataWordT0,
        DataWord => BDataWord,
        ValidWord => BValidWord,
        ResetValidWord => BResetValidWord,
        TriggerSelector => REG_TRGsel_WR(0)
    );
    PT2 : petiroc_datareceiver PORT MAP(
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
        T0 => T0,
        fifo_clk => f_BUS_CLK,
        fifo_reset => fifo_reset,
        fifo_rd => '0',
        fifo_datavalid => OPEN,
        fifo_busy => OPEN,
        fifo_data => OPEN,
        RunTimer => RunTimer,
        DataWordRun => CDataWordRun,
        delay_trigger => delay_trigger,
        DataWordT0 => CDataWordT0,
        DataWord => CDataWord,
        ValidWord => CValidWord,
        ResetValidWord => CResetValidWord,
        TriggerSelector => REG_TRGsel_WR(0)
    );
    PT3 : petiroc_datareceiver PORT MAP(
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
        T0 => T0,
        fifo_clk => f_BUS_CLK,
        fifo_reset => fifo_reset,
        fifo_rd => '0',
        fifo_datavalid => OPEN,
        fifo_busy => OPEN,
        fifo_data => OPEN,
        RunTimer => RunTimer,
        DataWordRun => DDataWordRun,
        delay_trigger => delay_trigger,
        DataWordT0 => DDataWordT0,
        DataWord => DDataWord,
        ValidWord => DValidWord,
        ResetValidWord => DResetValidWord,
        TriggerSelector => REG_TRGsel_WR(0)
    );
    arbiter : BLOCK
        SIGNAL SMARBITER : STD_LOGIC_VECTOR (3 DOWNTO 0) := x"0";
        SIGNAL ARBITERID : INTEGER RANGE 0 TO 63 := 0;
        SIGNAL RDO_FIFO_DIN : STD_LOGIC_VECTOR (31 DOWNTO 0);
        SIGNAL RDO_FIFO_WE : STD_LOGIC_VECTOR (0 DOWNTO 0) := "0";
        SIGNAL RDO_FIFO_FREE : STD_LOGIC_VECTOR (0 DOWNTO 0) := "0";
        SIGNAL FIFODATALATCH : STD_LOGIC_VECTOR (38 * 32 - 1 DOWNTO 0);
        SIGNAL IwriteF : INTEGER RANGE 0 TO 63 := 0;
        SIGNAL FIFODV : STD_LOGIC;
        SIGNAL FIFOPROGFULL : STD_LOGIC;
        SIGNAL FIFOPROGEMPTY : STD_LOGIC;
    BEGIN

        instRDO_LIST_FIFO : RDO_LIST_FIFO
        PORT MAP(
            rst => fifo_reset,
            wr_clk => D_LVDS_DCLK,
            rd_clk => f_BUS_CLK,
            din => RDO_FIFO_DIN,
            wr_en => RDO_FIFO_WE(0),
            rd_en => ImageReadout_0_RD(0),
            dout => ImageReadout_0_READ_DATA,
            full => OPEN,
            empty => OPEN,
            prog_full => FIFOPROGFULL,
            prog_empty => FIFOPROGEMPTY
        );
        RDO_FIFO_FREE(0) <= NOT FIFOPROGFULL;
        ImageReadout_0_VLD(0) <= NOT FIFOPROGEMPTY;
        fifo_busy_a <= NOT FIFOPROGFULL;

        READOUT_ARBITER : PROCESS (D_LVDS_DCLK)
        BEGIN
            IF rising_edge(D_LVDS_DCLK) THEN
                AResetValidWord <= '0';
                BResetValidWord <= '0';
                CResetValidWord <= '0';
                DResetValidWord <= '0';
                RDO_FIFO_WE <= "0";

                sfifo_reset <= fifo_reset;
                ssfifo_reset <= sfifo_reset;

                IF cFiforeset = '1' THEN
                    TotalEventCounter <= (OTHERS => '0');
                END IF;

                CASE SMARBITER IS
                    WHEN x"0" =>

                        CASE ARBITERID IS
                            WHEN 0 =>
                                IF AValidWord = '1' AND cL_AsicDisable(0) = '0' THEN
                                    FIFODATALATCH(32 * 1 - 1 DOWNTO 32 * 0) <= x"80000000";
                                    FIFODATALATCH(32 * 2 - 1 DOWNTO 32 * 1) <= ADataWordT0;
                                    FIFODATALATCH(32 * 3 - 1 DOWNTO 32 * 2) <= ADataWordRun(31 DOWNTO 0);
                                    FIFODATALATCH(32 * 4 - 1 DOWNTO 32 * 3) <= ADataWordRun(63 DOWNTO 32);
                                    FIFODATALATCH(32 * 5 - 1 DOWNTO 32 * 4) <= TotalEventCounter;
                                    FIFODATALATCH(32 * 37 - 1 DOWNTO 32 * 5) <= ADataWord;
                                    FIFODATALATCH(32 * 38 - 1 DOWNTO 32 * 37) <= x"C0000000";
                                    IF RDO_FIFO_FREE = "1" THEN
                                        SMARBITER <= x"1";
                                    END IF;
                                    AResetValidWord <= '1';
                                    IwriteF <= 0;
                                    TotalEventCounter <= TotalEventCounter + 1;
                                END IF;
                                ARBITERID <= 1;
                            WHEN 1 =>
                                IF BValidWord = '1' AND cL_AsicDisable(1) = '0' THEN
                                    FIFODATALATCH(32 * 1 - 1 DOWNTO 32 * 0) <= x"80000001";
                                    FIFODATALATCH(32 * 2 - 1 DOWNTO 32 * 1) <= BDataWordT0;
                                    FIFODATALATCH(32 * 3 - 1 DOWNTO 32 * 2) <= BDataWordRun(31 DOWNTO 0);
                                    FIFODATALATCH(32 * 4 - 1 DOWNTO 32 * 3) <= BDataWordRun(63 DOWNTO 32);
                                    FIFODATALATCH(32 * 5 - 1 DOWNTO 32 * 4) <= TotalEventCounter;
                                    FIFODATALATCH(32 * 37 - 1 DOWNTO 32 * 5) <= BDataWord;
                                    FIFODATALATCH(32 * 38 - 1 DOWNTO 32 * 37) <= x"C0000000";
                                    IF RDO_FIFO_FREE = "1" THEN
                                        SMARBITER <= x"1";
                                    END IF;
                                    BResetValidWord <= '1';
                                    IwriteF <= 0;
                                    TotalEventCounter <= TotalEventCounter + 1;
                                END IF;
                                ARBITERID <= 2;
                            WHEN 2 =>
                                IF CValidWord = '1' AND cL_AsicDisable(2) = '0' THEN
                                    FIFODATALATCH(32 * 1 - 1 DOWNTO 32 * 0) <= x"80000002";
                                    FIFODATALATCH(32 * 2 - 1 DOWNTO 32 * 1) <= CDataWordT0;
                                    FIFODATALATCH(32 * 3 - 1 DOWNTO 32 * 2) <= CDataWordRun(31 DOWNTO 0);
                                    FIFODATALATCH(32 * 4 - 1 DOWNTO 32 * 3) <= CDataWordRun(63 DOWNTO 32);
                                    FIFODATALATCH(32 * 5 - 1 DOWNTO 32 * 4) <= TotalEventCounter;
                                    FIFODATALATCH(32 * 37 - 1 DOWNTO 32 * 5) <= CDataWord;
                                    FIFODATALATCH(32 * 38 - 1 DOWNTO 32 * 37) <= x"C0000000";
                                    IF RDO_FIFO_FREE = "1" THEN
                                        SMARBITER <= x"1";
                                    END IF;
                                    CResetValidWord <= '1';
                                    IwriteF <= 0;
                                    TotalEventCounter <= TotalEventCounter + 1;
                                END IF;
                                ARBITERID <= 3;
                            WHEN 3 =>
                                IF DValidWord = '1' AND cL_AsicDisable(3) = '0' THEN
                                    FIFODATALATCH(32 * 1 - 1 DOWNTO 32 * 0) <= x"80000003";
                                    FIFODATALATCH(32 * 2 - 1 DOWNTO 32 * 1) <= DDataWordT0;
                                    FIFODATALATCH(32 * 3 - 1 DOWNTO 32 * 2) <= DDataWordRun(31 DOWNTO 0);
                                    FIFODATALATCH(32 * 4 - 1 DOWNTO 32 * 3) <= DDataWordRun(63 DOWNTO 32);
                                    FIFODATALATCH(32 * 5 - 1 DOWNTO 32 * 4) <= TotalEventCounter;
                                    FIFODATALATCH(32 * 37 - 1 DOWNTO 32 * 5) <= DDataWord;
                                    FIFODATALATCH(32 * 38 - 1 DOWNTO 32 * 37) <= x"C0000000";
                                    IF RDO_FIFO_FREE = "1" THEN
                                        SMARBITER <= x"1";
                                    END IF;
                                    DResetValidWord <= '1';
                                    IwriteF <= 0;
                                    TotalEventCounter <= TotalEventCounter + 1;
                                END IF;
                                ARBITERID <= 0;
                            WHEN OTHERS =>
                                ARBITERID <= 0;
                        END CASE;
                    WHEN x"1" =>

                        RDO_FIFO_DIN <= FIFODATALATCH((IwriteF + 1) * 32 - 1 DOWNTO IwriteF * 32);
                        RDO_FIFO_WE <= "1";
                        IF IwriteF = 37 THEN
                            SMARBITER <= x"0";
                        ELSE
                            IwriteF <= IwriteF + 1;
                        END IF;
                    WHEN OTHERS =>
                        SMARBITER <= x"0";
                END CASE;
            END IF;
        END PROCESS;
    END BLOCK;
    --    A_raz_chn <= D_raz_chn;
    --A_START_CONV <=  start_conv_glb;
    --    D_START_CONV <= start_conv_glb;

    DB_Trig : delay_box
    PORT MAP(
        clk => CLK_320(0),
        input_signal => LEMO2,
        output_signal => TrigINDelayed,
        delay_value => REG_HOLD_DELAY_CNTR_WR(15 DOWNTO 0)
    );

    EXT_Trig_FROM_HoldExt <= TrigINDelayed WHEN REG_EXT_HOLD_EN_WR(0) = '1' ELSE
        '0';
    hold_external_hold <= (hold_external_hold1 AND (NOT cL_AsicDisable(0))) OR
        (hold_external_hold2 AND (NOT cL_AsicDisable(1))) OR
        (hold_external_hold3 AND (NOT cL_AsicDisable(2))) OR
        (hold_external_hold4 AND (NOT cL_AsicDisable(3))) OR
        TrigINDelayed;
    A_HOLD_EXT <= hold_external_hold WHEN REG_EXT_HOLD_EN_WR(0) = '1' ELSE
        '0';
    B_HOLD_EXT <= hold_external_hold WHEN REG_EXT_HOLD_EN_WR(0) = '1' ELSE
        '0';
    C_HOLD_EXT <= hold_external_hold WHEN REG_EXT_HOLD_EN_WR(0) = '1' ELSE
        '0';
    D_HOLD_EXT <= hold_external_hold WHEN REG_EXT_HOLD_EN_WR(0) = '1' ELSE
        '0';

    D_DOUT_LVDS : IBUFDS
    GENERIC MAP(
        DIFF_TERM => TRUE,
        IBUF_LOW_PWR => TRUE,
        IOSTANDARD => "LVDS25")
    PORT MAP(
        O => D_LVDS_DOUTn,
        I => D_LVDS_DOUT_P,
        IB => D_LVDS_DOUT_N
    );
    D_LVDS_DOUT <= NOT D_LVDS_DOUTn;

    D_CLK_LVDS : IBUFDS
    GENERIC MAP(
        DIFF_TERM => TRUE,
        IBUF_LOW_PWR => TRUE,
        IOSTANDARD => "LVDS25")
    PORT MAP(
        O => iD_LVDS_DCLK,
        I => D_LVDS_DCLK_P,
        IB => D_LVDS_DCLK_N
    );
    D_LVDS_DCLK <= NOT iD_LVDS_DCLK;

    C_DOUT_LVDS : IBUFDS
    GENERIC MAP(
        DIFF_TERM => TRUE,
        IBUF_LOW_PWR => TRUE,
        IOSTANDARD => "LVDS25")
    PORT MAP(
        O => C_LVDS_DOUTn,
        I => C_LVDS_DOUT_P,
        IB => C_LVDS_DOUT_N
    );
    C_LVDS_DOUT <= NOT C_LVDS_DOUTn;

    A_DOUT_LVDS : IBUFDS
    GENERIC MAP(
        DIFF_TERM => TRUE,
        IBUF_LOW_PWR => TRUE,
        IOSTANDARD => "LVDS25")
    PORT MAP(
        O => A_LVDS_DOUT,
        I => A_LVDS_DOUT_P,
        IB => A_LVDS_DOUT_N
    );
    B_DOUT_LVDS : IBUFDS
    GENERIC MAP(
        DIFF_TERM => TRUE,
        IBUF_LOW_PWR => TRUE,
        IOSTANDARD => "LVDS25")
    PORT MAP(
        O => B_LVDS_DOUT,
        I => B_LVDS_DOUT_P,
        IB => B_LVDS_DOUT_N
    );

    CLK_40_LVDS : IBUFDS
    GENERIC MAP(
        DIFF_TERM => TRUE,
        IBUF_LOW_PWR => TRUE,
        IOSTANDARD => "LVDS25")
    PORT MAP(
        O => itimecode_clock,
        I => CLK_40_P,
        IB => CLK_40_N
    );
    timecode_clock <= NOT itimecode_clock;
    pulse_gen : PROCESS (D_LVDS_DCLK)
    BEGIN
        IF rising_edge(D_LVDS_DCLK) THEN
            IF trg_ext_cnt >= internal_pulser_pediod THEN
                trig_fake_pulse <= '0';
                -- A_START_CONV <= internal_pulser_enableA;
                -- B_START_CONV <= internal_pulser_enableB;
                ipulser(0) <= internal_pulser_enableA;
                ipulser(1) <= internal_pulser_enableB;
                ipulser(2) <= internal_pulser_enableC;
                ipulser(3) <= internal_pulser_enableD;

                trg_ext_cnt <= 0;

            ELSE
                IF trg_ext_cnt = 20 THEN
                    trig_fake_pulse <= '1';
                    --     A_START_CONV <= '0';
                    --     B_START_CONV <= '0';
                    ipulser(0) <= '0';
                    ipulser(1) <= '0';
                    ipulser(2) <= '0';
                    ipulser(3) <= '0';
                END IF;
                trg_ext_cnt <= trg_ext_cnt + 1;
            END IF;
        END IF;
    END PROCESS;
    xpm_cdc_array_single_inst : xpm_cdc_array_single
    GENERIC MAP(

        -- Common module generics
        DEST_SYNC_FF => 4, -- integer; range: 2-10
        INIT_SYNC_FF => 0, -- integer; 0=disable simulation init values, 1=enable simulation init values
        SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
        SRC_INPUT_REG => 1, -- integer; 0=do not register input, 1=register input
        WIDTH => 32 -- integer; range: 1-1024

    )
    PORT MAP(

        src_clk => f_BUS_CLK, -- optional; required when SRC_INPUT_REG = 1
        src_in => L_AsicDisable,
        dest_clk => D_LVDS_DCLK,
        dest_out => cL_AsicDisable
    );

    xpm_cdc_single_inst : xpm_cdc_single
    GENERIC MAP(
        DEST_SYNC_FF => 4, -- integer; range: 2-10
        INIT_SYNC_FF => 0, -- integer; 0=disable simulation init values, 1=enable simulation init values
        SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
        SRC_INPUT_REG => 1 -- integer; 0=do not register input, 1=register input
    )
    PORT MAP(
        src_clk => f_BUS_CLK, -- optional; required when SRC_INPUT_REG = 1
        src_in => REG_Fiforeset(0),
        dest_clk => D_LVDS_DCLK,
        dest_out => cFiforeset
    );
    latch_registers : PROCESS (f_BUS_CLK)
    BEGIN
        IF rising_edge(f_BUS_CLK) THEN
            IF INT_AsicDisable = "1" THEN
                L_AsicDisable <= REG_AsicDisable;
            END IF;
        END IF;
    END PROCESS;

    T0sel <= REG_T0sel_WR(1 DOWNTO 0);
    T0sw <= REG_T0sw_WR(0);

    f_BUS_CLK <= D_LVDS_DCLK;--FTDI_CLK;
    reset <= '0';
    --

    USBInterface : ft600_fifo245_wrapper PORT MAP(
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
        INT_ValEvt_RD => OPEN,
        INT_ValEvt_WR => OPEN,

        REG_Rstb_RD => REG_Rstb,
        REG_Rstb_WR => REG_Rstb,
        INT_Rstb_RD => OPEN,
        INT_Rstb_WR => OPEN,

        REG_Startb_RD => REG_Startb,
        REG_Startb_WR => REG_Startb,
        INT_Startb_RD => OPEN,
        INT_Startb_WR => OPEN,

        REG_Fiforeset_RD => REG_Fiforeset,
        REG_Fiforeset_WR => REG_Fiforeset,
        INT_Fiforeset_RD => OPEN,
        INT_Fiforeset_WR => OPEN,

        REG_SelfTrigger_RD => REG_SelfTrigger,
        REG_SelfTrigger_WR => REG_SelfTrigger,
        INT_SelfTrigger_RD => OPEN,
        INT_SelfTrigger_WR => OPEN,

        REG_SelfTriggerPeriod_RD => REG_SelfTriggerPeriod,
        REG_SelfTriggerPeriod_WR => REG_SelfTriggerPeriod,
        INT_SelfTriggerPeriod_RD => OPEN,
        INT_SelfTriggerPeriod_WR => OPEN,

        REG_TriggerMode_RD => REG_TriggerMode,
        REG_TriggerMode_WR => REG_TriggerMode,
        INT_TriggerMode_RD => OPEN,
        INT_TriggerMode_WR => OPEN,
        REG_T0sel_RD => REG_T0sel_WR,
        REG_T0sel_WR => REG_T0sel_WR,
        INT_T0sel_RD => OPEN,
        INT_T0sel_WR => OPEN,

        REG_RUNsel_RD => REG_RUNsel_WR,
        REG_RUNsel_WR => REG_RUNsel_WR,
        INT_RUNsel_RD => OPEN,
        INT_RUNsel_WR => OPEN,

        REG_T0sw_RD => REG_T0sw_WR,
        REG_T0sw_WR => REG_T0sw_WR,
        INT_T0sw_RD => OPEN,
        INT_T0sw_WR => OPEN,

        REG_T0sw_mode_RD => REG_T0sw_mode_WR,
        REG_T0sw_mode_WR => REG_T0sw_mode_WR,
        INT_T0sw_mode_RD => OPEN,
        INT_T0sw_mode_WR => OPEN,

        REG_T0sw_freq_RD => REG_T0sw_freq_WR,
        REG_T0sw_freq_WR => REG_T0sw_freq_WR,
        INT_T0sw_freq_RD => OPEN,
        INT_T0sw_freq_WR => OPEN,

        REG_AsicDisable_RD => REG_AsicDisable,
        REG_AsicDisable_WR => REG_AsicDisable,
        INT_AsicDisable_RD => OPEN,
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
        INT_EnableCommonTrigger_WR => OPEN,

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
        BUS_ImageReadout_0_WRITE_DATA => OPEN,
        BUS_ImageReadout_0_W_INT => OPEN,
        BUS_ImageReadout_0_R_INT => ImageReadout_0_RD,
        BUS_ImageReadout_0_VLD => ImageReadout_0_VLD,
        REG_ImageReadout_0_READ_STATUS_RD => ImageReadout_0_WCNT,
        INT_ImageReadout_0_READ_STATUS_RD => OPEN,

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

        REG_UNIQUE_RD => x"1234FFAA",
        REG_UNIQUE_WR => OPEN,
        REG_FIRMWARE_BUILD => x"22012401",

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
        BUS_FQMETER_RD => BUS_FQMETER_RD,
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
    GENERIC MAP(ComponentBaseAddress => x"0000")
    PORT MAP(
        clk => clk_100,
        CK_SPI_LE => CK_SPI_LE,
        CK_SPI_CLK => CK_SPI_CLK,
        CK_SPI_MOSI => CK_SPI_MOSI,
        CK_PD => OPEN,
        CK_LOCK => '1',
        CK_CONFIG_DONE => CK_CONFIG_DONE,
        reset => '0',
        reset_out => sys_reset,
        REG_addr => x"0000",
        REG_din => x"00000000",
        REG_wrint => '0'
    );
    U47 : i2c_master_v01
    GENERIC MAP(
        CLK_FREQ => 80000000,
        BAUD => 100000)
    PORT MAP(
        sys_clk => f_BUS_CLK,
        sys_rst => '0',
        start => i2c_0_REG_CTRL_LATCHED(8),
        stop => i2c_0_REG_CTRL_LATCHED(9),
        read => i2c_0_REG_CTRL_LATCHED(11),
        write => i2c_0_REG_CTRL_LATCHED(12),
        send_ack => i2c_0_REG_CTRL_LATCHED(10),
        mstr_din => i2c_0_REG_CTRL_LATCHED(7 DOWNTO 0),
        sda => iic_sda,
        scl => iic_scl,
        free => REG_i2c_0_REG_MON_RD(18),
        rec_ack => REG_i2c_0_REG_MON_RD(16),
        ready => REG_i2c_0_REG_MON_RD(17),
        data_good => i2c_0_data_good(0),
        core_state => OPEN,
        mstr_dout => i2c_0_dout
    );
    i2c_0_ready(0) <= REG_i2c_0_REG_MON_RD(9);
    U47_process_latch : PROCESS (f_BUS_CLK)
    BEGIN
        IF rising_edge(f_BUS_CLK) THEN
            IF INT_i2c_0_REG_CTRL_WR = "1" THEN
                i2c_0_REG_CTRL_LATCHED <= REG_i2c_0_REG_CTRL_WR;
            ELSE
                i2c_0_REG_CTRL_LATCHED <= (OTHERS => '0');
            END IF;
            IF i2c_0_data_good = "1" THEN
                REG_i2c_0_REG_MON_RD(7 DOWNTO 0) <= i2c_0_dout;
            END IF;
        END IF;
    END PROCESS;

    psc0 : PetirocSlowControl
    GENERIC MAP(
        ComponentBaseAddress => x"0000",
        Halfbit => 10000)
    PORT MAP(
        reset => '0',
        clk => f_BUS_CLK,
        PETIROC_CLK => PETIROC_A_CLK,
        PETIROC_MOSI => PETIROC_A_MOSI,
        PETIROC_SLOAD => PETIROC_A_SLOAD,
        PETIROC_RESETB => PETIROC_A_RESETB,
        PETIROC_SELECT => PETIROC_A_SELECT,
        REG_addr => BUS_PROCCFG_0_READ_ADDRESS,
        REG_din => BUS_PROCCFG_0_WRITE_DATA,
        REG_out => OPEN,
        REG_wrint => BUS_PROCCFG_0_W_INT(0),
        REG_rdint => '0',
        REG_rddv => OPEN
    );
    psc1 : PetirocSlowControl
    GENERIC MAP(
        ComponentBaseAddress => x"0000",
        Halfbit => 10000)
    PORT MAP(
        reset => '0',
        clk => f_BUS_CLK,
        PETIROC_CLK => PETIROC_B_CLK,
        PETIROC_MOSI => PETIROC_B_MOSI,
        PETIROC_SLOAD => PETIROC_B_SLOAD,
        PETIROC_RESETB => PETIROC_B_RESETB,
        PETIROC_SELECT => PETIROC_B_SELECT,
        REG_addr => BUS_PROCCFG_1_READ_ADDRESS,
        REG_din => BUS_PROCCFG_1_WRITE_DATA,
        REG_out => OPEN,
        REG_wrint => BUS_PROCCFG_1_W_INT(0),
        REG_rdint => '0',
        REG_rddv => OPEN
    );

    psc2 : PetirocSlowControl
    GENERIC MAP(
        ComponentBaseAddress => x"0000",
        Halfbit => 10000)
    PORT MAP(
        reset => '0',
        clk => f_BUS_CLK,
        PETIROC_CLK => PETIROC_C_CLK,
        PETIROC_MOSI => PETIROC_C_MOSI,
        PETIROC_SLOAD => PETIROC_C_SLOAD,
        PETIROC_RESETB => PETIROC_C_RESETB,
        PETIROC_SELECT => PETIROC_C_SELECT,
        REG_addr => BUS_PROCCFG_2_READ_ADDRESS,
        REG_din => BUS_PROCCFG_2_WRITE_DATA,
        REG_out => OPEN,
        REG_wrint => BUS_PROCCFG_2_W_INT(0),
        REG_rdint => '0',
        REG_rddv => OPEN
    );

    psc3 : PetirocSlowControl
    GENERIC MAP(
        ComponentBaseAddress => x"0000",
        Halfbit => 10000)
    PORT MAP(
        reset => '0',
        clk => f_BUS_CLK,
        PETIROC_CLK => PETIROC_D_CLK,
        PETIROC_MOSI => PETIROC_D_MOSI,
        PETIROC_SLOAD => PETIROC_D_SLOAD,
        PETIROC_RESETB => PETIROC_D_RESETB,
        PETIROC_SELECT => PETIROC_D_SELECT,
        REG_addr => BUS_PROCCFG_3_READ_ADDRESS,
        REG_din => BUS_PROCCFG_3_WRITE_DATA,
        REG_out => OPEN,
        REG_wrint => BUS_PROCCFG_3_W_INT(0),
        REG_rdint => '0',
        REG_rddv => OPEN
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

    d_raz_chn_i <= NOT d_raz_chn;
    c_val_evti <= NOT c_val_evt;
    b_raz_chn_i <= NOT b_raz_chn;

    A_VAL : OBUFDS
    GENERIC MAP(
        IOSTANDARD => "LVDS",
        SLEW => "SLOW")
    PORT MAP(
        O => A_VAL_EVT_P,
        OB => A_VAL_EVT_N,
        I => a_val_evt
    );

    B_VAL : OBUFDS
    GENERIC MAP(
        IOSTANDARD => "LVDS",
        SLEW => "SLOW")
    PORT MAP(
        O => B_VAL_EVT_P,
        OB => B_VAL_EVT_N,
        I => b_val_evt
    );
    C_VAL : OBUFDS
    GENERIC MAP(
        IOSTANDARD => "LVDS",
        SLEW => "SLOW")
    PORT MAP(
        O => C_VAL_EVT_P,
        OB => C_VAL_EVT_N,
        I => c_val_evti
    );
    D_VAL : OBUFDS
    GENERIC MAP(
        IOSTANDARD => "LVDS",
        SLEW => "SLOW")
    PORT MAP(
        O => D_VAL_EVT_P,
        OB => D_VAL_EVT_N,
        I => d_val_evt
    );
    A_RAZ : OBUFDS
    GENERIC MAP(
        IOSTANDARD => "LVDS",
        SLEW => "SLOW")
    PORT MAP(
        O => A_RAZ_CHN_P,
        OB => A_RAZ_CHN_N,
        I => a_raz_chn
    );

    B_RAZ : OBUFDS
    GENERIC MAP(
        IOSTANDARD => "LVDS",
        SLEW => "SLOW")
    PORT MAP(
        O => B_RAZ_CHN_P,
        OB => B_RAZ_CHN_N,
        I => b_raz_chn_i
    );

    C_RAZ : OBUFDS
    GENERIC MAP(
        IOSTANDARD => "LVDS",
        SLEW => "SLOW")
    PORT MAP(
        O => C_RAZ_CHN_P,
        OB => C_RAZ_CHN_N,
        I => c_raz_chn
    );

    D_RAZ : OBUFDS
    GENERIC MAP(
        IOSTANDARD => "LVDS",
        SLEW => "SLOW")
    PORT MAP(
        O => D_RAZ_CHN_P,
        OB => D_RAZ_CHN_N,
        I => d_raz_chn_i
    );

    --a_val_evt <= REG_ValEvt(0);
    --b_val_evt <= REG_ValEvt(1);
    --c_val_evt <= REG_ValEvt(2);
    --d_val_evt <= REG_ValEvt(3);

    PETIROC_A_RSTB <= REG_Rstb(0) AND (NOT fifo_reset) AND ((NOT T0) OR REG_ResetTDCOnT0_WR(0)
    );
    PETIROC_B_RSTB <= REG_Rstb(1) AND (NOT fifo_reset) AND ((NOT T0) OR REG_ResetTDCOnT0_WR(0));
    PETIROC_C_RSTB <= REG_Rstb(2) AND (NOT fifo_reset) AND ((NOT T0) OR REG_ResetTDCOnT0_WR(0));
    PETIROC_D_RSTB <= REG_Rstb(3) AND (NOT fifo_reset) AND ((NOT T0) OR REG_ResetTDCOnT0_WR(0));
    A_STARTB_ADC_EXT <= REG_Startb(0);
    B_STARTB_ADC_EXT <= REG_Startb(1);
    C_STARTB_ADC_EXT <= REG_Startb(2);
    D_STARTB_ADC_EXT <= REG_Startb(3);
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

    ADCreset <= NOT EXT_READY;
    adcs : adcs_top
    PORT MAP(

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
        SMADC_1_CSB => OPEN,
        SMADC_1_CLK => SMADC_1_CLK,
        SMADC_1_MOSI => SMADC_1_MOSI,
        SMADC_1_RESET => SMADC_1_RESET,
        READOUT_CLK => CLK_ACQ(0),
        ADC_CLK_OUT => OPEN,
        CH0 => ADC_A0,
        CH1 => ADC_A1,
        CH2 => ADC_A2,
        CH3 => ADC_A3,
        CH4 => ADC_A4,
        CH5 => ADC_A5,
        CH6 => ADC_A6,
        CH7 => ADC_A7,
        CHv0_7 => OPEN,
        inversion => ANALOG_INPUT_INVERSION,
        ADC_STATUS => OPEN,
        ADC_READY => OPEN
    );

    CLK_ACQ <= CLK_80;
    --  CLK_ACQ(0) <=CLK_80;
    SMADC_1_PD <= '0';
    PAO : PetirocAsicOscilloscope
    PORT MAP(
        sample_clk => CLK_ACQ(0),
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
    PORT MAP(
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
    GENERIC MAP(
        PROG_USR => "FALSE", -- Activate program event security feature. Requires encrypted bitstreams.
        SIM_CCLK_FREQ => 0.0 -- Set the Configuration Clock Frequency(ns) for simulation.
    )
    PORT MAP(
        CFGCLK => OPEN, -- 1-bit output: Configuration main clock output
        CFGMCLK => cfg_clk, -- 1-bit output: Configuration internal oscillator clock output
        EOS => done_sig, -- 1-bit output: Active high output signal indicating the End Of Startup.
        PREQ => OPEN, -- 1-bit output: PROGRAM request to fabric output
        CLK => cfg_clk, -- 1-bit input: User start-up clock input
        GSR => '0', -- 1-bit input: Global Set/Reset input (GSR cannot be used for the port name)
        GTS => '0', -- 1-bit input: Global 3-state input (GTS cannot be used for the port name)
        KEYCLEARB => '0', -- 1-bit input: Clear AES Decrypter Key input from Battery-Backed RAM (BBRAM)
        PACK => '0', -- 1-bit input: PROGRAM acknowledge input
        USRCCLKO => clock_prog_mux_out, -- 1-bit input: User CCLK input
        USRCCLKTS => '0', -- 1-bit input: User CCLK 3-state enable input
        USRDONEO => '1', -- 1-bit input: User DONE pin output control
        USRDONETS => '0' -- 1-bit input: User DONE 3-state enable output
    );

    clock_prog_mux_out <= cfg_clk WHEN done_sig = '0' ELSE
        FLASH_SPI_CLK;

    MRM : MultichannelRateMeter
    GENERIC MAP(
        CHANNEL_COUNT => 128,
        CLK_FREQ => 160000000
    )
    PORT MAP(
        clk => f_BUS_CLK,
        trigger => all_trigger_signals,
        reg_address => BUS_FQMETER_ADDRESS,
        reg_read => BUS_FQMETER_RD
    );
END Behavioral;