

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.

Library UNISIM;
use UNISIM.vcomponents.all;
entity ft600_fifo245_core is
    Port ( reset : in  STD_LOGIC;
			  
			  -- LATO PC
			  
			  FTDI_ADBUS : inout STD_LOGIC_VECTOR (31 downto 0);
			  FTDI_RXFN : in STD_LOGIC;									--EMPTY
			  FTDI_TXEN : in STD_LOGIC; 									--FULL
			  FTDI_RDN	: out STD_LOGIC;									--READ ENABLE
			  FTDI_TXN	: out STD_LOGIC;									--WRITE ENABLE
			  FTDI_CLK	: in STD_LOGIC;									--FTDI CLOCK
			  FTDI_OEN	: out STD_LOGIC;									--OUTPUT ENABLE NEGATO LATO FTDI
			  FTDI_SIWU : out STD_LOGIC;									--COMMIT A PACKET IMMEDIATLY
			  FTDI_BE   : inout STD_LOGIC_VECTOR(3 downto 0);			--BYTE ENABLE
			  
			  -- LATO FPGA
			  
			  int_rd 	: out STD_LOGIC;
			  int_wr 	: out STD_LOGIC;
			  data_rd 	: in STD_LOGIC_VECTOR(31 downto 0);
			  data_wr 	: out STD_LOGIC_VECTOR(31 downto 0);
			  addr 		: out STD_LOGIC_VECTOR(31 downto 0);
			  req_read_data : OUT STD_LOGIC;
			  fifo_reset : OUT STD_LOGIC;
			  send_shit : OUT STD_LOGIC;
			  input_fifo_empty : IN STD_LOGIC;
			  input_fifo_valid : IN STD_LOGIC;
			  fifo_address_full : IN STD_LOGIC
			  );
end ft600_fifo245_core;

	

architecture Behavioral of ft600_fifo245_core is
	signal FTDI_ADBUS_IN : std_logic_vector (31 downto 0) := (others =>'0');

		
	type sd is (idle,      --0
	K1,                    --1
	K2,                    --2
	K3,                    --3
	addressing,            --4
	payload,               --5
	writedata,             --6
	prepare_read,          --7
	read2,                 --8
	read_dummy,            --9
	
	read_idle,             --A
	readdata,              --B
	readdata_fifo_empty,   --C
	txen_rollout1,         --D
	txen_rollout2,         --E
	txen_rollout3,         --F
	--readdatadummy,
	send_footer,           --10
	send_footer1,          --11
	send_footer2,          --12
	send_footer3,          --13
	check_payload_residual);

	signal state_interface : sd := idle;
	signal old_state_interface : sd := idle;
	

	signal int_addr :STD_LOGIC_VECTOR  (31 downto 0);

	signal int_FTDI_DIN : STD_LOGIC_VECTOR (31 downto 0);
	signal int_FTDI_DOUT : STD_LOGIC_VECTOR (31 downto 0);
	signal int_FTDI_RXFN : STD_LOGIC;	
	signal int_FTDI_TXEN : STD_LOGIC;	

	signal paylan : STD_LOGIC_VECTOR  (31 downto 0);
	signal burst_paylan : STD_LOGIC_VECTOR  (31 downto 0);
	signal direction : STD_LOGIC := '0';
	signal output_fifo_full : STD_LOGIC := '0';
	signal address_fifo_full: STD_LOGIC := '0';
	signal oinput_fifo_empty : std_logic := '0';
	--signal input_fifo_empty: STD_LOGIC := '0';

	--signal req_read_data : STD_LOGIC := '0';
	signal T : std_logic := '0';

	signal push_address_in_fifo_for_burst : STD_LOGIC := '0';	
	signal data_valid : STD_LOGIC;	
	SIGNAL WATCHDOG_COUNTER : STD_LOGIC_VECTOR (25 DOWNTO 0) := (OTHERS => '0');
	signal state : std_logic_vector (2 downto 0 ) := "000";
	
	signal cntr : std_logic_vector ( 31 downto 0) := (others => '0');
	signal counter : integer :=0;
	
	signal timeout_counter : std_logic_vector(47 downto 0);
	--signal send_shit : std_logic := '0';
	signal roll_exit : std_logic := '0';
	signal roll_exit2 : std_logic := '0';
	
	signal good_counter : std_logic_vector (31 downto 0);
	
	
	signal T_timeout_counter : std_logic_vector (31 downto 0);
	
	signal streaming_mode : std_logic :='0';

    SIGNAL use_alter_data : std_logic_vector := "00";
    signal alter_data : std_logic_vector (31 downto 0); 
    
    signal iFTDI_TXN : std_logic := '0';

    signal RETRASMIT_LAST : std_logic := '0';
    signal LASTWORD : STD_LOGIC_VECTOR  (31 downto 0); 
	
	attribute keep : string; 
	attribute keep of int_FTDI_DIN: signal is "true"; 
	attribute keep of int_FTDI_DOUT: signal is "true"; 
	attribute keep of int_FTDI_RXFN: signal is "true"; 
	attribute keep of int_FTDI_TXEN: signal is "true"; 
	attribute keep of data_valid: signal is "true"; 

	attribute keep of req_read_data: signal is "true"; 
	attribute keep of T : signal is "true"; 

	attribute keep of state_interface: signal is "true"; 
	attribute keep of int_addr: signal is "true"; 
	attribute keep of paylan: signal is "true"; 
	attribute keep of direction: signal is "true";
	attribute keep of burst_paylan: signal is "true"; 
	
	signal lastdvcount : integer;
	
	signal VetoTX : std_logic := '1';
	signal VetoMachine : std_logic;
	signal iTXEN : std_logic := '0';
	signal ioTXEN : std_logic := '0';
	
	
	signal iSend_Shit : stD_logic := '0';
	
	signal WD_Counter : integer := 0;
	signal int_reset : std_logic := '0';
begin
    send_shit <= iSend_Shit;
    int_FTDI_DOUT <= data_rd when use_alter_data = "00" else alter_data;
    FTDI_TXN <=     input_fifo_valid  and VetoTX  when use_alter_data = "00" else 
                    FTDI_TXEN  when use_alter_data = "11" else 
                    iFTDI_TXN;
    req_read_data <= (not FTDI_TXEN)  when use_alter_data = "00" else '0';
    
    ppp : process
    begin
        if rising_edge(FTDI_CLK) then

            if VetoTX = '1' and FTDI_TXEN = '1' and input_fifo_valid='0' then                
                VetoTX <= '0';
            end if;

            if VetoTX = '0' and FTDI_TXEN = '0' then
                VetoTX <= '1';
            end if;
            
            
        end if;
    end process;
    
    wdprocess:process
    begin
        if rising_edge(FTDI_CLK) then
        int_reset <= '0';
            if state_interface = idle or state_interface = writedata or state_interface= readdata then
                WD_Counter <= 100000000;
                
            else
                if WD_Counter = 0 then
                    int_reset <= '1';
                    WD_Counter <= 100000000;
                else
                    WD_Counter <= WD_Counter-1;
                end if;
            end if;
        end if;
    end process;     
    
   GBUF: for I in 0 to 31 generate
	begin
		DRIVE_IO_BUS : IOBUF
		generic map (
			DRIVE => 12,
			IOSTANDARD => "DEFAULT",
			SLEW => "FAST")
		port map (
			O => FTDI_ADBUS_in(I),     -- Buffer output
			IO => FTDI_ADBUS(I),   		-- Buffer inout port (connect directly to top-level port)
			I => int_FTDI_DOUT(I),     -- Buffer input
			T => T      					-- 3-state enable input, high=input, low=output 
		);

   end generate;
	
	    
   GBUFBE: for I in 0 to 3 generate
	begin
		DRIVE_IO_BUS : IOBUF
		generic map (
			DRIVE => 12,
			IOSTANDARD => "DEFAULT",
			SLEW => "FAST")
		port map (
			O => open,     -- Buffer output
			IO => FTDI_BE(I),   		-- Buffer inout port (connect directly to top-level port)
			I => '1',     -- Buffer input
			T => T      					-- 3-state enable input, high=input, low=output 
		);

   end generate;
	
	decoding : process (FTDI_CLK)
	begin
		if reset = '1' or int_reset = '1'  then
			state <= "000";
		elsif rising_edge(FTDI_CLK) then
			
			
			int_FTDI_DIN(7 downto 0) <= FTDI_ADBUS_in(31 downto 24);
			int_FTDI_DIN(15 downto 8) <= FTDI_ADBUS_in(23 downto 16);
			int_FTDI_DIN(23 downto 16) <= FTDI_ADBUS_in(15 downto 8);
			int_FTDI_DIN(31 downto 24) <= FTDI_ADBUS_in(7 downto 0);
			int_FTDI_RXFN <= FTDI_RXFN;
			int_FTDI_TXEN <= FTDI_TXEN;	
			--data_valid <= not FTDI_RXFN;
			case state is
				when "000" =>
					data_valid <= '0';
					FTDI_OEN <= '1';
					FTDI_RDN <= '1';
					if int_FTDI_RXFN = '0' then
						state <= "001";
						
					end if;
				when "001" =>
					state <= "011";
					FTDI_OEN <= '0';
				when "011" =>
					state <= "100";
					FTDI_RDN <= '0';
					
				when "100" =>
					
					data_valid <= '1';
					if FTDI_RXFN = '1' then
						data_valid <= '0';
						FTDI_RDN <= '1';
						state <= "000";

					end if;
					when others =>
			end case;
		end if;
	
	end process;
	
	
	sm_proc : process(FTDI_CLK)
	begin
		if rising_edge(FTDI_CLK) then
			if reset = '1' or int_reset = '1' then
				state_interface <= idle;
				old_state_interface <= idle;
				WATCHDOG_COUNTER <= (OTHERS => '0');	
			else
			    oinput_fifo_empty <= input_fifo_empty; 
				int_rd <= '0';
				int_wr <= '0';
				--req_read_data <= '0';
				fifo_reset <= '0';
				

--				IF (int_FTDI_RXFN = '1') and (old_state_interface = state_interface) THEN
--					
--					IF WATCHDOG_COUNTER=X"FFFFFF" & "11" THEN
--						state_interface <= IDLE;
--						WATCHDOG_COUNTER <= (OTHERS => '0');
--					ELSE
--						WATCHDOG_COUNTER <= WATCHDOG_COUNTER +1;
--					END IF;
--					
--					
--					
--				ELSE
--					WATCHDOG_COUNTER <= (OTHERS => '0');
--				END IF;
				iFTDI_TXN	<= '1';	
				FTDI_SIWU <= '1';
				use_alter_data <= "01";
				old_state_interface <= state_interface;
					
					case state_interface is
				
						when idle =>
						  use_alter_data <= "11";
						--	FTDI_OEN <= '0';
							T <= '1';
							push_address_in_fifo_for_burst <= '0';
							iSend_Shit <= '0';
							good_counter <= x"00000000";
							--data_rd <= x"00000000";
							if data_valid = '1' then
								if int_FTDI_DIN(31 downto 2) = x"FF00AB" & "111100"  then
									state_interface <= K1;
									fifo_reset <= '1';
									direction <= int_FTDI_DIN(0);
									streaming_mode <= int_FTDI_DIN(1);
									cntr<=(others => '0');
								else
									state_interface <= idle;
								end if;
							end if;	
							
						WHEN K1 =>
							if data_valid = '1' then
								if int_FTDI_DIN = x"CDABCDAB"  then
									state_interface <= k2;
								ELSE
									state_interface <= idle;
								END IF;
							END IF;

						WHEN K2 =>
							if data_valid = '1' then
								if int_FTDI_DIN = x"F1CA600D"  then
									state_interface <= k3;
								ELSE
									state_interface <= idle;
								END IF;
							END IF;

						WHEN K3 =>
							if data_valid = '1' then
							     T_timeout_counter <= int_FTDI_DIN;
							     state_interface <= addressing;
--								if int_FTDI_DIN = x"5A5AA5A5"  then
--									state_interface <= addressing;
--								ELSE
--									state_interface <= idle;
--								END IF;
							END IF;

							
						when addressing =>
							if data_valid = '1' then
									addr <= int_FTDI_DIN;
									int_addr <= int_FTDI_DIN;
									state_interface <= payload;
							end if;
							
						when payload => 
							if data_valid = '1' then
									paylan <=  int_FTDI_DIN;	
									if direction = '0' then
										state_interface <= writedata;							
									else
										state_interface <= prepare_read;
									end if;
							end if;
							
				
						when writedata =>
							if data_valid = '1' then
								DATA_WR <= int_FTDI_DIN(7 downto 0) & int_FTDI_DIN(15 downto 8) & int_FTDI_DIN(23 downto 16) & int_FTDI_DIN(31 downto 24); 
								int_wr <= '1';
								addr <= int_addr;
								paylan <= paylan -1;
								if paylan=x"00000001" then
									state_interface <= idle;
								else			
								    if streaming_mode='0' then
									   int_addr <= int_addr +1;
									end if;
									state_interface <= writedata;
								end if;							
							end if;						
							
							
							--NON IMPELMENTED
						when prepare_read =>
							--FTDI_OEN <= '1';
							
							burst_paylan <= paylan +1;
							push_address_in_fifo_for_burst <= '1';
							timeout_counter <= T_timeout_counter & x"0000";
							iSend_Shit <= '0';
							state_interface <= read_dummy;
							

                        when read_dummy =>
                            
                            RETRASMIT_LAST <= '0';
                            state_interface <= readdata;
                            T <= '0';
                            use_alter_data <= "00";
--                            if input_fifo_empty = '0' then
                           --     req_read_data <= '1';
                        when readdata =>
                            RETRASMIT_LAST <= '1';
                            use_alter_data <= "00";
                            if input_fifo_valid = '0' and iSend_Shit='0' then
                                good_counter <= good_counter +1;
                            end if;
                            if (paylan=x"00000000") then --or ( (iSend_Shit = '1') and (paylan=x"00000001"))  then
                                state_interface <=send_footer ;   
                                FTDI_SIWU <= '0';   
                            else
                                if input_fifo_valid = '0'  then
                                    paylan <= paylan -1;
                                end if;                                      
                            end if;
                            
                            
                            if timeout_counter = x"000000000000" then
                               
                                iSend_Shit <= '1';
                            else
                                timeout_counter <= timeout_counter -1;
                            end if;       
                            
       
--                        when readdata_fifo_empty =>
--                            RETRASMIT_LAST <= '0';
--                            if input_fifo_empty = '0'  then
--                                req_read_data <= '1';
--                                state_interface <=readdata ;   
                       
                                
--                            end if;
--                            if FTDI_TXEN = '1' and RETRASMIT_LAST = '1' then
--                                 state_interface <=txen_rollout1 ;    
--                            end if;
                            
--                        when readdata=>
--                            if FTDI_TXEN = '0' then
--                                iFTDI_TXN <= '0';
--                                int_FTDI_DOUT <= data_rd;
--                                RETRASMIT_LAST <= '1';
--                                good_counter <= good_counter +1;
--                                if paylan=x"00000000" then
--                                      state_interface <=send_footer ;   
--                                      FTDI_SIWU <= '0';
--                                else
--                                    paylan <= paylan -1;  
--                                    state_interface <=readdata_fifo_empty ;                                                       
--                                end if;
                                                                
--                            end if;
--                        when txen_rollout1 => 
--                            if FTDI_TXEN = '1' then
--                                    iFTDI_TXN <= '0';
--                                    state_interface <=readdata ; 
--                                    RETRASMIT_LAST <= '0';
--                            end if;

                            
--                        when readdata =>
--                            T <= '0';
--                            req_read_data <= '1';
--							if send_shit = '1' then

--							else
--							 if input_fifo_valid = '0' then
--							    if FTDI_TXEN = '0' then
--                                   iFTDI_TXN <= '0';
--                                   int_FTDI_DOUT <= data_rd;
--                                   LASTWORD <=  data_rd;
--                                   RETRASMIT_LAST <= '1';
--                                   good_counter <= good_counter +1;
--                                   req_read_data <= '1';
--                                   if paylan=x"00000000" then
--                                        state_interface <=send_footer ;   
--                                        FTDI_SIWU <= '0';
--                                   else
--                                        paylan <= paylan -1;                            
--                                   end if; 
--                                else
--                                    state_interface <= txen_rollout1;
--                                    req_read_data <= '0';
--                                end if;							
--							 else
--							     RETRASMIT_LAST <= '0';
--							     --state_interface <= readdata_fifo_empty;
--							 end if;
--							end if;
					   
					   
--					   when readdata_fifo_empty =>
--					       if input_fifo_empty = '0' and FTDI_TXEN='0' then
--					           state_interface <= read_dummy;
--					       end if;
					   
							
--					   when txen_rollout1 => 
--                            if FTDI_TXEN = '0' then
--                                state_interface <= txen_rollout2;
--                            else
--                                state_interface <= txen_rollout1;
--                            end if;
                            
--                        when txen_rollout2 =>
--                            if FTDI_TXEN = '0' then
    
--                                state_interface <= txen_rollout3;
--                            else
--                                state_interface <= txen_rollout1;
--                            end if;
                            
--                        when txen_rollout3 =>
--                            if FTDI_TXEN = '0' then
--                                if RETRASMIT_LAST = '1' then
--                                    T <= '0';
--                                    iFTDI_TXN <= '0';
--                                    int_FTDI_DOUT <= LASTWORD;                        
--                                end if;
--                                state_interface <= readdata;
                                
--                            else
--                                state_interface <= txen_rollout1;
--                            end if;							
							
--						when read_dummy =>
--							T <= '0';
--							roll_exit <= '0';
--							roll_exit2 <= '0';
--                            if FTDI_TXEN = '0' then
--                                if  input_fifo_empty = '0' or send_shit = '1' then                                 --INIZIARE QUI CON IL TIMEOUT
--                                    state_interface <= readdata;
--                                    req_read_data <= '1';
--                                else
--                                     if timeout_counter = 0 then
--                                      send_shit <= '1';
--                                      push_address_in_fifo_for_burst <='0';
--                                      fifo_reset <= '1';
--                                    else
--                                      timeout_counter <= timeout_counter -1;
--                                    end if;                                 
--                                end if;
--                            end if;
							
--						when readdata =>
--						  use_alter_data <= '0';
--						--	if input_fifo_empty = '0' then --or ((lastdvcount < 8192) and (lastdvcount > 0))
--						-- gestione timeout
--                        if timeout_counter = 0 then
--                             send_shit <= '1';
--                             push_address_in_fifo_for_burst <='0';
--                             fifo_reset <= '1';
--                         else
--                             timeout_counter <= timeout_counter -1;
--                         end if;
                         						
--                            FTDI_TXN <= '1';
                         
--                            if FTDI_TXEN = '0' then
                                
--                                if send_shit='1' then
--                                    FTDI_TXN <= '0';
--                                    --int_FTDI_DOUT <= x"ABBA5AA5";   
--                                    paylan <= paylan -1;
--                                    if paylan=x"00000002" then
--                                        state_interface <=send_footer ;                               
--                                    end if; 
                                                            
--                                else
--                                       req_read_data <= '1';
--                                       FTDI_TXN <= '0';
--                                       if input_fifo_empty = '1' then 
--                                        FTDI_TXN <= '1';
--                                        state_interface <= read2;
--                                        counter <= 32; 
--                                        roll_exit2 <= '1';
--                                       else
--                                        good_counter <= good_counter + 1;
--                                        paylan <= paylan -1;
                                       
--                                       end if;
                               
--                                 if paylan=x"00000001" then
--                                     state_interface <=send_footer ;                               
--                                 end if; 

--                                end if;
                             
                             
                            
--                            else
--                              --  if roll_exit= '0' then
--                                    alter_data <= data_rd;
--                              --  end if;
                                
--                                if paylan=x"00000001" then
--                                    state_interface <=send_footer ;
--                                else
--                                    state_interface <= read2;
--                                    counter <= 32;
--                                end if;
   
--                            end if; 
                
						
--						when read2 =>
						
--						 -- use_alter_data <= '1';
--						 use_alter_data <= not roll_exit2;
						
--						-- gestione timeout
--                        if timeout_counter = 0 then
--                             send_shit <= '1';
--                             push_address_in_fifo_for_burst <='0';
--                             fifo_reset <= '1';
--                         else
--                             timeout_counter <= timeout_counter -1;
--                         end if;


						
--						    roll_exit <= '0';

--                            FTDI_TXN <= '1';
--                            if send_shit = '0' then
--                                if counter = 0 then
--                                    if FTDI_TXEN = '0' then
--                                       if input_fifo_empty = '0' then
                                             
--                                             if roll_exit2 = '1' then
--                                                req_read_data <= '1';
--                                                roll_exit2 <= '0';
--                                             else
--                                                FTDI_TXN <= '0';
--                                             end if;
--                                             state_interface <= readdata;
                                                                                          
--                                        end if;
--                                    end if;
--                                else
--                                    counter <= counter -1;
--                                end if;	
                                
--                            else
--                                if counter = 0 then
--                                    if FTDI_TXEN = '0' then
--                                        FTDI_TXN <= '0';
--                                        state_interface <= readdata;
--                                    end if;
--                                else
--                                    counter <= counter -1;
--                                end if;    
                            
--                            end if;						
	
						
						when send_footer =>
						    use_alter_data <= "01";

                            
                            if FTDI_TXEN = '0' then
                                iFTDI_TXN <= '0';
                                alter_data<= x"F1CA600D";
                                state_interface <= send_footer2;
                            end if;
                        
                        when send_footer2 =>
                            use_alter_data <= "01";
                            
                            if FTDI_TXEN = '0' then
                              iFTDI_TXN <= '0';
                              alter_data <= good_counter;
                              state_interface <= idle;
                            end if;
--                        when send_footer3=>
                            
--                            if FTDI_TXEN = '0' then
--                                iFTDI_TXN <= '0';  
--                                state_interface <= check_payload_residual;
--                            end if;
                            
						
							
--						when check_payload_residual => 
--                            --iFTDI_TXN <= '0';  
--                            if FTDI_TXEN = '1' then
--                                iFTDI_TXN <= '1';                          
--                                state_interface <= idle;
--                            end if;
							
						when others =>
						
					end case;
					
					
								
				if push_address_in_fifo_for_burst = '1' then
					if fifo_address_full = '0' then
						if burst_paylan = x"00000000" then
						  
						else
							burst_paylan <= burst_paylan - 1;
							if streaming_mode='0' then
							 int_addr <= int_addr +1;
							end if;	
							addr <= int_addr;
							int_rd <= '1';
						end if;
					end if;
				end if;
				
                                            
			end if;
		end if;
	end process;

end Behavioral;

