library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
Library UNISIM;
use UNISIM.vcomponents.all;



entity CLK_ODDR is
    Port ( 
	        Clk_IN_TOP       : in   STD_LOGIC;
	        data1            : in   STD_LOGIC;
           data2             : in   STD_LOGIC;
			  Clk_En         : in   STD_LOGIC;
			  Data_Reset     : in   STD_LOGIC;
           Data_SET          : in   STD_LOGIC;
           data_out          : out  STD_LOGIC			  
			  );
end CLK_ODDR;

architecture Behavioral of CLK_ODDR is
signal  Clk_sig           : std_logic;
signal  Clk0_sig          : std_logic;
signal  Clk180_sig        : std_logic;
signal  Clk0_bufg_sig     : std_logic;
signal  Clk180_bufg_sig   : std_logic;
signal  data_out_OODR     : std_logic;

begin 
 ----------------------------- IBUFG ----	
IBUFG_inst : IBUFG
   generic map (
      IBUF_LOW_PWR => TRUE, -- Low power (TRUE) vs. performance (FALSE) setting for referenced I/O standards
      IOSTANDARD => "DEFAULT")
   port map (
      O     =>    Clk_sig , -- Clock buffer output
      I     =>    Clk_IN_TOP  -- Clock buffer input (connect directly to top-level port)
   );
 ----------------------------- DCM primitive ----	
DCM_SP_inst : DCM_SP
   generic map (
      CLKDV_DIVIDE => 2.0,                   -- CLKDV divide value
      CLKFX_DIVIDE => 1,                     -- Divide value on CLKFX outputs - D - (1-32)
      CLKFX_MULTIPLY => 4,                   -- Multiply value on CLKFX outputs - M - (2-32)
      CLKIN_DIVIDE_BY_2 => FALSE,            -- CLKIN divide by two (TRUE/FALSE)
      CLKIN_PERIOD => 20.0,                  -- Input clock period specified in nS
      CLKOUT_PHASE_SHIFT => "NONE",          -- Output phase shift (NONE, FIXED, VARIABLE)
      CLK_FEEDBACK => "1X",                  -- Feedback source (NONE, 1X, 2X)
      DESKEW_ADJUST => "SYSTEM_SYNCHRONOUS", -- SYSTEM_SYNCHRNOUS or SOURCE_SYNCHRONOUS
      DFS_FREQUENCY_MODE => "LOW",           -- Unsupported - Do not change value
      DLL_FREQUENCY_MODE => "LOW",           -- Unsupported - Do not change value
      DSS_MODE => "NONE",                    -- Unsupported - Do not change value
      DUTY_CYCLE_CORRECTION => TRUE,         -- Unsupported - Do not change value
      FACTORY_JF => X"c080",                 -- Unsupported - Do not change value
      PHASE_SHIFT => 0,                      -- Amount of fixed phase shift (-255 to 255)
      STARTUP_WAIT => FALSE                  -- Delay config DONE until DCM_SP LOCKED (TRUE/FALSE)
   )
   port map (
      CLK0     => Clk0_sig,                 -- 1-bit output: 0 degree clock output
      CLK180   => Clk180_sig,               -- 1-bit output: 180 degree clock output 
      CLKIN    => Clk_sig ,                  -- 1-bit input: Clock input
      CLKFB    => Clk0_bufg_sig,            -- 1-bit input: Clock feedback input
      RST      => '0'                       -- 1-bit input: Active high reset input
		
   );
	---------------------BUFG for CLK0------------	
BUFG_inst1 : BUFG
   port map (
      O => Clk0_bufg_sig, -- 1-bit output: Clock buffer output
      I => Clk0_sig  -- 1-bit input: Clock buffer input
   );
---------------------BUFG for CLK180------------
BUFG_inst2 : BUFG
   port map (
      O => Clk180_bufg_sig, -- 1-bit output: Clock buffer output
      I => Clk180_sig  -- 1-bit input: Clock buffer input
   );	
  -------------------------------- primitive ODDR2 -------------
  
ODDR2_inst : ODDR2
   generic map(
      DDR_ALIGNMENT => "NONE", -- Sets output alignment to "NONE", "C0", "C1" 
      INIT => '0', -- Sets initial state of the Q output to '0' or '1'
      SRTYPE => "SYNC") -- Specifies "SYNC" or "ASYNC" set/reset
   port map (
      Q    =>  data_out_OODR,        -- 1-bit output data
      C0   =>  Clk0_bufg_sig,   -- 1-bit clock input
      C1   =>  Clk180_bufg_sig, -- 1-bit clock input
      CE   =>  Clk_En,          -- 1-bit clock enable input
      D0   =>  data1,           -- 1-bit data input (associated with C0)
      D1   =>  data2,           -- 1-bit data input (associated with C1)
      R    =>  Data_Reset ,     -- 1-bit reset input
      S    =>  Data_SET         -- 1-bit set input
   );
 -------------------------------- primitive obuf -------------	
OBUF_inst : OBUF
   generic map (
      DRIVE => 12,
      IOSTANDARD => "DEFAULT",
      SLEW => "SLOW")
   port map (
      O => data_out,     -- Buffer output (connect directly to top-level port)
      I => data_out_OODR      -- Buffer input 
   );
	
end Behavioral;

