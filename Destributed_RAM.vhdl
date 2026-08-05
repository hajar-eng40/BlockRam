library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;



entity Destributed_RAM is

generic (
         DATA_width   : integer := 15 ;
			ADDER_width : integer := 6
         );
    Port (     
	            Clock         : in  STD_LOGIC;
	            WE            : in  STD_LOGIC;
               Data_In        : in  unsigned  (DATA_width-1   downto 0);
               Write_Address  : in  unsigned  (ADDER_width-1 downto 0);
               Read_Address   : in  unsigned  (ADDER_width-1 downto 0);
			   Data_out       : out unsigned  (DATA_width-1   downto 0)
			  );
end Destributed_RAM;

architecture Behavioral of Destributed_RAM is


type Ram_Type is array (0 to 2**ADDER_width-1) of unsigned (DATA_width-1 downto 0);

signal Ram_Type1 : Ram_Type := (others => (others => '0'));

 attribute ram_style              : string;                 ---- config ram : destributed ----
 attribute ram_style of Ram_Type1 :signal is "destributed" ;
 
begin
process ( Clock)
begin
Data_out <= Ram_Type1( to_integer (Read_Address)); ---read Asankron---

	if rising_edge (Clock) then
			if(WE='1') then
			Ram_Type1( to_integer (Write_Address))<= Data_In;
			end if;
								
	end if;
end process;
end Behavioral;
