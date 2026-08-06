library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
Library UNISIM;
use UNISIM.vcomponents.all;


entity Temp_BUFG is
    Port ( 
	        CLK_in : in  STD_LOGIC;
           CLK_out : out  STD_LOGIC
			  );
end Temp_BUFG;

architecture Behavioral of Temp_BUFG is

signal Clkout_Int : std_logic ;

begin

IBUFG_inst : IBUFG
   generic map (
      IBUF_LOW_PWR => TRUE, -- Low power (TRUE) vs. performance (FALSE) setting for referenced I/O standards
      IOSTANDARD => "DEFAULT")
   port map (
      O    => Clkout_Int, -- Clock buffer output
      I    => CLK_in      -- Clock buffer input (connect directly to top-level port)
   );
	
BUFG_inst : BUFG
   port map (
      O => CLK_out, -- 1-bit output: Clock buffer output
      I => Clkout_Int -- 1-bit input: Clock buffer input
   );
	

end Behavioral;
