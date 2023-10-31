library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

Library xpm;
use xpm.vcomponents.all;

library UNISIM;
use UNISIM.VComponents.all;

entity petiroc_datareceiver is
    Port (  
          clk : in std_logic;
          hold_ext_trigger : in std_logic;
          trigger_in : in std_logic;
          transmit_on : in std_logic;
          hold_external_hold : out std_logic;
          data_in : in std_logic;
          raz_chn_f : in std_logic;
          chrage_trig : in std_logic;
          start_conv : out std_logic;
          raz_chn : out std_logic;
          val_evnt : out std_logic;
          rstb : out std_logic;
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
end petiroc_datareceiver;

architecture Behavioral of petiroc_datareceiver is
--    component fifo_generator_0 IS
--      PORT (
--        rst : IN STD_LOGIC;
--        wr_clk : IN STD_LOGIC;
--        rd_clk : IN STD_LOGIC;
--        din : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
--        wr_en : IN STD_LOGIC;
--        rd_en : IN STD_LOGIC;
--        dout : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
--        full : OUT STD_LOGIC;
--        empty : OUT STD_LOGIC;
--        valid : OUT STD_LOGIC;
--        prog_empty : OUT STD_LOGIC;
--        prog_full : OUT STD_LOGIC
--      );
--    END component;

   
    signal TRASMIT_ON_o : std_logic:='0';
    signal TRASMIT_ON_i : std_logic:='0';        
    
    signal TRG0_o : std_logic:='0';
    signal TRG0_i : std_logic:='0';        
    signal idata : STD_LOGIC;
    signal bit_counter : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');

    signal skip : std_logic := '0';
    signal start_c_counter : std_logic_vector (7 downto 0) := x"1F";
    signal start_c_raz : std_logic_vector (7 downto 0) := x"FF";

    
    signal fifo_full : std_logic := '0';
    signal fifo_empty : std_logic := '0';
    signal fifo_we : std_logic := '0';
    signal FIFO_DIN : std_logic_vector (31 downto 0);
    
    signal storePackage : std_logic := '0';
    signal storeBitCounter: integer range 0 to 31 := 0;
    signal store_redoutregister : STD_LOGIC_VECTOR(31 downto 0);
            
    signal delay_counter : std_logic_vector(15 downto 0);
    signal run_trig_delay : std_logic := '0';
    
    signal T0counter : std_logic_vector (29 downto 0) := "00" & x"0000000";
    signal cT0counter : std_logic_vector (29 downto 0) := "00" & x"0000000";
    signal T0counter_sync : std_logic_vector (29 downto 0) := "00" & x"0000000";
    signal CapturedRun : std_logic_vector (63 downto 0) := (others => '0');
    
    signal DAQSM : std_logic_vector (3 downto 0) := x"0";
    
    signal timeoutWAITRASMITON : integer range 0 to 160000;
    signal inTrasmission : std_logic;
    signal end_counter : integer range 0 to 127;
    signal iDataWordT0 : std_logic_vector (32 -1 downto 0);
    signal iDataWord : std_logic_vector (32*32 -1 downto 0);
    signal WordCounter : integer range 0 to 63; 
    signal cRunTimer :  std_logic_vector (64 -1 downto 0);
    signal initCounter : integer range 0 to 1024;
    
    signal ichrage_trig : std_logic := '0';
    signal ochrage_trig : std_logic := '0';
    
    signal TimeStampI : std_logic;
    signal TimeStampIo : std_logic;
    signal EventTime :  std_logic_vector (29 downto 0) := "00" & x"0000000";
    
    signal iTRG_EXT : std_logic;
    signal oTRG_EXT : std_logic;
begin

xpm_RunTimer: xpm_cdc_array_single
  generic map (

    -- Common module generics
    DEST_SYNC_FF   => 4, -- integer; range: 2-10
    INIT_SYNC_FF   => 0, -- integer; 0=disable simulation init values, 1=enable simulation init values
    SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
    SRC_INPUT_REG  => 1, -- integer; 0=do not register input, 1=register input
    WIDTH          => 64  -- integer; range: 1-1024

  )
  port map (

    src_clk  => clk_timecode,  -- optional; required when SRC_INPUT_REG = 1
    src_in   => RunTimer,
    dest_clk => clk,
    dest_out => cRunTimer
  );


xpm_T0Timer: xpm_cdc_array_single
  generic map (

    -- Common module generics
    DEST_SYNC_FF   => 4, -- integer; range: 2-10
    INIT_SYNC_FF   => 0, -- integer; 0=disable simulation init values, 1=enable simulation init values
    SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
    SRC_INPUT_REG  => 1, -- integer; 0=do not register input, 1=register input
    WIDTH          => 30  -- integer; range: 1-1024

  )
  port map (

    src_clk  => clk_timecode,  -- optional; required when SRC_INPUT_REG = 1
    src_in   => EventTime,
    dest_clk => clk,
    dest_out => cT0counter
  );


    tcpr: process (clk_timecode)
    begin
        if rising_edge(clk_timecode) then
            if TriggerSelector='0' then
                TimeStampI <= TRG0_i;
            else
                TimeStampI <= ichrage_trig;
            end if; 
            TimeStampIo <= TimeStampI; 
            
            if T0 = '1' then
                T0counter <= (others => '0');
            else
                T0counter <= T0counter +1;
            end if;
            
            if (TimeStampIo='1' and TimeStampI='0') then
                EventTime <= T0counter;
            end if;
        end if;
    end process;

--    asic_fifo : fifo_generator_0 port map(
--        rst => fifo_reset,
--        wr_clk => clk,
--        rd_clk => fifo_clk,
--        din => FIFO_DIN,
--        wr_en => fifo_we,
--        rd_en => fifo_rd,
--        dout =>  fifo_data,
--        full => open,
--        empty => open,
--        valid => open,
--        prog_empty => fifo_empty,
--        prog_full => fifo_full
--    );   
    
    fifo_datavalid <= not fifo_empty;
    fifo_busy <= fifo_full;
 rd_process : process(clk)
   begin
    if rising_edge(clk) then
        ichrage_trig <= chrage_trig;
        ochrage_trig <= ichrage_trig;
        daq_event <= '0';
        daq_stroed_event <= '0';    
        fifo_we <= '0';
        if start_c_raz = x"00" then
            raz_chn <= '1';
            val_evnt <= '1';
        else
            if start_c_raz = x"0F" then
                raz_chn <= '1';
                val_evnt <= '0';
            else
                if start_c_raz = x"0A" then
                    raz_chn <= '0';
                else
                    if start_c_raz = x"07" then
                        raz_chn <= '1';
                    end if;
                end if;
            end if;
             
                start_c_raz <= start_c_raz -1; 
        end if;
        TRG0_i <= trigger_in; 
        TRG0_o <= TRG0_i;
        
        idata <= data_in;
        TRASMIT_ON_i <= transmit_on;
        TRASMIT_ON_o <= TRASMIT_ON_i;
        
        iTRG_EXT <=  hold_ext_trigger;
        oTRG_EXT <= iTRG_EXT;
                   if start_c_counter = x"0" then
                        START_CONV <= '0';
                    else
                        start_c_counter <= start_c_counter -1;
                    end if;
                    
                    
                     
        case DAQSM is 
            when x"0" =>
                if TRASMIT_ON_i = '0' then  --non devo già essere in trasmissione
                --aspetta che la trasmissione finisca, prenderemo il prossimo
                else
                    if ((TRG0_i = '0' and TriggerSelector='0') or (ichrage_trig = '0' and TriggerSelector='1') or (iTRG_EXT='1' and oTRG_EXT='0')) and (daq_veto='0') then--and ichrage_trig='1' and ochrage_trig = '0'  then                        --il trigger deve essere basso
                        daq_event <= '1';                       --evento
                        CapturedRun <= cRunTimer;
                        --START_CONV <= '1';                      --Genera un impulso di START_CONV abbastanza lungo
                        --start_c_counter <= x"F"; 
                        initCounter <= 16;   
                        DAQSM <= x"F";
                        skip <= '0';  
                        timeoutWAITRASMITON <= 4000;   
                        inTrasmission <= '0';          
                        hold_external_hold <= '1';           
                    end if;
                end if; 
            when x"F" =>
               if initCounter = 0 then                        --il trigger deve essere basso
                   START_CONV <= '1';                      --Genera un impulso di START_CONV abbastanza lungo
                   start_c_counter <= x"0F";    
                   DAQSM <= x"1";
                   T0counter_sync <= cT0counter;            --cattura il T0
               else
                   initCounter <= initCounter -1;             
               end if;
            
            when x"1" =>
                if TRASMIT_ON_i = '0' then
                    if skip = '1' then
                         bit_counter <= bit_counter +1;
                         skip <= '0';
                         
                         store_redoutregister(0)  <= idata;
                         for I in 1 to 29 loop
                            store_redoutregister(I) <= store_redoutregister(I-1);
                         end loop; 
                         
                         if storeBitCounter = 29 then
                         
                            iDataWord(( (WordCounter+1)*32-1) downto WordCounter*32) <="00" & store_redoutregister(28 downto 0) & idata;           --scrivi i dati nel vettore 
                            WordCounter <= WordCounter +1;
                            FIFO_DIN <= "00" & store_redoutregister(28 downto 0) & idata;
                            fifo_we <= storePackage;
                            storeBitCounter <= 0;
                         else
                            storeBitCounter <= storeBitCounter + 1;
                         end if;                 
                    else
                     skip <= '1';
                    end if;   
                else
                    skip <= '0';            --senza inversione còpcl era 0
                    storePackage <= '0';
                    --D_redoutregistershadow <= ;
                end if;
                
                if TRASMIT_ON_i = '0' and TRASMIT_ON_o = '1' then           --avvio trasmissione
                    hold_external_hold <= '0';
                    inTrasmission <= '1';
                    bit_counter <= (others => '0');
                    
                    iDataWordT0 <= "00" & T0counter_sync;                   --salva il T0   
                    WordCounter <= 0;                                       --resetta il word counter
                    
                    if fifo_full = '0' then
                        FIFO_DIN <= "10" & T0counter_sync;
                        fifo_we <= '1';
                        storeBitCounter <= 0;
                        storePackage <= '1';
                    end if;
                end if;
        
                if TRASMIT_ON_i = '1' and TRASMIT_ON_o = '0' then           --fine trasmissione
                
                    ValidWord <= '1';
                    DataWord <= iDataWord;                                  --aggiorna vettore uscita e segnala il valido
                    DataWordT0 <= iDataWordT0; 
                    DataWordRun <= CapturedRun;                    
                    FIFO_DIN <= x"C0000000";
                    daq_stroed_event <= storePackage;
                    fifo_we <= storePackage;    
                    start_c_raz <= x"0F";
                    DAQSM <= x"2";
                    end_counter <= 127;
                end if;
                
                if inTrasmission = '0' then
                    if timeoutWAITRASMITON = 0 then
                        DAQSM <= x"0";
                    else
                        timeoutWAITRASMITON <= timeoutWAITRASMITON -1;
                    end if;
                end if;
            when x"2" =>
                --if end_counter = 0 then
                --    DAQSM <= x"0";
                --else
                --    end_counter <= end_counter -1;
                --end if;
                if TRG0_i = '1' then
                    DAQSM <= x"0";
                end if;    
            when others => 
                DAQSM <= x"0"; 
        end case;
        
        if ResetValidWord = '1' then                                            --resetta valido sul vettore uscita
            ValidWord <= '0';
        end if;
                    
--        if daq_veto ='0' or TRASMIT_ON_o = '0' then
            
            
--            if TRASMIT_ON_i = '0' then
--                if skip = '1' then
                      
--                     bit_counter <= bit_counter +1;
--                     skip <= '0';
                     
                     
--                     store_redoutregister(0)  <= idata;
--                     for I in 1 to 29 loop
--                        store_redoutregister(I) <= store_redoutregister(I-1);
--                     end loop; 
                     
--                     if storeBitCounter = 29 then
--                        FIFO_DIN <= "00" & store_redoutregister(28 downto 0) & idata;
--                        fifo_we <= storePackage;
--                        storeBitCounter <= 0;
--                     else
--                        storeBitCounter <= storeBitCounter + 1;
--                     end if;                 
                     
--                else
--                 skip <= '1';
--                end if;   
                
    
--            else
--                skip <= '0';
--                storePackage <= '0';
--                --D_redoutregistershadow <= ;
--            end if;
            
--            if TRASMIT_ON_i = '0' and TRASMIT_ON_o = '1' then  
--                bit_counter <= (others => '0');
--                if fifo_full = '0' then
--                    FIFO_DIN <= "10" & T0counter_sync;
--                    fifo_we <= '1';
--                    storeBitCounter <= 0;
--                    storePackage <= '1';
--                end if;
--            end if;
    
--            if TRASMIT_ON_i = '1' and TRASMIT_ON_o = '0' then  
--                FIFO_DIN <= x"C0000000";
--                daq_stroed_event <= storePackage;
--                fifo_we <= storePackage;    
--                raz_chn <= '0';
--                start_c_raz <= x"F";
--            end if;
            
--            if raz_chn_f = '0' then
--                raz_chn <= '0';
--                start_c_raz <= x"F";        
--            end if;
    
          
--            if start_c_counter = x"0" then
--                START_CONV <= '0';
--            else
--                start_c_counter <= start_c_counter -1;
--            end if;
            

--            if TRG0_i = '0' and TRG0_o = '1' then
--                daq_event <= '1';
--                T0counter_sync <= T0counter;
--                if delay_trigger = x"0000" then
--                    START_CONV <= '1';
--                    start_c_counter <= x"F";    
--                else
--                    delay_counter <= delay_trigger;
--                    run_trig_delay <= '1';
--                end if;
--            end if;
            
--            if run_trig_delay = '1' then
--                if delay_counter = x"0000" then
--                    run_trig_delay <= '0';
--                    START_CONV <= '1';
--                    start_c_counter <= x"F";              
--                else
--                    delay_counter <= delay_counter -1;
--                end if;
--            end if;
--        else
--            if TRG0_i = '0' and TRG0_o = '1' then
--                raz_chn <= '0';
--                start_c_raz <= x"F";                
--            end if;
--        end if;
        
      
    end if;
   end process;


end Behavioral;

