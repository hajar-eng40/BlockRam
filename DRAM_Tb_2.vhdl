LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
USE ieee.numeric_std.ALL;
 
ENTITY DRAM_tb IS
END DRAM_tb;
 
ARCHITECTURE behavior OF DRAM_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DRAM_Top
    PORT(
         CLock : IN  std_logic;
         WE_Top : IN  std_logic;
         Data_In_Top : IN  unsigned(9 downto 0);
         Write_Address_Top : IN  unsigned(6 downto 0);
         Read_Address_Top : IN  unsigned(6 downto 0);
         Data_out_TOP : OUT  unsigned(9 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLock : std_logic := '0';
   signal WE_Top : std_logic := '0';
   signal Data_In_Top : unsigned(9 downto 0) := (others => '0');
   signal Write_Address_Top : unsigned(6 downto 0) := (others => '0');
   signal Read_Address_Top : unsigned(6 downto 0) := (others => '0');

 	--Outputs
   signal Data_out_TOP : unsigned(9 downto 0);

   -- Clock period definitions
   constant CLock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DRAM_Top PORT MAP (
          CLock => CLock,
          WE_Top => WE_Top,
          Data_In_Top => Data_In_Top,
          Write_Address_Top => Write_Address_Top,
          Read_Address_Top => Read_Address_Top,
          Data_out_TOP => Data_out_TOP
        );

   -- Clock process definitions
   CLock_process :process
   begin
		CLock <= '0';
		wait for CLock_period/2;
		CLock <= '1';
		wait for CLock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for CLock_period*10;

      -- insert stimulus here 
     WE_Top  <= '1';
	  Write_Address_Top  <= to_unsigned (0,7);
	  Data_In_Top        <= to_unsigned (5 ,10);
	  wait until rising_edge (CLock );
	  
	  Write_Address_Top  <= to_unsigned (1,7);
	  Data_In_Top        <= to_unsigned (6 ,10);
	  wait until rising_edge (CLock );
	  
	  Write_Address_Top  <= to_unsigned (2,7);
	  Data_In_Top        <= to_unsigned (2 ,10);
	  wait until rising_edge (CLock );
	  Write_Address_Top  <= to_unsigned (3,7);
	  Data_In_Top        <= to_unsigned (1 ,10);
	  wait until rising_edge (CLock );
	
	  WE_Top  <= '0';
	  Read_Address_Top  <= to_unsigned (0,7);
	  wait for 100 ns;
	  Read_Address_Top  <= to_unsigned (1,7);
	  wait for 100 ns;
	  Read_Address_Top  <= to_unsigned (2,7); 
	  wait for 100 ns;
	  Read_Address_Top  <= to_unsigned (3,7); 
      wait;
   end process;

END;
