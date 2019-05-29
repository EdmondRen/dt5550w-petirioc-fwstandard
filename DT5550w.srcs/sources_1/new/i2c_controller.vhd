
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
entity iic_controller is
    Generic (ComponentBaseAddress : std_logic_vector(31 downto 0));
    Port (    
            reset : in  STD_LOGIC;
		    clk : in STD_LOGIC;
		    iic_sda : inout STD_LOGIC;
		    iic_scl : inout STD_LOGIC;
            REG_addr : in STD_LOGIC_VECTOR (31 downto 0);
            REG_din : in STD_LOGIC_VECTOR (31 downto 0);
            REG_out : inout STD_LOGIC_VECTOR (31 downto 0);
            REG_wrint : in STD_LOGIC;
            REG_rdint : in STD_LOGIC;
            REG_rddv : out STD_LOGIC
			  );
end iic_controller;

	

architecture Behavioral of iic_controller is
		
    signal iic_start :  std_logic := '0';
    signal iic_stop :  std_logic:= '0';
    signal iic_iread : std_logic := '0';
    signal iic_iwrite :  std_logic := '0';
    signal iic_ack_in :  std_logic := '0';
    signal iic_Din : std_logic_vector(7 downto 0) := x"00";
    signal iic_cmd_ack :  std_logic := '0';
    signal iic_ack_out :  std_logic := '0';
    signal iic_busy :  std_logic := '0';
    signal iic_reset :  std_logic := '0';
    signal iic_Dout :  std_logic_vector(7 downto 0) := x"00"; 
    signal iic_execute :  std_logic := '0';
    
    signal iic_wreg : std_logic_vector(31 downto 0) := x"00000000";
    signal iic_rreg : std_logic_vector(31 downto 0) := x"00000000";
    
       
    
    
	COMPONENT i2c_master_v01
    PORT(
        sys_clk : IN std_logic;
        sys_rst : IN std_logic;
        start : IN std_logic;
        stop : IN std_logic;
        read : IN std_logic;
        write : IN std_logic;
        send_ack : IN std_logic;
        mstr_din : IN std_logic_vector(7 downto 0);    
        sda : INOUT std_logic;
        scl : INOUT std_logic;      
        free : OUT std_logic;
        rec_ack : OUT std_logic;
        ready : OUT std_logic;
        data_good : OUT std_logic;
        core_state : OUT std_logic_vector(5 downto 0);
        mstr_dout : OUT std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

begin



		
	iic_start_control : process (CLK)
	begin
		if rising_edge(CLK) then
			if iic_execute = '1' then
				iic_iread <= iic_wreg( 10 );
				iic_iwrite <= iic_wreg( 11 );
				iic_start <= iic_wreg( 8 );
				iic_stop <= iic_wreg( 9);
				iic_ack_in <= iic_wreg( 12 );
				iic_reset <= iic_wreg( 15 );
				iic_Din <= iic_wreg( 7 downto 0 );
			else
				
					iic_iwrite <= '0';
					iic_iread <= '0';
					iic_start <= '0';
					iic_stop <= '0';
					--iic_ack_in <= '0';

			end if;
			
								
				if iic_cmd_ack = '1' then
					iic_rreg(7 downto 0) <= iic_Dout;
				end if;
		end if;
	end process;
	
		iic_rreg(8) <= iic_cmd_ack;
		iic_rreg(9) <= iic_ack_out;
		iic_rreg(10) <= iic_busy;
		
		Inst_i2c_master_v01: i2c_master_v01 PORT MAP(
		sys_clk => CLK,
		sys_rst => iic_reset,
		start => iic_start,
		stop => iic_stop,
		read => iic_iread,
		write => iic_iwrite,
		send_ack => iic_ack_in,
		mstr_din => iic_Din,
		sda => iic_sda,
		scl => iic_scl,
		free => open,
		rec_ack => iic_ack_out,
		ready => iic_busy,
		data_good => iic_cmd_ack,
		core_state => open,
		mstr_dout => iic_Dout
	);
	
    bus_control : process (CLK)
    begin
        if rising_edge(CLK) then
            iic_execute <= '0';
            REG_rddv <= '0';
	       if REG_wrint = '1' then
	           if REG_addr = ComponentBaseAddress + x"00000000" then
	               iic_wreg <= REG_din;
	               iic_execute <= '1';
	           end if;
	       end if;
	       
	       if REG_rdint = '1' and REG_addr = ComponentBaseAddress + x"00000001" then
	           REG_out <= iic_rreg;
	           REG_rddv <= '1';
	       else 
	           REG_out <= (others => 'Z');
	       end if;
	    end if;
	end process;

end Behavioral;

