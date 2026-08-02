library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;


entity Read_BRAM is
    Port ( 
	        Data_Out_T   : out  unsigned (9 downto 0);
           Clock        : in  STD_LOGIC;
			  Reset        : in  STD_LOGIC  := '0'
			  
			  
			  
			  );
end Read_BRAM;

architecture Behavioral of Read_BRAM is

signal  WE_TOP            : std_logic             := '0';
signal  Data_In_TOP       : unsigned (9 downto 0) := (others => '0');
signal  Write_Address_TOP : unsigned (7 downto 0) :=(others => '0');
signal  Read_Address_TOP  : unsigned (7 downto 0) :=(others =>'0');
signal  Data_out_TOP      : unsigned (9 downto 0) := (others => '0');
signal  Counter           : unsigned (7 downto 0) :=(others =>'0');  
begin

Inst_Block_RAM_Zemni: entity work.Block_RAM_Zemni
generic MAP
          (
			 Data_width      => 10 ,
			 Adder_width     => 8
          )
PORT MAP
      (
		Clock          => Clock  ,
		WE             => WE_TOP,
		Data_In        => Data_In_TOP,
		Write_Address  => Write_Address_TOP,
		Read_Address   => Read_Address_TOP,
		Data_out       => Data_out_TOP
	    );
		 
  Data_Out_T   <= Data_out_TOP ;
  
process ( Clock )
begin
if rising_edge ( Clock ) then

		Counter            <= Counter+1;
		Write_Address_TOP  <= Counter ;
		WE_TOP             <=  '1';
		Data_In_TOP        <= resize (Counter ,10);

		Read_Address_TOP   <= Counter ;
		
		
		if(Reset = '1') then
		Counter <= (others   =>  '0');
		end if;
		
end if;
end process ;	
end Behavioral;

