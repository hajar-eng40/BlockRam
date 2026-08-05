LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
USE ieee.numeric_std.ALL;
 
ENTITY DRAM_Tb_3 IS
END DRAM_Tb_3;
 
ARCHITECTURE behavior OF DRAM_Tb_3 IS 
 
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
	
	type mem_array is array (0 to 63) of unsigned (9 downto 0);
	signal expected : mem_array;

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
 for i in 0 to 63 loop
 expected (i) := to_unsigned (i+100 , 10);
 
 Write_Address_Top  <=   to_unsigned (i , 7);
 Data_In_Top   <=  expected (i);
 wait until rising_edge (CLock );
 end loop;
 
 WE_Top  <= '0';
 for i in 0 to 63 loop
 Read_Address_Top  <=  to_unsigned (i , 7);
 wait for 5 ns;
 
 assert Data_out_TOP = expected (i) 
       report " Error at address " & integer ' image(i) severity error ;
 end loop;
 
 
 wait;
 end process;

END;
