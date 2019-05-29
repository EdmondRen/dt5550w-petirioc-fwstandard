----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.03.2018 16:14:56
-- Design Name: 
-- Module Name: PetirocAsicOscilloscope - Behavioral
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


Library xpm;
use xpm.vcomponents.all;
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
--library UNISIM;
--use UNISIM.VComponents.all;

entity PetirocAsicOscilloscope is
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
end PetirocAsicOscilloscope;

architecture Behavioral of PetirocAsicOscilloscope is
    signal OSCWORD : std_logic_vector (511 downto 0);
    signal OSCWORD1 : std_logic_vector (511 downto 0);
    signal OSCWORD2 : std_logic_vector (511 downto 0);
    signal OSCWORD3 : std_logic_vector (511 downto 0);
    signal OSCWORD4 : std_logic_vector (511 downto 0);
    signal memwe : std_logic :='0';
    signal mem_address : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
    signal oscilloscope_trigger : std_logic;
    COMPONENT petiosc_mem IS
      PORT (
        clka : IN STD_LOGIC;
        ena : IN STD_LOGIC;
        wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
        addra : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
        dina : IN STD_LOGIC_VECTOR(511 DOWNTO 0);
        clkb : IN STD_LOGIC;
        enb : IN STD_LOGIC;
        addrb : IN STD_LOGIC_VECTOR(14 DOWNTO 0);
        doutb : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
      );
    END COMPONENT;
    
    signal trigger_mode : std_logic_vector(3 downto 0) := x"0";
    signal osc_sm : std_logic_vector(3 downto 0) := x"0";
    signal osc_armed : std_logic := '1';
    signal osc_avail : std_logic := '0';
    signal osc_trigger : std_logic := '0';
    signal iosc_trigger : std_logic := '0';
    signal oosc_trigger : std_logic := '0';
    signal arm : std_logic := '0';
    signal iarm : std_logic := '0';
    signal oarm : std_logic := '0';
    signal arm_pulse : std_logic := '0';
    
    signal trigger_mode_reg :  std_logic_vector(3 downto 0) := x"0";
    signal osc_avail_reg :  std_logic_vector(0 downto 0) := "0";
    signal arm_reg :  std_logic_vector(0 downto 0) := "0";
    signal read_data :  std_logic_vector(31 downto 0) := x"00000000";
    signal counters :  std_logic_vector(31 downto 0) := x"00000000";
    signal divdue : std_logic := '0';
begin
    
    
  CDC_trigger_mode_reg: xpm_cdc_array_single
  generic map (

    -- Common module generics
    DEST_SYNC_FF   => 4, -- integer; range: 2-10
    INIT_SYNC_FF   => 0, -- integer; 0=disable simulation init values, 1=enable simulation init values
    SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
    SRC_INPUT_REG  => 1, -- integer; 0=do not register input, 1=register input
    WIDTH          => 4  -- integer; range: 1-1024

  )
  port map (

    src_clk  => bus_clk,  -- optional; required when SRC_INPUT_REG = 1
    src_in   => trigger_mode_reg,
    dest_clk => sample_clk,
    dest_out => trigger_mode
  );
  
  CDC_osc_avail_reg: xpm_cdc_single
    generic map (
       DEST_SYNC_FF   => 4, -- integer; range: 2-10
       INIT_SYNC_FF   => 0, -- integer; 0=disable simulation init values, 1=enable simulation init values
       SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
       SRC_INPUT_REG  => 1  -- integer; 0=do not register input, 1=register input
    )
    port map (
       src_clk  => sample_clk,  -- optional; required when SRC_INPUT_REG = 1
       src_in   => osc_avail,
       dest_clk => bus_clk,
       dest_out => osc_avail_reg(0)
    );
    
  CDC_arm: xpm_cdc_single
      generic map (
         DEST_SYNC_FF   => 4, -- integer; range: 2-10
         INIT_SYNC_FF   => 0, -- integer; 0=disable simulation init values, 1=enable simulation init values
         SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
         SRC_INPUT_REG  => 1  -- integer; 0=do not register input, 1=register input
      )
      port map (
         src_clk  => bus_clk,  -- optional; required when SRC_INPUT_REG = 1
         src_in   => arm_reg(0),
         dest_clk => sample_clk,
         dest_out => arm
      );
          
    osc_trigger <=  (not trigger_a) or (not trigger_b) or (not trigger_c) or (not trigger_d)        when trigger_mode = x"0" else
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
    sample_process : process (sample_clk)
    begin
        if rising_edge(sample_clk) then
       -- divdue <= not divdue;
        
      --  if divdue = '1' then
            OSCWORD4 <= OSCWORD3;
            OSCWORD3 <= OSCWORD2;
            OSCWORD2 <= OSCWORD1;
            OSCWORD1 <= OSCWORD;
--            OSCWORD <=  x"00000000" & x"00000000" & x"00000000" & x"00000000" &
--                        x"00000000" & x"00000000" & x"00000000" & x"00000000" &
--                        x"00000000" & x"00000000" & x"00000000" & x"00000000" &
--                        x"00000000" & x"00000000" & x"00000000" &  counters;
            OSCWORD <=  x"00000000" & x"00000000" & x"00000000" & x"00000000" & x"00000000" & x"00000000" &
                        x"00000000" &
                        "000" &  global_trigger &
                        chrage_clk_a & chrage_clk_b & chrage_clk_c & chrage_clk_d &
                        chrage_srin_a & chrage_srin_b & chrage_srin_c & chrage_srin_d &
                        trigb_mux_a & trigb_mux_b & trigb_mux_c & trigb_mux_a &
                        trigger_a & trigger_b & trigger_c & trigger_d &
                        lemo1 & lemo2 & lemo3 & lemo4 &
                        chrage_trig_a & chrage_trig_b & chrage_trig_c & chrage_trig_d &
                        dig_probe_a & dig_probe_b & dig_probe_c & dig_probe_d &
                        trgs_a &
                        trgs_b &
                        trgs_c &
                        trgs_d &
                        an_probe_a & charge_mux_a &
                        an_probe_b & charge_mux_b &
                        an_probe_c & charge_mux_c &
                        an_probe_d & charge_mux_d 
                        ;
         
               iarm <= arm;
               oarm <= iarm;
               if iarm = '1' and oarm = '0' then
                arm_pulse <= '1';
               end if;
               iosc_trigger <= osc_trigger;
               oosc_trigger <= iosc_trigger;
               counters <= counters +1;
               case osc_sm is
                when x"0" =>
                    osc_avail <= '0';
                    memwe <='0';
                    osc_sm <= x"1";
                    counters <= (others => '0');
                    
                when x"1" =>
                    if iosc_trigger = '1' and oosc_trigger = '0' then
                        mem_address <= (others => '0');
                        memwe <='1';
                        osc_sm <= x"2";
                    end if;
                
                when x"2" =>
                    if  mem_address = "111" & x"FF" then
                        memwe <='0';
                        osc_sm <= x"3";
                    else
                        mem_address <= mem_address +1;
                    end if;          
                    
               when x"3" => 
                osc_avail <= '1';
                if arm_pulse = '1' then
                    osc_avail <= '0';
                    osc_sm <= x"0";
                end if;
                    
                    
                when others => 
                    osc_sm <= x"0";
               end case;
           end if;
     --   end if;
    end process;

    BUS_Oscilloscope_0_VLD <= "1";

    BUS_Oscilloscope_0_READ_DATA <= x"0000000" & "000" & osc_avail_reg  when BUS_Oscilloscope_0_ADDRESS = x"FFFF" else
                                    x"0000000" & "000" & arm_reg        when BUS_Oscilloscope_0_ADDRESS = x"FFFE" else
                                    x"0000000" & trigger_mode_reg       when BUS_Oscilloscope_0_ADDRESS = x"FFFD" else
                                    read_data;
                                    
    cfg_x : process (  bus_clk )
    begin
        if rising_edge(bus_clk) then
            if BUS_Oscilloscope_0_W_INT = "1" then
                if BUS_Oscilloscope_0_ADDRESS = x"FFFE" then
                    arm_reg(0) <= BUS_Oscilloscope_0_WRITE_DATA(0);
                end if;
                if BUS_Oscilloscope_0_ADDRESS = x"FFFD" then
                    trigger_mode_reg <= BUS_Oscilloscope_0_WRITE_DATA(3 downto 0);
                end if;
            end if;

        end if;
    end process; 
                                      
PM : petiosc_mem
      PORT MAP(
        clka => sample_clk,
        ena => '1',
        wea(0) => memwe,
        addra => mem_address,
        dina => OSCWORD4,
        clkb =>bus_clk,
        enb => '1',
        addrb => BUS_Oscilloscope_0_ADDRESS(14 downto 0),
        doutb =>read_data
      );
      
      --read_data <= x"0000" & BUS_Oscilloscope_0_ADDRESS; 
    
end Behavioral;


