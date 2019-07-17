
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

library UNISIM;
use UNISIM.VComponents.all;

Library xpm;
use xpm.vcomponents.all;

entity ft600_fifo245_wrapper is
Port ( 
	  FTDI_ADBUS : inout STD_LOGIC_VECTOR (31 downto 0);
	  FTDI_BE	 : inout STD_LOGIC_VECTOR (3 downto 0);
	  FTDI_RXFN : in STD_LOGIC;			--EMPTY
	  FTDI_TXEN : in STD_LOGIC; 		--FULL
	  FTDI_RDN	: out STD_LOGIC;		--READ ENABLE
	  FTDI_TXN	: out STD_LOGIC;		--WRITE ENABLE
	  FTDI_CLK	: in STD_LOGIC;			--FTDI CLOCK
	  FTDI_OEN	: out STD_LOGIC;		--OUTPUT ENABLE NEGATO LATO FTDI
	  FTDI_SIWU : out STD_LOGIC;		--COMMIT A PACKET IMMEDIATLY

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
                        
	    BUS_ImageReadout_0_READ_DATA : IN STD_LOGIC_VECTOR(31 downto 0); 
	    BUS_ImageReadout_0_WRITE_DATA : OUT STD_LOGIC_VECTOR(31 downto 0); 
	    BUS_ImageReadout_0_W_INT : OUT STD_LOGIC_VECTOR(0 downto 0); 
	    BUS_ImageReadout_0_R_INT : OUT STD_LOGIC_VECTOR(0 downto 0); 
	    BUS_ImageReadout_0_VLD : IN STD_LOGIC_VECTOR(0 downto 0); 
		REG_ImageReadout_0_READ_STATUS_RD : IN STD_LOGIC_VECTOR(31 downto 0); 
		INT_ImageReadout_0_READ_STATUS_RD : OUT STD_LOGIC_VECTOR(0 downto 0); 
		
	    BUS_Oscilloscope_0_READ_DATA : IN STD_LOGIC_VECTOR(31 downto 0);
	    BUS_Oscilloscope_0_ADDRESS : OUT STD_LOGIC_VECTOR(15 downto 0); 
        BUS_Oscilloscope_0_WRITE_DATA : OUT STD_LOGIC_VECTOR(31 downto 0); 
        BUS_Oscilloscope_0_W_INT : OUT STD_LOGIC_VECTOR(0 downto 0); 
        BUS_Oscilloscope_0_R_INT : OUT STD_LOGIC_VECTOR(0 downto 0); 
        BUS_Oscilloscope_0_VLD : IN STD_LOGIC_VECTOR(0 downto 0); 
		 
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
		
	BUS_i2c_0_READ_DATA : IN STD_LOGIC_VECTOR(31 downto 0); 
	BUS_i2c_0_WRITE_DATA : OUT STD_LOGIC_VECTOR(31 downto 0); 
	BUS_i2c_0_W_INT : OUT STD_LOGIC_VECTOR(0 downto 0); 
	BUS_i2c_0_R_INT : OUT STD_LOGIC_VECTOR(0 downto 0); 
	BUS_i2c_0_VLD : IN STD_LOGIC_VECTOR(0 downto 0); 
		REG_i2c_0_REG_CTRL_WR : OUT STD_LOGIC_VECTOR(31 downto 0); 
		INT_i2c_0_REG_CTRL_WR : OUT STD_LOGIC_VECTOR(0 downto 0); 
		REG_i2c_0_REG_MON_RD : IN STD_LOGIC_VECTOR(31 downto 0); 
		INT_i2c_0_REG_MON_RD : OUT STD_LOGIC_VECTOR(0 downto 0); 
		
		BUS_FQMETER_ADDRESS : OUT STD_LOGIC_VECTOR(15 downto 0);
        BUS_FQMETER_RD : IN STD_LOGIC_VECTOR(31 downto 0);


		REG_UNIQUE_RD : IN STD_LOGIC_VECTOR(31 downto 0); 
		REG_UNIQUE_WR : OUT STD_LOGIC_VECTOR(31 downto 0); 
		
        REG_FIRMWARE_BUILD : IN STD_LOGIC_VECTOR(31 downto 0);
		--LATO FPGA
	  f_CLK : IN STD_LOGIC;
	  f_RESET : IN STD_LOGIC
			  	  
			  
);
end ft600_fifo245_wrapper;

architecture Behavioral of ft600_fifo245_wrapper is
	component FTDI_FIFOs
		port (
		rst: IN std_logic;
		wr_clk: IN std_logic;
		rd_clk: IN std_logic;
		din: IN std_logic_VECTOR(33 downto 0);
		wr_en: IN std_logic;
		rd_en: IN std_logic;
		dout: OUT std_logic_VECTOR(33 downto 0);
		full: OUT std_logic;
		empty: OUT std_logic;
		valid: OUT std_logic;
		prog_empty: OUT std_logic;
		prog_full: OUT std_logic
		);
	end component;


	COMPONENT ft600_fifo245_core
	PORT(
		reset : IN std_logic;
		FTDI_RXFN : IN std_logic;
		FTDI_TXEN : IN std_logic;
		FTDI_CLK : IN std_logic;   
		FTDI_ADBUS : INOUT std_logic_vector(31 downto 0);      
		FTDI_RDN : OUT std_logic;
		FTDI_TXN : OUT std_logic;
		FTDI_OEN : OUT std_logic;
		FTDI_SIWU : OUT std_logic;
		FTDI_BE : inout std_logic_vector(3 downto 0);
		int_rd : OUT std_logic;
		int_wr : OUT std_logic;
		data_wr : OUT std_logic_vector(31 downto 0);
		data_rd : IN std_logic_vector(31 downto 0);		
		addr : OUT std_logic_vector(31 downto 0);
		req_read_data : OUT std_logic;
		input_fifo_empty : IN std_logic;
		input_fifo_valid : IN STD_LOGIC;
		fifo_address_full : IN std_logic; 
		send_shit : OUT STD_LOGIC;
		fifo_reset : OUT std_logic
		);
	END COMPONENT;
	


	component FTDI_FIFO_AW
        port (
        rst: IN std_logic;
        wr_clk: IN std_logic;
        rd_clk: IN std_logic;
        din: IN std_logic_VECTOR(65 downto 0);
        wr_en: IN std_logic;
        rd_en: IN std_logic;
        dout: OUT std_logic_VECTOR(65 downto 0);
        full: OUT std_logic;
        empty: OUT std_logic;
        valid: OUT std_logic;
        prog_empty: OUT std_logic;
        prog_full: OUT std_logic
        );
    end component;	

	
	-- SEGNALI INTERNI
			  
	signal  int_rd 	: STD_LOGIC;
	signal  int_wr 	: STD_LOGIC;
	signal  data_rd 	: STD_LOGIC_VECTOR(31 downto 0) := x"00000000";
	signal  data_wr 	: STD_LOGIC_VECTOR(31 downto 0);
	signal  core_addr 		: STD_LOGIC_VECTOR(31 downto 0);
	
	signal  addr_wrt		: STD_LOGIC;
	signal  addr_empty 	: STD_LOGIC;
	
	signal  BUS_ADDR 		: STD_LOGIC_VECTOR(31 downto 0) := x"00000000";
	signal  BUS_DATA_WR 	: STD_LOGIC_VECTOR(31 downto 0) := x"00000000";
	signal  BUS_DATA_RD 	: STD_LOGIC_VECTOR(31 downto 0) := x"00000000";
	signal  BUS_INT_RD 	: STD_LOGIC:='0';
	signal  BUS_INT_WR 	: STD_LOGIC:='0';
	signal  BUS_DATASTROBE: STD_LOGIC:='0';
	signal  i_BUS_DATASTROBE: STD_LOGIC:='0';
	
	signal  req_read_data : STD_LOGIC; 

	signal  SYNC_INT_RD 	: STD_LOGIC:='0';
	signal  SYNC_INT_WR 	: STD_LOGIC:='0';
	
	signal CLK : STD_LOGIC;
	
	signal reset : std_logic;
	
	signal invFTDI_CLK : STD_LOGIC := '0';
	
	signal fifo_reset : std_logic;
	signal fifo_reset2 : std_logic;
	
	signal input_fifo_empty :  STD_LOGIC :='0';
	
	signal fifo_address_full : STD_LOGIC := '0';
	
	signal data_read_full : STD_LOGIC := '0';
	
	signal not_full_and_pending : STD_LOGIC := '0';
	signal pending : STD_LOGIC := '0';
	
	signal i_f_MODE : STD_LOGIC := '0';
	
    signal addr_empty_d : std_logic := '1';
    

			
	signal add_fifo_rd : std_logic := '0';
	
	signal f_BUS_ADDR 		 :  STD_LOGIC_VECTOR(31 downto 0);	--INDIRIZZO DI LETTURA/SCRITTURA
	
	signal f_ENDIAN			 :  STD_LOGIC:='0';					--ENDIAN DEL PC (0: BIG 1:LITTLE)
	
	--DA FPGA A PC
	signal f_BUS_INT_RD 	 :  STD_LOGIC;						--INTERRUPT DI LETTURA
	signal f_BUS_DATASTROBE  :  STD_LOGIC;						--CONFERMA CHE I DATI RICHIESTI SONO DISPONIBILI
	signal f_BUS_DATASTROBE_REG  :  STD_LOGIC;						--CONFERMA CHE I DATI RICHIESTI SONO DISPONIBILI (REGISTRI)
	signal f_BUS_DATA_RD	 :  STD_LOGIC_VECTOR(31 downto 0);	--DATI DA INVIARE AL PC
	signal f_BUS_DATA_RD_REG :  STD_LOGIC_VECTOR(31 downto 0);	--DATI DA INVIARE AL PC (REGISTRI)
	signal f_MODE		     :  STD_LOGIC := '0';					--0 IL SEGNALE DATASROBE E' ABILITAO, 1 DATI CAMPIONATI UN CICLO DOPO INT_RD
	
	--DA PC A FPGA
	signal f_BUS_INT_WR 	 :  STD_LOGIC;						--INTERRUPT DI SCRITTURA
	signal f_BUS_DATA_WR	 :  STD_LOGIC_VECTOR(31 downto 0);	--DATI DA INVIATI DAL PC
	signal wreg				 :  STD_LOGIC_VECTOR(31 downto 0);
	signal addr 			 : STD_LOGIC_VECTOR(31 downto 0);
	
	
	attribute keep : string; 
	attribute keep of int_rd: signal is "true";	
	attribute keep of int_wr: signal is "true";	
	attribute keep of data_rd: signal is "true";	
	attribute keep of data_wr: signal is "true";	
	attribute keep of addr: signal is "true";	

	attribute keep of BUS_ADDR: signal is "true";
	attribute keep of f_BUS_ADDR: signal is "true";		
	attribute keep of BUS_DATA_WR: signal is "true";	
	attribute keep of f_BUS_DATA_WR: signal is "true";
	attribute keep of BUS_DATA_RD: signal is "true";	
	attribute keep of BUS_INT_RD: signal is "true";	
	attribute keep of BUS_INT_WR: signal is "true";	
	attribute keep of BUS_DATASTROBE: signal is "true";	
	
	attribute keep of SYNC_INT_WR: signal is "true";	
	attribute keep of addr_empty: signal is "true";
				
	signal data_fifo_full :std_logic;
	signal input_fifo_valid : std_logic;
	signal send_sheet :  STD_LOGIC;
	signal send_sheet_sync :  STD_LOGIC;
	
	attribute keep of send_sheet: signal is "true";
	attribute keep of send_sheet_sync: signal is "true";
begin



xpm_cdc_single_inst: xpm_cdc_single
generic map (
DEST_SYNC_FF => 4, -- integer; range: 2-10
SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
SRC_INPUT_REG => 1 -- integer; 0=do not register input, 1=register input
)
port map (
src_clk => invFTDI_CLK, -- optional; required when SRC_INPUT_REG = 1
src_in => send_sheet,
dest_clk => clk,
dest_out => send_sheet_sync
);
	
	
--FT232H
	invFTDI_CLK <=  FTDI_CLK;
	--FT2232H
	--invFTDI_CLK <= not FTDI_CLK;

	Inst_ft600_fifo245_core: ft600_fifo245_core PORT MAP(
		reset => reset,
		FTDI_ADBUS => FTDI_ADBUS,
		FTDI_RXFN => FTDI_RXFN,
		FTDI_TXEN => FTDI_TXEN,
		FTDI_RDN => FTDI_RDN,
		FTDI_TXN => FTDI_TXN,
		FTDI_CLK => FTDI_CLK,
		FTDI_OEN => FTDI_OEN,
		FTDI_SIWU => FTDI_SIWU,
		FTDI_BE => FTDI_BE,
		int_rd => int_rd ,
		int_wr => int_wr,
		data_rd => data_rd,
		data_wr => data_wr,
		addr => core_addr,
		req_read_data => req_read_data,
		fifo_reset => fifo_reset,
		input_fifo_empty => input_fifo_empty,
		input_fifo_valid => input_fifo_valid,
		send_shit => send_sheet,
		fifo_address_full =>  fifo_address_full
	);



	addr_wrt <= int_rd or int_wr;
	
	fifo_reset2 <= reset or fifo_reset;
	
	ADDRESS_FIFO : FTDI_FIFO_AW
		port map (
			rst => fifo_reset2,
			wr_clk => invFTDI_CLK,
			rd_clk => clk,
			din(65 downto 34) => data_wr,
			din(33) => int_rd,
			din(32) => int_wr,
			din(31 downto 0) => core_addr,
			wr_en => addr_wrt,
			rd_en => add_fifo_rd,
			dout(65 downto 34) => BUS_DATA_WR,
			dout(33) => SYNC_INT_RD,
			dout(32) => SYNC_INT_WR,
			dout(31 downto 0) => BUS_ADDR,
			full => open,
			empty => addr_empty,
			prog_empty => open,
			prog_full => fifo_address_full
			);
    
    add_fifo_rd <= not_full_and_pending and (not addr_empty) ;
	not_full_and_pending <= (not data_read_full) and (not pending);
	BUS_INT_RD <= SYNC_INT_RD and (not addr_empty) and (not_full_and_pending);
	BUS_INT_WR <= SYNC_INT_WR and (not addr_empty_d) and (not_full_and_pending);
	
	--led <= BUS_INT_RD or BUS_INT_WR;

--	DATAWRITE_FIFO : FTDI_FIFOs
--		port map (
--			rst => reset,
--			wr_clk => invFTDI_CLK,
--			rd_clk => clk,
--			din(33 downto 32) => "00",
--			din(31 downto 0) => data_wr,
--			wr_en => int_wr,
--			rd_en => add_fifo_rd,
--			dout(31 downto 0) => BUS_DATA_WR,
--			dout(33 downto 32) => open,
--			full => open,
--			empty => open);


	DATA_READ_FIFO : FTDI_FIFOs
		port map (
			rst => fifo_reset2,
			wr_clk => clk,
			rd_clk => invFTDI_CLK,
		--	din(65 downto 34) => X"00000000",
			din(33 downto 32) => "00",
			din(31 downto 0) => BUS_DATA_RD,
			wr_en => BUS_DATASTROBE,
			rd_en => req_read_data,
		--	dout(65 downto 34) => OPEN,
			dout(31 downto 0) => data_rd,
			dout(33 downto 32) => open,
			full => open,
			prog_full => data_read_full,
			prog_empty => open,
			empty => input_fifo_empty,
			valid => input_fifo_valid);


	CLK <= f_CLK;
	reset <= f_RESET;

	BUS_ImageReadout_0_R_INT(0)    <= f_BUS_INT_RD when (addr >= x"80000000" And addr < x"80000001") else '0';
	BUS_Oscilloscope_0_R_INT(0)    <= f_BUS_INT_RD when (addr >= x"80070000" And addr < x"80080000") else '0';
	BUS_FLASH_0_R_INT(0)           <= f_BUS_INT_RD when (addr >= x"FFFE0000" And addr < x"FFFEE000") else '0';
	
	BUS_PROCCFG_0_READ_ADDRESS     <= BUS_ADDR(15 downto 0); --when (addr >= x"80010000" And addr < x"80020000") else (others => '0');
	BUS_PROCCFG_1_READ_ADDRESS     <= BUS_ADDR(15 downto 0); --when (addr >= x"80020000" And addr < x"80030000") else (others => '0');
	BUS_PROCCFG_2_READ_ADDRESS     <= BUS_ADDR(15 downto 0); --when (addr >= x"80030000" And addr < x"80040000") else (others => '0');
	BUS_PROCCFG_3_READ_ADDRESS     <= BUS_ADDR(15 downto 0); --when (addr >= x"80040000" And addr < x"80050000") else (others => '0');
	BUS_CLKCFG_READ_ADDRESS        <= BUS_ADDR(15 downto 0); --when (addr >= x"80060000" And addr < x"80070000") else (others => '0');
	BUS_Oscilloscope_0_ADDRESS     <= BUS_ADDR(15 downto 0); --when (addr >= x"80070000" And addr < x"80080000") else (others => '0');
	BUS_FQMETER_ADDRESS            <= BUS_ADDR(15 downto 0); --when (addr >= x"80080000" And addr < x"80090000") else (others => '0');
	BUS_FLASH_0_ADDRESS            <= BUS_ADDR(15 downto 0);-- when (addr >= x"FFFE0000" And addr < x"FFFEE000") else (others => '0');
	
	

	

	
	
	outFF : process (clk)
	begin
	   if rising_edge(clk) then
	   	
           BUS_PROCCFG_0_WRITE_DATA <= f_BUS_DATA_WR;
           BUS_PROCCFG_1_WRITE_DATA <= f_BUS_DATA_WR;
           BUS_PROCCFG_2_WRITE_DATA <= f_BUS_DATA_WR;
           BUS_PROCCFG_3_WRITE_DATA <= f_BUS_DATA_WR;
           BUS_CLKCFG_WRITE_DATA <= f_BUS_DATA_WR;
           BUS_Oscilloscope_0_WRITE_DATA  <= f_BUS_DATA_WR;
           BUS_FLASH_0_WRITE_DATA  <= f_BUS_DATA_WR;
           
	       if addr >= x"80010000" And addr < x"80020000" then
	           BUS_PROCCFG_0_W_INT(0) <=  f_BUS_INT_WR;       
	       end if;
	       
	       if addr >= x"80020000" And addr < x"80030000" then
	           BUS_PROCCFG_1_W_INT(0) <=  f_BUS_INT_WR;
	       end if;
	       
            if addr >= x"80030000" And addr < x"80040000" then
                BUS_PROCCFG_2_W_INT(0) <=  f_BUS_INT_WR;
            end if; 	       
            
            if addr >= x"80040000" And addr < x"80050000" then
                BUS_PROCCFG_3_W_INT(0) <=  f_BUS_INT_WR;
            end if;
            
            if addr >= x"80060000" And addr < x"80070000" then
                BUS_PROCCFG_3_W_INT(0) <=  f_BUS_INT_WR;
            end if;
            
            if addr >= x"80060000" And addr < x"80070000" then
                BUS_CLKCFG_W_INT(0) <=  f_BUS_INT_WR;
            end if;
            
            if addr >= x"80070000" And addr < x"80080000" then
                BUS_Oscilloscope_0_W_INT (0) <=  f_BUS_INT_WR;
            end if;
            
            if addr >= x"FFFE0000" And addr < x"FFFEE000" then
                BUS_FLASH_0_W_INT (0) <=  f_BUS_INT_WR;
            end if;
	   end if;
	end process;
	
--	BUS_PROCCFG_0_W_INT(0) <=  f_BUS_INT_WR when (addr >= x"80010000" And addr < x"80020000") else '0';
--	BUS_PROCCFG_1_W_INT(0) <=  f_BUS_INT_WR when (addr >= x"80020000" And addr < x"80030000") else '0';
--	BUS_PROCCFG_2_W_INT(0) <=  f_BUS_INT_WR when (addr >= x"80030000" And addr < x"80040000") else '0';
--	BUS_PROCCFG_3_W_INT(0) <=  f_BUS_INT_WR when (addr >= x"80040000" And addr < x"80050000") else '0';
--	BUS_CLKCFG_W_INT(0) <=  f_BUS_INT_WR when (addr >= x"80060000" And addr < x"80070000") else '0';
--	BUS_Oscilloscope_0_W_INT (0) <=  f_BUS_INT_WR when (addr >= x"80070000" And addr < x"80080000") else '0';
--	BUS_FLASH_0_W_INT (0) <=  f_BUS_INT_WR when (addr >= x"FFFE0000" And addr < x"FFFEE000") else '0';
	
	
    f_BUS_DATA_RD <=    BUS_ImageReadout_0_READ_DATA when (addr >= x"80000000" And addr < x"80000001") else  
                        BUS_Oscilloscope_0_READ_DATA when (addr >= x"80070000" And addr < x"80080000") else
                        BUS_FQMETER_RD when (addr >= x"80080000" And addr < x"80090000") else
                        BUS_FLASH_0_READ_DATA when (addr >= x"FFFE0000" And addr < x"FFFEE000") else
                        f_BUS_DATA_RD_REG;
                        
    f_BUS_DATASTROBE <=  BUS_ImageReadout_0_VLD(0) when (addr >= x"80000000" And addr < x"80000001") else  
                         BUS_Oscilloscope_0_VLD(0) when (addr >= x"80070000" And addr < x"80080000") else
                         BUS_FLASH_0_VLD(0) when (addr >= x"FFFE0000" And addr < x"FFFEE000") else
                        f_BUS_DATASTROBE_REG;

	i_f_MODE <= f_MODE;
	
	f_BUS_ADDR <= BUS_ADDR;
	f_BUS_INT_RD <= BUS_INT_RD and( not send_sheet_sync);
	BUS_DATASTROBE <=i_BUS_DATASTROBE;-- f_BUS_DATASTROBE when i_f_MODE = '0' else i_BUS_DATASTROBE;
	BUS_DATA_RD <= f_BUS_DATA_RD when f_ENDIAN = '0' else f_BUS_DATA_RD(7 downto 0) & f_BUS_DATA_RD(15 downto 8) & f_BUS_DATA_RD(23 downto 16) & f_BUS_DATA_RD(31 downto 24);
	
	f_BUS_INT_WR <= BUS_INT_WR;
	f_BUS_DATA_WR <= BUS_DATA_WR when f_ENDIAN = '0' else BUS_DATA_WR(7 downto 0) & BUS_DATA_WR(15 downto 8) & BUS_DATA_WR(23 downto 16) & BUS_DATA_WR(31 downto 24);
	addr <= f_BUS_ADDR;
	

	-- intDS : process(clk)
	-- begin
		-- if reset='1' then
			-- i_BUS_DATASTROBE <= '0';
		-- elsif rising_edge(clk) then
	    -- addr_empty_d <= addr_empty;
		  
			-- i_BUS_DATASTROBE <= '0';
			
			-- if BUS_INT_RD = '1' then
			----	i_BUS_DATASTROBE <= '1';--(i_f_MODE  or f_BUS_DATASTROBE ) ;
				-- if i_f_MODE = '0' then
					-- pending <= '1';
				-- end if;
			-- end if;		
			
			-- if i_f_MODE = '0' and ((f_BUS_DATASTROBE = '1' and pending ='1') or (send_sheet_sync = '1')) then
				-- pending <= '0';
				-- i_BUS_DATASTROBE <= '1';
			-- end if;

		-- end if;
	
	-- end process;
	
	
	
	intDS : process(clk)
	begin
		if reset='1' then
			i_BUS_DATASTROBE <= '0';
		elsif rising_edge(clk) then
		
		    addr_empty_d <= addr_empty;
		  
			i_BUS_DATASTROBE <= '0';
			
			if BUS_INT_RD = '1' then
				i_BUS_DATASTROBE <= '1';--(i_f_MODE  or f_BUS_DATASTROBE ) ;
				if i_f_MODE = '0' then
					pending <= '1';
				end if;
			end if;		
			
			if i_f_MODE = '0' and ((f_BUS_DATASTROBE = '1') or (send_sheet_sync = '1')) then
				pending <= '0';
			end if;

		end if;
	
	end process;	
	
	
	--SCICOMPILER COSTUMIZABLE REGISTER FILE
	
	
	wreg <= f_BUS_DATA_WR;
	
	register_manager : process(clk)
		variable rreg	:  STD_LOGIC_VECTOR(31 downto 0);
	begin
		if reset='1' then
			f_BUS_DATASTROBE_REG <= '0';
		REG_ValEvt_WR <= (others => '0');
		REG_Rstb_WR <= (others => '0');
		INT_ValEvt_WR <= "0";
		INT_ValEvt_RD <= "0";
		INT_Rstb_WR <= "0";
        INT_Rstb_RD <= "0";
		INT_Startb_WR <= "0";
        INT_Startb_RD <= "0";
        INT_Fiforeset_WR <= "0";
        INT_Fiforeset_RD <= "0";
        INT_SelfTrigger_WR <= "0";
        INT_SelfTrigger_RD <= "0";
        INT_SelfTriggerPeriod_WR <= "0";
        INT_SelfTriggerPeriod_RD <= "0";
        INT_TriggerMode_WR <= "0";
        INT_TriggerMode_RD <= "0";  
        INT_AsicDisable_WR <= "0";
        INT_AsicDisable_RD <= "0";
        INT_FLASH_CNTR_RD <= "0";
        INT_FLASH_CNTR_RD <= "0";
        INT_FLASH_ADDRESS_WR <= "0";
        INT_FLASH_ADDRESS_RD <= "0";
        
        INT_AnalogReadout_WR <= "0";
        REG_AnalogReadout_WR <= x"00000000";
        
        INT_EnableCommonTrigger_WR <= "0";
        
	    BUS_ImageReadout_0_W_INT <= "0";
		INT_ImageReadout_0_READ_STATUS_RD <= "0";



	    BUS_i2c_0_W_INT <= "0";
		REG_i2c_0_REG_CTRL_WR <= (others => '0');
		INT_i2c_0_REG_CTRL_WR <= "0";
		INT_i2c_0_REG_MON_RD <= "0";
			
		elsif rising_edge(clk) then
            f_BUS_DATASTROBE_REG <= '0';
            INT_ValEvt_WR  <= "0";
            INT_ValEvt_RD <= "0";
            INT_Rstb_WR <= "0";
            INT_Rstb_RD <= "0";
            INT_Startb_WR <= "0";
            INT_Startb_RD <= "0";		
            INT_Fiforeset_WR <= "0";
            INT_Fiforeset_RD <= "0";
            INT_SelfTrigger_WR <= "0";
            INT_SelfTrigger_RD <= "0";
            INT_SelfTriggerPeriod_WR <= "0";
            INT_SelfTriggerPeriod_RD <= "0";
            INT_TriggerMode_WR <= "0";
            INT_TriggerMode_RD <= "0";  
            INT_T0sel_WR <= "0";                             
            INT_T0sel_RD <= "0";                             
            INT_T0sw_WR <= "0";                             
            INT_T0sw_RD <= "0";                             
            INT_T0sw_mode_WR <= "0";                             
            INT_T0sw_mode_RD <= "0";                             
            INT_T0sw_freq_WR <= "0";                             
            INT_T0sw_freq_RD <= "0";                             
            INT_AsicDisable_WR <= "0";
            INT_AsicDisable_RD <= "0";
            INT_AnalogReadout_WR <= "0";
            INT_FLASH_CNTR_WR <= "0";
            INT_FLASH_CNTR_RD <= "0";
            INT_FLASH_ADDRESS_WR <= "0";
            INT_FLASH_ADDRESS_RD <= "0";                      
            INT_TRGsel_WR <= "0"; 
            INT_EnableCommonTrigger_WR <= "0";
            INT_EnableExtTrigger_WR<="0";
            INT_EnableExtVeto_WR <= "0";
            INT_ResetTDCOnT0_WR <= "0"; 
            
            BUS_ImageReadout_0_W_INT <= "0";
            INT_ImageReadout_0_READ_STATUS_RD <= "0";
            INT_HOLD_DELAY_CNTR_WR <= "0"; 
            INT_REG_EXT_HOLD_EN_WR <= "0"; 
    
            BUS_i2c_0_W_INT <= "0";
            INT_i2c_0_REG_CTRL_WR <= "0";
            INT_i2c_0_REG_MON_RD <= "0";
      
                    if f_BUS_INT_WR = '1' then
            if addr = x"FFFFF900"  then
                REG_ValEvt_WR  <= wreg; 
                INT_ValEvt_WR <= "1"; 
            end if;
            
            if addr = x"FFFFF902"  then
                REG_Rstb_WR   <= wreg; 
                INT_Rstb_WR <= "1"; 
            end if;		
    
            if addr = x"FFFFF905"  then
                REG_Startb_WR    <= wreg; 
                INT_Startb_WR <= "1"; 
            end if;		
    
            if addr = x"FFFFF908"  then
                REG_Fiforeset_WR    <= wreg; 
                INT_Fiforeset_WR <= "1"; 
            end if;		
            
            if addr = x"FFFFF90D"  then
                REG_SelfTrigger_WR    <= wreg; 
                INT_SelfTrigger_WR <= "1"; 
            end if;        
            
            if addr = x"FFFFF90E"  then
                REG_SelfTriggerPeriod_WR    <= wreg; 
                INT_SelfTriggerPeriod_WR <= "1"; 
            end if;        

            if addr = x"FFFFF910"  then
                REG_TriggerMode_WR    <= wreg; 
                INT_TriggerMode_WR <= "1"; 
            end if;        


            if addr = x"FFFFF911"  then
                REG_T0sel_WR     <= wreg; 
                INT_T0sel_WR <= "1"; 
            end if;    

            if addr = x"FFFFF912"  then
                REG_T0sw_WR     <= wreg; 
                INT_T0sw_WR <= "1"; 
            end if;    

            if addr = x"FFFFF913"  then
                REG_T0sw_mode_WR     <= wreg; 
                INT_T0sw_mode_WR <= "1"; 
            end if;    

            if addr = x"FFFFF914"  then
                REG_T0sw_freq_WR     <= wreg; 
                INT_T0sw_freq_WR <= "1"; 
            end if;    
            
            if addr = x"FFFFF915"  then
                REG_AsicDisable_WR     <= wreg; 
                INT_AsicDisable_WR <= "1"; 
            end if;              
            
            if addr = x"FFFFF916"  then
                REG_AnalogReadout_WR     <= wreg; 
                INT_AnalogReadout_WR <= "1"; 
            end if;             
            
            if addr = x"FFFFF917"  then
                REG_TRGsel_WR     <= wreg; 
                INT_TRGsel_WR <= "1"; 
            end if;             
            
            if addr = x"FFFFF918"  then
                REG_EnableCommonTrigger_WR   <= wreg; 
                INT_EnableCommonTrigger_WR <= "1"; 
            end if;             
            
            if addr = x"FFFFF919"  then
                REG_EnableExtVeto_WR   <= wreg; 
                INT_EnableExtVeto_WR <= "1"; 
            end if;             
                                        
            if addr = x"FFFFF91A"  then
                REG_EnableExtTrigger_WR   <= wreg; 
                INT_EnableExtTrigger_WR <= "1"; 
            end if;       
            
            if addr = x"FFFFF91B"  then
                REG_ResetTDCOnT0_WR   <= wreg; 
                INT_ResetTDCOnT0_WR <= "1"; 
            end if;       
            
            
            if addr = x"FFFFF91C"  then
                REG_HOLD_DELAY_CNTR_WR   <= wreg; 
                INT_HOLD_DELAY_CNTR_WR <= "1"; 
            end if;       
              
            if addr = x"FFFFF91D"  then
                REG_EXT_HOLD_EN_WR   <= wreg; 
                INT_REG_EXT_HOLD_EN_WR <= "1"; 
            end if;                  

                            
            if addr = x"FFFEF000"  then
                REG_FLASH_CNTR_WR     <= wreg; 
                INT_FLASH_CNTR_WR <= "1"; 
            end if; 

            if addr = x"FFFEF001"  then
                REG_FLASH_ADDRESS_WR     <= wreg; 
                INT_FLASH_ADDRESS_WR <= "1"; 
            end if;                           
            
            If addr >= x"80000000" And addr < x"80000001" Then
                BUS_ImageReadout_0_WRITE_DATA <= wreg; 
                BUS_ImageReadout_0_W_INT <= "1"; 
            End If;
            
            
            
            If addr >= x"80050007" And addr < x"80050008" Then
                BUS_i2c_0_WRITE_DATA <= wreg; 
                BUS_i2c_0_W_INT <= "1"; 
            End If;
            if addr = x"80050008" then
                REG_i2c_0_REG_CTRL_WR <= wreg; 
                INT_i2c_0_REG_CTRL_WR <= "1"; 
            end if;
    
            end if;
    
    
            if f_BUS_INT_RD = '1' then
                f_BUS_DATASTROBE_REG <= '1';
                rreg := x"DEADBEEF";
                if addr = x"FFFFF900" then
                    rreg := REG_ValEvt_RD; 
                    INT_ValEvt_RD <= "1";
                End If;
                if addr = x"FFFFF902" then
                    rreg := REG_Rstb_RD; 
                    INT_Rstb_RD <= "1";
                End If;
                if addr = x"FFFFF905" then
                    rreg := REG_Startb_RD;
                    INT_Startb_RD <= "1";	 
                End If;
                if addr = x"FFFFF908" then
                    rreg := REG_Fiforeset_RD;
                    INT_Fiforeset_RD <= "1"; 
                End If;
                if addr = x"FFFFF90D" then
                    rreg := REG_SelfTrigger_RD;
                    INT_SelfTrigger_RD <= "1"; 
                End If; 
                if addr = x"FFFFF90E" then
                    rreg := REG_SelfTriggerPeriod_RD;
                    INT_SelfTriggerPeriod_RD <= "1"; 
                End If;                                                
                if addr = x"FFFFF910" then
                    rreg := REG_TriggerMode_RD;
                    INT_TriggerMode_RD <= "1"; 
                End If;                                                
                if addr = x"FFFFF911" then
                    rreg := REG_T0sel_RD;
                    INT_T0sel_RD <= "1"; 
                End If;    
                if addr = x"FFFFF912" then
                    rreg := REG_T0sw_RD;
                    INT_T0sw_RD <= "1"; 
                End If;    
                if addr = x"FFFFF913" then
                    rreg := REG_T0sw_mode_RD;
                    INT_T0sw_mode_RD <= "1"; 
                End If;    
                if addr = x"FFFFF914" then
                    rreg := REG_T0sw_freq_RD;
                    INT_T0sw_freq_RD <= "1"; 
                End If;    
                if addr = x"FFFFF915" then
                    rreg := REG_AsicDisable_RD;
                    INT_AsicDisable_RD <= "1"; 
                End If;    
                if addr = x"FFFFF916" then
                    rreg := REG_AnalogReadout_RD;
                    INT_AnalogReadout_RD <= "1"; 
                End If;                 

                if addr = x"FFFEF000" then
                    rreg := REG_FLASH_CNTR_RD;
                    INT_FLASH_CNTR_RD <= "1"; 
                End If;    
                if addr = x"FFFEF001" then
                    rreg := REG_FLASH_ADDRESS_RD;
                    INT_FLASH_CNTR_RD <= "1"; 
                End If;                   
                if addr = x"FFFEFFFF" then
                    rreg := x"1234ABBA";
                    INT_FLASH_CNTR_RD <= "1"; 
                End If;   
                
                if addr = x"FFFFFFFA" then
                    rreg := REG_FIRMWARE_BUILD;
                    INT_FLASH_CNTR_RD <= "1"; 
                End If;   
                
                
                if addr = x"FFFEFFFC" then
                    rreg := x"20180925";
                    INT_FLASH_CNTR_RD <= "1"; 
                End If;                               
                
                if addr = x"80000001" then
                    rreg := REG_ImageReadout_0_READ_STATUS_RD; 
                End If;
            
                if addr = x"80050009" then
                    rreg := REG_i2c_0_REG_MON_RD; 
                End If;
        
                f_BUS_DATA_RD_REG <= rreg;
            end if;

		end if;
	end process;
	

end Behavioral;

