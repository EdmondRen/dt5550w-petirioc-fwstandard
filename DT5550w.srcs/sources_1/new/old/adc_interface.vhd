----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.12.2016 19:00:34
-- Design Name: 
-- Module Name: adc_interface - Behavioral
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

entity adc_interface is
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
end adc_interface;

architecture Behavioral of adc_interface is
signal counter : std_logic_vector (26 downto 0);
    signal clk : std_logic;

    component ADC_REC_1
    generic
     (-- width of the data for the system
      SYS_W       : integer := 17;
      -- width of the data for the device
      DEV_W       : integer := 238);
    port
     (
      -- From the system into the device
      data_in_from_pins_p     : in    std_logic_vector(SYS_W-1 downto 0);
      data_in_from_pins_n     : in    std_logic_vector(SYS_W-1 downto 0);
      data_in_to_device       : out   std_logic_vector(DEV_W-1 downto 0);
      
      in_delay_reset          : in std_logic;
      in_delay_data_ce        : in    std_logic_vector(SYS_W-1 downto 0);
      in_delay_data_inc       : in    std_logic_vector(SYS_W-1 downto 0);
      in_delay_tap_in         : in    std_logic_vector((5*SYS_W)-1 downto 0);
      in_delay_tap_out        : out   std_logic_vector((5*SYS_W)-1 downto 0);
     
      delay_locked            : out   std_logic;
      ref_clock               : in    std_logic;

      bitslip                 : in    std_logic_vector(SYS_W-1 downto 0);                    -- Bitslip module is enabled in NETWORKING mode
                                                                    -- User should tie it to '0' if not needed
     
    -- Clock and reset signals
      clk_in_int              : in    std_logic;                    -- Differential fast clock from IOB
      clk_div_out             : out   std_logic;                    -- Slow clock output
      clk_reset               : in    std_logic;                    -- Reset signal for Clock circuit
      io_reset                : in    std_logic);                   -- Reset signal for IO circuit
    end component;    
    
   
    component adc_sync 
        Port ( 
            clk : in std_logic;
            start_delay : in std_logic;
            bitsleep : out std_logic_vector(16 downto 0);
            probe_data : in  std_logic_vector (13 downto 0);
            adc_frame : in std_logic_vector (13 downto 0);
            serdes_delay : out std_logic_vector(7 downto 0);
            serdes_dprog : out std_logic;
            obit_locked : out std_logic;
            initialized : out std_logic
        );
    end component;
    
    
    component fifo_generator_0 
      PORT (
        rst : IN STD_LOGIC;
        wr_clk : IN STD_LOGIC;
        rd_clk : IN STD_LOGIC;
        din : IN STD_LOGIC_VECTOR(223 DOWNTO 0);
        wr_en : IN STD_LOGIC;
        rd_en : IN STD_LOGIC;
        dout : OUT STD_LOGIC_VECTOR(111 DOWNTO 0);
        full : OUT STD_LOGIC;
        empty : OUT STD_LOGIC
      );
    END component;
    
    
    signal data_in_to_device1 : std_logic_vector (237 downto 0) := (others => '0');
    
    
    signal clk_div_out1             :    std_logic :='0';
       
    attribute keep : string; 
    
    
    signal ADC_F_0 : std_logic_vector (13 downto 0);
    signal ADC_F_1 : std_logic_vector (13 downto 0);
    signal ADC_A_0 : std_logic_vector (13 downto 0);
    signal ADC_B_0 : std_logic_vector (13 downto 0);
    signal ADC_A_1 : std_logic_vector (13 downto 0);
    signal ADC_B_1 : std_logic_vector (13 downto 0);
    signal ADC_A_2 : std_logic_vector (13 downto 0);
    signal ADC_B_2 : std_logic_vector (13 downto 0);
    signal ADC_A_3 : std_logic_vector (13 downto 0);
    signal ADC_B_3 : std_logic_vector (13 downto 0);
    signal ADC_A_4 : std_logic_vector (13 downto 0);
    signal ADC_B_4 : std_logic_vector (13 downto 0);
    signal ADC_A_5 : std_logic_vector (13 downto 0);
    signal ADC_B_5 : std_logic_vector (13 downto 0);
    signal ADC_A_6 : std_logic_vector (13 downto 0);
    signal ADC_B_6 : std_logic_vector (13 downto 0);
    signal ADC_A_7 : std_logic_vector (13 downto 0);
    signal ADC_B_7 : std_logic_vector (13 downto 0);
   
   
   
    signal DATA_A_0 : std_logic_vector (13 downto 0);
    signal DATA_B_0 : std_logic_vector (13 downto 0);
    signal DATA_A_1 : std_logic_vector (13 downto 0);
    signal DATA_B_1 : std_logic_vector (13 downto 0);
    signal DATA_A_2 : std_logic_vector (13 downto 0);
    signal DATA_B_2 : std_logic_vector (13 downto 0);
    signal DATA_A_3 : std_logic_vector (13 downto 0);
    signal DATA_B_3 : std_logic_vector (13 downto 0);
    signal DATA_A_4 : std_logic_vector (13 downto 0);
    signal DATA_B_4 : std_logic_vector (13 downto 0);
    signal DATA_A_5 : std_logic_vector (13 downto 0);
    signal DATA_B_5 : std_logic_vector (13 downto 0);
    signal DATA_A_6 : std_logic_vector (13 downto 0);
    signal DATA_B_6 : std_logic_vector (13 downto 0);
    signal DATA_A_7 : std_logic_vector (13 downto 0);
    signal DATA_B_7 : std_logic_vector (13 downto 0);
 

   
   attribute keep of ADC_F_0: signal is "true";
   attribute keep of ADC_F_1: signal is "true";
   
   attribute keep of ADC_A_0: signal is "true";
   attribute keep of ADC_B_0: signal is "true";
   attribute keep of ADC_A_1: signal is "true";
   attribute keep of ADC_B_1: signal is "true";
   attribute keep of ADC_A_2: signal is "true";
   attribute keep of ADC_B_2: signal is "true";
   attribute keep of ADC_A_3: signal is "true";
   attribute keep of ADC_B_3: signal is "true";
   attribute keep of ADC_A_4: signal is "true";
   attribute keep of ADC_B_4: signal is "true";
   attribute keep of ADC_A_5: signal is "true";
   attribute keep of ADC_B_5: signal is "true";
   attribute keep of ADC_A_6: signal is "true";
   attribute keep of ADC_B_6: signal is "true";
   attribute keep of ADC_A_7: signal is "true";
   attribute keep of ADC_B_7: signal is "true";
   
   attribute keep of DATA_A_0: signal is "true";
   attribute keep of DATA_B_0: signal is "true";
   attribute keep of DATA_A_1: signal is "true";
   attribute keep of DATA_B_1: signal is "true";
   attribute keep of DATA_A_2: signal is "true";
   attribute keep of DATA_B_2: signal is "true";
   attribute keep of DATA_A_3: signal is "true";
   attribute keep of DATA_B_3: signal is "true";
   attribute keep of DATA_A_4: signal is "true";
   attribute keep of DATA_B_4: signal is "true";
   attribute keep of DATA_A_5: signal is "true";
   attribute keep of DATA_B_5: signal is "true";
   attribute keep of DATA_A_6: signal is "true";
   attribute keep of DATA_B_6: signal is "true";
   attribute keep of DATA_A_7: signal is "true";
   attribute keep of DATA_B_7: signal is "true";   
        
    signal SMADC_CS :  std_logic := '1';

   signal bitsleep1 : std_logic_vector(16 downto 0) := "00000000000000000";
   
   
   signal start_delay : std_logic := '0';

   
   signal reset_counter : integer :=0;
   signal reset_sm : std_logic_vector(3 downto 0) := x"0";
   signal reset_sm_d : std_logic_vector(3 downto 0) := x"0";
   signal delay_rs : std_logic_vector(15 downto 0) := x"0000";    
   signal reset_clkref_dcm : std_logic := '0';


   signal serdes_ioreset : std_logic := '0';
   signal serdes_delayreset : std_logic := '0';
   signal serdes_reset : std_logic := '0';
   
  
   signal serdes1_program_delay : std_logic := '0';
   signal serdes1_delaylock : std_logic := '0';
   signal serdes1_delay : std_logic_vector( (5*17) -1 downto 0) := (others => '0');
   signal serdes1_delay_temp : std_logic_vector( 7 downto 0) := (others => '0');
   
   
   
   signal adc_programmed : std_logic := '0';
   
   
   signal bit_locked1 : std_logic := '0';
   signal initialized1 :std_logic := '0';
    
    attribute keep of bit_locked1: signal is "true";
    attribute keep of initialized1: signal is "true";

    signal FIFO1_DIN : std_logic_vector(223 downto 0);
    signal FIFO1_DOUT : std_logic_vector(111 downto 0);
    signal FIFO1_empty : std_logic;
    
    signal ADC_READY : STD_LOGIC;
    attribute keep of ADC_READY: signal is "true";
    
    
    signal ADC_BIT_CLOCK : std_logic;
    signal ADC_BIT_CLOCKii : std_logic;
    
--attribute IODELAY_GROUP : STRING;
--attribute IODELAY_GROUP of IDELAYCTRL_inst: label is IODELAY_GROUP_NAME;
begin


    ADC_OUTFIFO1: fifo_generator_0 
      PORT MAP(
        rst => serdes_reset,
        wr_clk => clk_div_out1,
        rd_clk  => eCLK,
        din  => FIFO1_DIN,
        wr_en  => '1',
        rd_en  => eREAD,
        dout =>  FIFO1_DOUT,
        full  => open,
        empty  => FIFO1_empty
      );
      

eDATA_OUT <=       FIFO1_DOUT;



     
     eEMPTY <= FIFO1_empty;
     
    
               

     FIFO1_DIN <=  DATA_B_7 & DATA_B_6 & DATA_B_5 & DATA_B_4 & DATA_B_3 & DATA_B_2 & DATA_B_1 & DATA_B_0 &
                    DATA_A_7 & DATA_A_6 & DATA_A_5 & DATA_A_4 & DATA_A_3 & DATA_A_2 & DATA_A_1 & DATA_A_0;
     



reset_process : process(sCLK_25)
    begin
    
        if rising_edge(sCLK_25) then
            case reset_sm is
                when x"0" =>
                    reset_clkref_dcm <= '1';
                    delay_rs <= x"000F";
                    reset_sm_d <= x"1";
                    reset_sm <= x"F";
                 
                when x"1" =>
                    reset_clkref_dcm <= '0';
                    if locked_dcmref = '1' and adc_programmed = '1' then
                        reset_sm <= x"2";
                    end if;
                    
                when x"2" =>
                    serdes_ioreset <= '1';
                    delay_rs <= x"000F";
                    reset_sm_d <= x"3";
                    reset_sm <= x"F";
                when x"3" =>
                    serdes_ioreset <= '0';
                    delay_rs <= x"003F";
                    reset_sm_d <= x"4";
                    reset_sm <= x"F";
                when x"4" =>
                   serdes_delayreset <= '1';
                   delay_rs <= x"000F";
                   reset_sm_d <= x"5";
                   reset_sm <= x"F";               
                when x"5" =>
                   serdes_delayreset <= '0';
                   delay_rs <= x"003F";
                   reset_sm_d <= x"6";
                    reset_sm <= x"F";
                when x"6" =>
                   serdes_reset <= '1';
                   delay_rs <= x"000F";
                   reset_sm_d <= x"7";
                   reset_sm <= x"F";
                when x"7" =>
                   serdes_reset <= '0';
                   delay_rs <= x"003F";
                   reset_sm_d <= x"8";                                                                    
                   reset_sm <= x"F";
                when x"8" =>
                   if serdes1_delaylock = '1' then
                     start_delay <= '1';
                   end if;
                    
                when x"F" =>
                    if delay_rs = x"0000" then
                        reset_sm <= reset_sm_d;
                    else
                        delay_rs <= delay_rs-1;
                    end if;
                when others =>
                  reset_sm <= x"0";
              end case;
        end  if;
    
    end process;

    clk <= sCLK_25;

   
    SMADC_CSA <= SMADC_CS;
    SMADC_CSB <= SMADC_CS;
aaprog: block
        signal SMADC : std_logic_vector(3 downto 0) := x"0";
        signal SMADCnew : std_logic_vector(3 downto 0) := x"0";
        signal SMADCwordwrite : std_logic_vector(23 downto 0) := x"000000";
        signal SMID : integer :=0;
        signal idx : integer := 0;
        signal SMdelay : std_logic_vector(15 downto 0);
        signal ramp_counter : std_logic_vector(13 downto 0):= (others => '0');
        signal ramp_next : std_logic;
        signal delay_end : integer range 0 to 10000;
        attribute keep of ramp_next: signal is "true";
        attribute keep of ramp_counter: signal is "true";
    begin
        programmachine : process (clk) 
        begin
            if rising_edge(clk) then
            ramp_next <= '0';
                case SMADC is
                    
                    when x"0" =>
                        SMADC_CS <= '1';
                        SMADC_MOSI <= '1';
                        idx <= 0;
                        case SMID is
                            when 0 =>
                                ADC_READY <= '0'; 
                                SMADC <= x"F";
                                SMADCnew <= x"0";
                                SMdelay <= x"03FF";                        
                                SMID <= SMID +1;
                                SMADC_1_RESET <= '1';
                            when 1 =>
                                --SMADCwordwrite <= X"000001";
                                SMADC_1_RESET <= '0';
                                SMID <= SMID +1;
                                --SMADC <= x"1";
                            when 2 =>
                                SMADC <= x"F";
                                SMADCnew <= x"0";
                                SMdelay <= x"FFFF";                        
                                SMID <= SMID +1;                                                            
                            when 3 =>
                                SMADCwordwrite <= X"46A409";
                                SMID <= SMID +1;
                                SMADC <= x"1";
                            when 4 =>
                                    SMADCwordwrite <= X"280000";
                                    SMID <= SMID +1;
                                    SMADC <= x"1";
                            when 5 =>
                                    SMADCwordwrite <= X"450001";
                                    SMID <= SMID +1;
                                    SMADC <= x"1";

                            when 6 =>
                                adc_programmed <= '1'; 
                                
                                if initialized1 = '1' then --and initialized2 = '1'  then
                                    delay_end <= 9000;
                                    SMID <= 10;
                                end if;
                            when 7=>
                                --ramp_next <= '1';   
                                --SMADCwordwrite <= X"03" & "10" & ramp_counter(13 downto 8);
                                --SMID <= SMID +1;
                                SMADCwordwrite <= X"250000";  --250040 per la rampa
                                SMID <= 9;
                                SMADC <= x"1";                               
                            when 8=>
                                --SMADCwordwrite <= X"04" & ramp_counter(7 downto 0);
                                SMID <= 7;
                                SMADC <= x"1";                        
                                ramp_counter <= ramp_counter +1;   
                            
                            when 9=>
                            
                            when 10=>
                                if delay_end = 0 then
                                    SMADCwordwrite <= X"450000";
                                   -- SMID <= SMID +1;
                                    SMID <= 7;
                                    SMADC <= x"1";                                
                                
                                else
                                    delay_end <= delay_end -1;
                                end if;
                                   
                            when others =>
                        end case;
                    when x"1" => 
                        SMADC_CLK <= '0';
                        SMADC_CS <= '0';
                        SMADC <= x"F";
                        SMADCnew <= x"2";
                        SMdelay <= x"00FF";
                        
                    when x"2" =>
                        SMADC_CLK <= '0';
                        SMADC_CS <= '0';
                        SMADC_MOSI <= SMADCwordwrite(23-idx);   
                        idx <= idx +1;
                        SMdelay <= x"00FF";
                        SMADC <= x"F";
                        SMADCnew <= x"3";
                        
                    when x"3" =>
                        SMADC_CLK <= '1';
                        SMdelay <= x"00FF";
                        SMADC <= x"F";
                        SMADCnew <= x"2";
                        
                        if idx = 24 then
                            SMdelay <= x"00FF";
                            SMADC <= x"F";
                            SMADCnew <= x"A";
                        end if;
                        
                    when x"A" =>
                         SMADC_CS <= '1';
                         SMdelay <= x"01FF";
                         SMADC <= x"F";
                         SMADCnew <= x"0";                     
      
          
                    when x"F" => 
                        if SMdelay = x"0000" then
                            SMADC <= SMADCnew;
                        else
                            SMdelay <= SMdelay-1; 
                        end if;
                        
                        
                    when others =>
                 end case;
                            
            end if;
        end process;
        
      end block; 
    

           
    ADDESR: for I in 0 to 13 generate
       begin
        ADS1: process(clk_div_out1) 
           begin

               if rising_edge(clk_div_out1) then
               --frame
                   ADC_F_0(I) <=   data_in_to_device1 ( (I * 17) + 0 );
               --A 0
                   if ADC_B_INV(0) = '0' then
                    ADC_A_0(I) <=   data_in_to_device1 ( (I * 17) + 1 );
                   else
                    ADC_A_0(I) <=   not data_in_to_device1 ( (I * 17) + 1 );
                   end if;
               --B 0
                   if ADC_A_INV(0) = '0' then
                    ADC_B_0(I) <=   data_in_to_device1 ( (I * 17) + 2 );
                   else
                    ADC_B_0(I) <=   not data_in_to_device1 ( (I * 17) + 2 );
                   end if;
               --A 1
                   if ADC_B_INV(1) = '0' then    
                    ADC_A_1(I) <=   data_in_to_device1 ( (I * 17) + 3 );
                   else
                    ADC_A_1(I) <=   not data_in_to_device1 ( (I * 17) + 3 );
                   end if;
               --B 1
                   if ADC_A_INV(1) = '0' then   
                    ADC_B_1(I) <=   data_in_to_device1 ( (I * 17) + 4 );
                   else
                    ADC_B_1(I) <=   not data_in_to_device1 ( (I * 17) + 4 );
                   end if;
               --A 2
                   if ADC_B_INV(2) = '0' then                    
                    ADC_A_2(I) <=   data_in_to_device1 ( (I * 17) + 5 );
                   else
                    ADC_A_2(I) <=   not data_in_to_device1 ( (I * 17) + 5 );
                   end if;
               --B 2
                   if ADC_A_INV(2) = '0' then  
                    ADC_B_2(I) <=   data_in_to_device1 ( (I * 17) + 6 );
                   else
                    ADC_B_2(I) <=   not data_in_to_device1 ( (I * 17) + 6 );
                   end if;
               --A 3
                   if ADC_B_INV(3) = '0' then  
                    ADC_A_3(I) <=   data_in_to_device1 ( (I * 17) + 7 );
                   else
                    ADC_A_3(I) <=   not data_in_to_device1 ( (I * 17) + 7 );
                   end if;
               --B 3 
                   if ADC_A_INV(3) = '0' then
                    ADC_B_3(I) <=   data_in_to_device1 ( (I * 17) + 8 ); 
                   else
                    ADC_B_3(I) <=   not data_in_to_device1 ( (I * 17) + 8 ); 
                   end if;
               --A 4
                   if ADC_B_INV(4) = '0' then
                    ADC_A_4(I) <=   data_in_to_device1 ( (I * 17) + 9 );
                   else
                    ADC_A_4(I) <=   not data_in_to_device1 ( (I * 17) + 9 );
                   end if;
               --B 4
                   if ADC_A_INV(4) = '0' then
                    ADC_B_4(I) <=   data_in_to_device1 ( (I * 17) + 10 );
                   else
                    ADC_B_4(I) <=   not data_in_to_device1 ( (I * 17) + 10 );
                   end if;
               --A 5
                   if ADC_B_INV(5) = '0' then    
                    ADC_A_5(I) <=   data_in_to_device1 ( (I * 17) + 11 );
                   else
                    ADC_A_5(I) <=   not data_in_to_device1 ( (I * 17) + 11 );
                   end if;
               --B 5
                   if ADC_A_INV(5) = '0' then   
                    ADC_B_5(I) <=   data_in_to_device1 ( (I * 17) + 12 );
                   else
                    ADC_B_5(I) <=   not data_in_to_device1 ( (I * 17) + 12 );
                   end if;
               --A 6
                   if ADC_B_INV(6) = '0' then                    
                    ADC_A_6(I) <=   data_in_to_device1 ( (I * 17) + 13 );
                   else
                    ADC_A_6(I) <=   not data_in_to_device1 ( (I * 17) + 13 );
                   end if;
               --B 6
                   if ADC_A_INV(6) = '0' then  
                    ADC_B_6(I) <=   data_in_to_device1 ( (I * 17) + 14 );
                   else
                    ADC_B_6(I) <=   not data_in_to_device1 ( (I * 17) + 14 );
                   end if;
               --A 7
                   if ADC_B_INV(7) = '0' then  
                    ADC_A_7(I) <=   data_in_to_device1 ( (I * 17) + 15 );
                   else
                    ADC_A_7(I) <=   not data_in_to_device1 ( (I * 17) + 15 );
                   end if;
               --B 7 
                   if ADC_A_INV(7) = '0' then
                    ADC_B_7(I) <=   data_in_to_device1 ( (I * 17) + 16 ); 
                   else
                    ADC_B_7(I) <=   not data_in_to_device1 ( (I * 17) + 16 ); 
                   end if;                                                                              
               end if;
           end process; 
           
        
    end generate;
             
     DATA_A_0 <= ADC_A_0(7) & ADC_A_0(8) & ADC_A_0(9) & ADC_A_0(10) & ADC_A_0(11) & ADC_A_0(12) & ADC_A_0(13) & ADC_B_0(7) & ADC_B_0(8) & ADC_B_0(9) & ADC_B_0(10) & ADC_B_0(11) & ADC_B_0(12) & ADC_B_0(13) ;
     DATA_B_0 <= ADC_A_0(0) & ADC_A_0(1) & ADC_A_0(2) & ADC_A_0(3) &  ADC_A_0(4) &  ADC_A_0(5) &  ADC_A_0(6) &  ADC_B_0(0) & ADC_B_0(1) & ADC_B_0(2) & ADC_B_0(3) &  ADC_B_0(4) &  ADC_B_0(5) &  ADC_B_0(6) ;     
     DATA_A_1 <= ADC_A_1(7) & ADC_A_1(8) & ADC_A_1(9) & ADC_A_1(10) & ADC_A_1(11) & ADC_A_1(12) & ADC_A_1(13) & ADC_B_1(7) & ADC_B_1(8) & ADC_B_1(9) & ADC_B_1(10) & ADC_B_1(11) & ADC_B_1(12) & ADC_B_1(13) ;
     DATA_B_1 <= ADC_A_1(0) & ADC_A_1(1) & ADC_A_1(2) & ADC_A_1(3) &  ADC_A_1(4) &  ADC_A_1(5) &  ADC_A_1(6) &  ADC_B_1(0) & ADC_B_1(1) & ADC_B_1(2) & ADC_B_1(3) &  ADC_B_1(4) &  ADC_B_1(5) &  ADC_B_1(6) ;
     DATA_A_2 <= ADC_A_2(7) & ADC_A_2(8) & ADC_A_2(9) & ADC_A_2(10) & ADC_A_2(11) & ADC_A_2(12) & ADC_A_2(13) & ADC_B_2(7) & ADC_B_2(8) & ADC_B_2(9) & ADC_B_2(10) & ADC_B_2(11) & ADC_B_2(12) & ADC_B_2(13) ;
     DATA_B_2 <= ADC_A_2(0) & ADC_A_2(1) & ADC_A_2(2) & ADC_A_2(3) &  ADC_A_2(4) &  ADC_A_2(5) &  ADC_A_2(6) &  ADC_B_2(0) & ADC_B_2(1) & ADC_B_2(2) & ADC_B_2(3) &  ADC_B_2(4) &  ADC_B_2(5) &  ADC_B_2(6) ;
     DATA_A_3 <= ADC_A_3(7) & ADC_A_3(8) & ADC_A_3(9) & ADC_A_3(10) & ADC_A_3(11) & ADC_A_3(12) & ADC_A_3(13) & ADC_B_3(7) & ADC_B_3(8) & ADC_B_3(9) & ADC_B_3(10) & ADC_B_3(11) & ADC_B_3(12) & ADC_B_3(13) ;
     DATA_B_3 <= ADC_A_3(0) & ADC_A_3(1) & ADC_A_3(2) & ADC_A_3(3) &  ADC_A_3(4) &  ADC_A_3(5) &  ADC_A_3(6) &  ADC_B_3(0) & ADC_B_3(1) & ADC_B_3(2) & ADC_B_3(3) &  ADC_B_3(4) &  ADC_B_3(5) &  ADC_B_3(6) ;     
     DATA_A_4 <= ADC_A_4(7) & ADC_A_4(8) & ADC_A_4(9) & ADC_A_4(10) & ADC_A_4(11) & ADC_A_4(12) & ADC_A_4(13) & ADC_B_4(7) & ADC_B_4(8) & ADC_B_4(9) & ADC_B_4(10) & ADC_B_4(11) & ADC_B_4(12) & ADC_B_4(13) ;
     DATA_B_4 <= ADC_A_4(0) & ADC_A_4(1) & ADC_A_4(2) & ADC_A_4(3) &  ADC_A_4(4) &  ADC_A_4(5) &  ADC_A_4(6) &  ADC_B_4(0) & ADC_B_4(1) & ADC_B_4(2) & ADC_B_4(3) &  ADC_B_4(4) &  ADC_B_4(5) &  ADC_B_4(6) ;
     DATA_A_5 <= ADC_A_5(7) & ADC_A_5(8) & ADC_A_5(9) & ADC_A_5(10) & ADC_A_5(11) & ADC_A_5(12) & ADC_A_5(13) & ADC_B_5(7) & ADC_B_5(8) & ADC_B_5(9) & ADC_B_5(10) & ADC_B_5(11) & ADC_B_5(12) & ADC_B_5(13) ;
     DATA_B_5 <= ADC_A_5(0) & ADC_A_5(1) & ADC_A_5(2) & ADC_A_5(3) &  ADC_A_5(4) &  ADC_A_5(5) &  ADC_A_5(6) &  ADC_B_5(0) & ADC_B_5(1) & ADC_B_5(2) & ADC_B_5(3) &  ADC_B_5(4) &  ADC_B_5(5) &  ADC_B_5(6) ;
     DATA_A_6 <= ADC_A_6(7) & ADC_A_6(8) & ADC_A_6(9) & ADC_A_6(10) & ADC_A_6(11) & ADC_A_6(12) & ADC_A_6(13) & ADC_B_6(7) & ADC_B_6(8) & ADC_B_6(9) & ADC_B_6(10) & ADC_B_6(11) & ADC_B_6(12) & ADC_B_6(13) ;
     DATA_B_6 <= ADC_A_6(0) & ADC_A_6(1) & ADC_A_6(2) & ADC_A_6(3) &  ADC_A_6(4) &  ADC_A_6(5) &  ADC_A_6(6) &  ADC_B_6(0) & ADC_B_6(1) & ADC_B_6(2) & ADC_B_6(3) &  ADC_B_6(4) &  ADC_B_6(5) &  ADC_B_6(6) ;
     DATA_A_7 <= ADC_A_7(7) & ADC_A_7(8) & ADC_A_7(9) & ADC_A_7(10) & ADC_A_7(11) & ADC_A_7(12) & ADC_A_7(13) & ADC_B_7(7) & ADC_B_7(8) & ADC_B_7(9) & ADC_B_7(10) & ADC_B_7(11) & ADC_B_7(12) & ADC_B_7(13) ;
     DATA_B_7 <= ADC_A_7(0) & ADC_A_7(1) & ADC_A_7(2) & ADC_A_7(3) &  ADC_A_7(4) &  ADC_A_7(5) &  ADC_A_7(6) &  ADC_B_7(0) & ADC_B_7(1) & ADC_B_7(2) & ADC_B_7(3) &  ADC_B_7(4) &  ADC_B_7(5) &  ADC_B_7(6) ;
                         
     

     
     
     

     
      ADC_DESER1 : ADC_REC_1
       port map 
       ( 
       data_in_from_pins_p(0) => ADC_BUS_FRAME_A_P,
       data_in_from_pins_p(1) => ADC_BUS_DATA_B_P(0),     --1
       data_in_from_pins_p(2) => ADC_BUS_DATA_A_P(0), 
       data_in_from_pins_p(3) => ADC_BUS_DATA_B_P(1),     --4
       data_in_from_pins_p(4) => ADC_BUS_DATA_A_P(1),
       data_in_from_pins_p(5) => ADC_BUS_DATA_B_P(2),     --5
       data_in_from_pins_p(6) => ADC_BUS_DATA_A_P(2),     
       data_in_from_pins_p(7) => ADC_BUS_DATA_B_P(3),     --8
       data_in_from_pins_p(8) => ADC_BUS_DATA_A_P(3),
       data_in_from_pins_p(9) => ADC_BUS_DATA_B_P(4),
       data_in_from_pins_p(10) => ADC_BUS_DATA_A_P(4),
       data_in_from_pins_p(11) => ADC_BUS_DATA_B_P(5),
       data_in_from_pins_p(12) => ADC_BUS_DATA_A_P(5),
       data_in_from_pins_p(13) => ADC_BUS_DATA_B_P(6),
       data_in_from_pins_p(14) => ADC_BUS_DATA_A_P(6),
       data_in_from_pins_p(15) => ADC_BUS_DATA_B_P(7),
       data_in_from_pins_p(16) => ADC_BUS_DATA_A_P(7),
       data_in_from_pins_n(0) => ADC_BUS_FRAME_A_N,
       data_in_from_pins_n(1) => ADC_BUS_DATA_B_N(0),
       data_in_from_pins_n(2) => ADC_BUS_DATA_A_N(0),
       data_in_from_pins_n(3) => ADC_BUS_DATA_B_N(1),
       data_in_from_pins_n(4) => ADC_BUS_DATA_A_N(1),
       data_in_from_pins_n(5) => ADC_BUS_DATA_B_N(2),
       data_in_from_pins_n(6) => ADC_BUS_DATA_A_N(2),
       data_in_from_pins_n(7) => ADC_BUS_DATA_B_N(3),
       data_in_from_pins_n(8) => ADC_BUS_DATA_A_N(3),
       data_in_from_pins_n(9) => ADC_BUS_DATA_B_N(4),
       data_in_from_pins_n(10) => ADC_BUS_DATA_A_N(4),
       data_in_from_pins_n(11) => ADC_BUS_DATA_B_N(5),
       data_in_from_pins_n(12) => ADC_BUS_DATA_A_N(5),
       data_in_from_pins_n(13) => ADC_BUS_DATA_B_N(6),
       data_in_from_pins_n(14) => ADC_BUS_DATA_A_N(6),
       data_in_from_pins_n(15) => ADC_BUS_DATA_B_N(7),
       data_in_from_pins_n(16) => ADC_BUS_DATA_A_N(7),

       data_in_to_device => data_in_to_device1,
       bitslip => bitsleep1,                           
       clk_in_int => ADC_BIT_CLOCK,                          
       clk_div_out => clk_div_out1,                       
       clk_reset => serdes_ioreset,
       io_reset => serdes_reset,

       in_delay_reset          => serdes1_program_delay,
       in_delay_data_ce        => "00000000000000000",
       in_delay_data_inc       => "00000000000000000",
       in_delay_tap_in         => serdes1_delay,
       in_delay_tap_out        => open,
       delay_locked            => serdes1_delaylock,
       ref_clock               => clock_ref
       
       
    );
    
    
       ADC_SYNC1: adc_sync 
         Port Map( 
             clk => clk_div_out1,
             start_delay => start_delay,
             bitsleep => bitsleep1,
             probe_data => ADC_A_0,
             adc_frame => ADC_F_0,
             serdes_delay => serdes1_delay_temp,
             serdes_dprog => serdes1_program_delay,
             obit_locked => bit_locked1,
             initialized => initialized1
         );

     
    serdes1_delay <= serdes1_delay_temp(4 downto 0) & serdes1_delay_temp(4 downto 0) & serdes1_delay_temp(4 downto 0) & serdes1_delay_temp(4 downto 0) &
                     serdes1_delay_temp(4 downto 0) & serdes1_delay_temp(4 downto 0) & serdes1_delay_temp(4 downto 0) & serdes1_delay_temp(4 downto 0) &
                     serdes1_delay_temp(4 downto 0) & serdes1_delay_temp(4 downto 0) & serdes1_delay_temp(4 downto 0) & serdes1_delay_temp(4 downto 0) &
                     serdes1_delay_temp(4 downto 0) & serdes1_delay_temp(4 downto 0) & serdes1_delay_temp(4 downto 0) & serdes1_delay_temp(4 downto 0) &
                     serdes1_delay_temp(4 downto 0);


 gen_clk_inv : if ADC_CLK_INV = '1' generate
 begin
    ADC_BIT_CLOCK <= not ADC_BIT_CLOCKii;
 end generate;
 
 gen_clk_notinv : if ADC_CLK_INV = '0' generate
 begin
     ADC_BIT_CLOCK <= ADC_BIT_CLOCKii;
  end generate;
    
    
  ADC_CLOCK_BUFFER : IBUFDS
   generic map (
      DIFF_TERM => TRUE, 
      IBUF_LOW_PWR => FALSE,
      IOSTANDARD => "LVDS")
   port map (
      O => ADC_BIT_CLOCKii, 
      I => ADC_BUS_CLK_A_P,
      IB => ADC_BUS_CLK_A_N
   );      
              
    
       
end Behavioral;
