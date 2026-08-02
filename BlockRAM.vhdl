library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;



entity Block_RAM_Zemni is

generic (
         Data_width   : integer := 15 ;
			Adder_width : integer := 6
         );
    Port (     Clock         : in  STD_LOGIC;
	            WE            : in  STD_LOGIC;
               Data_In       : in  unsigned  (Data_width-1  downto 0);
               Write_Address : in  unsigned  (Adder_width-1  downto 0);
               Read_Address  : in  unsigned  (Adder_width-1  downto 0);
					Data_out      : out unsigned  (Data_width-1  downto 0)
			  );
end Block_RAM_Zemni;

architecture Behavioral of Block_RAM_Zemni is


type Ram_Type is array (0 to 2**Adder_width-1) of unsigned (Data_width-1 downto 0);

signal Ram_Type1 : Ram_Type := (others => (others => '0'));

begin
process ( Clock)
begin
	if rising_edge (Clock) then
			if(WE='1') then
			Ram_Type1( to_integer (Write_Address))<= Data_In;
			end if;
			
			Data_out <= Ram_Type1( to_integer (Read_Address));
	end if;
end process;
end Behavioral;
