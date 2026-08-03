library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DRAM_Top is
Port ( 
	        CLock             : in  STD_LOGIC;
           WE_Top            : in  STD_LOGIC;
           Data_In_Top       : in  unsigned (9 downto 0);
           Write_Address_Top : in  unsigned (6 downto 0);
           Read_Address_Top  : in  unsigned (6 downto 0);
           Data_out_TOP      : out unsigned (9 downto 0)
			  );
end DRAM_Top;

architecture Behavioral of DRAM_Top is

begin

Inst_Destributed_RAM: entity work.Destributed_RAM
generic Map
           (
			  DATA_width     => 10,
			  ADDER_width    => 7
            )
				 
  PORT MAP
  (
		Clock         => CLock,
		WE            => WE_Top ,
		Data_In       => Data_In_Top,
		Write_Address => Write_Address_Top,
		Read_Address  => Read_Address_Top,
		Data_out      => Data_out_TOP
	);

end Behavioral;
