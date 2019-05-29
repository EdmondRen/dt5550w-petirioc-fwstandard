
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
entity PetirocSlowControl is
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
end PetirocSlowControl;


  
	

architecture Behavioral of PetirocSlowControl is
    signal ASIC_BITSTREAM : std_logic_vector (639 downto 0) := "1101101101101010111000101010100100110101100101100110000010010100010010111110001101001001100000100000100000100000100000100000100000100000100000100000100000100000100000100000100000100000100000100000100000100000100000100000100000100000100000100000100000100000100000100000100000100000111111111111111111111111111111110000100011000000011000000011000000011000000011000000011000000011000000011000000011000000011000000011000000011000000011000000011000000011000000011000000011000000011000000011000000011000000011000000011000000011000000011000000011000000011000000011000000001000000011111111111000000011111111101000000011111111111111111111111111111111";--(others => '0');
    signal ASIC_BIT_COUNT : integer := 0;
    signal startProg : std_logic := '0';
    signal startProgMonitor : std_logic := '0';
    signal ostartProg : std_logic := '0';
    signal ProgSM : std_logic_vector (3 downto 0) := X"0";
    signal ProgSMp : std_logic_vector (3 downto 0) := X"0";
    signal TimeCounter : integer;
    
  
begin

    prog_asic : process (clk)
    begin
        if rising_edge(clk) then
            case ProgSM is
                when x"0" =>
                    ASIC_BIT_COUNT <= 0;
                    PETIROC_CLK <= '0';
                    PETIROC_SELECT <='1';                    
                    if startProg = '1' and ostartProg = '0' then
                        ASIC_BIT_COUNT <= 639;
                        ProgSMp <= X"1";
                        ProgSM <= x"F";
                        PETIROC_RESETB <='0';
                        PETIROC_SLOAD <= '0';
                        PETIROC_CLK <= '0';
                        TimeCounter <= 2*Halfbit;
                    end if;

                    if startProgMonitor = '1'  then
                        PETIROC_SELECT <='0';                               --enable probe register
                        ASIC_BIT_COUNT <= 194;
                        ProgSMp <= X"1";
                        ProgSM <= x"F";
                        PETIROC_RESETB <='0';
                        PETIROC_SLOAD <= '0';
                        PETIROC_CLK <= '0';
                        TimeCounter <= 2*Halfbit;
                    end if;

                
                when x"1" =>
                    PETIROC_RESETB <='1';
                    TimeCounter <= 10*Halfbit;
                    ProgSMp <= X"2";
                    ProgSM <= x"F";
                        
                when x"2" =>
                    PETIROC_CLK <= '0';
                    PETIROC_MOSI <= ASIC_BITSTREAM(ASIC_BIT_COUNT);
                    TimeCounter <= Halfbit;
                    ProgSMp <= X"3";
                    ProgSM <= x"F";
                        
                when x"3" =>
                    PETIROC_CLK <= '1';
                    TimeCounter <= Halfbit;
                    ProgSMp <= X"4";
                    ProgSM <= x"F";
                
                when x"4" =>
                    PETIROC_CLK <= '0';
                    ASIC_BIT_COUNT <= ASIC_BIT_COUNT -1;
                    if ASIC_BIT_COUNT = 0 then
                        TimeCounter <= 4*Halfbit;
                        ProgSMp <= X"5";
                        ProgSM <= x"F";                       
                    else
                        ProgSM <= x"2";
                    end if;     
                    
                when x"5" =>
                    PETIROC_SLOAD <= '1';
                    TimeCounter <= 4*Halfbit;
                    ProgSMp <= X"6";
                    ProgSM <= x"F";  
                
                when x"6" =>
                    PETIROC_SLOAD <= '0';
                    TimeCounter <= 4*Halfbit;
                    ProgSMp <= X"0";
                    ProgSM <= x"F";  

                                                                             
                when x"F" =>
                    if TimeCounter = 0 then
                        ProgSM <= ProgSMp;
                    else
                        TimeCounter <= TimeCounter -1;
                    end if;
                    
                when others =>
             end case;
        end if;
    end process;

 bus_control : process (CLK)
    begin
        if rising_edge(CLK) then
           startProg <= '0';
           startProgMonitor <= '0';
           REG_rddv <= '0';
           
	       if REG_wrint = '1' then
              for I in 0 to 19 loop
                 if REG_addr = ComponentBaseAddress + I then
                    ASIC_BITSTREAM((32*(I+1)-1) downto 32*I) <= REG_din;
                 end if;
              end loop;                                     
              
              if REG_addr = ComponentBaseAddress + 20 then
                startProg <= '1';
              end if;                              

              if REG_addr = ComponentBaseAddress + 21 then
                startProgMonitor <= '1';
              end if;                              

	       end if;
	       
	    end if;
	end process;
	

end Behavioral;


