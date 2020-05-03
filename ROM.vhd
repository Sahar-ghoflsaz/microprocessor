----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:37:12 01/22/2018 
-- Design Name: 
-- Module Name:    ROM - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.all;
use work.MyPackage.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ROM is
    Port (  address : in  STD_LOGIC_VECTOR (2 downto 0);
				clk : in STD_LOGIC;
				data_out : out STD_LOGIC_VECTOR (2*n+1 downto 0));
end ROM;

architecture Behavioral of ROM is
	
	type matrix is array (0 to 7) of std_logic_vector(2*n+1 downto 0);
	Constant dataROM : matrix := ("00" & x"FFFF", "00" & x"FFAF", "01" & x"FFAB", "01" & x"00AB",
											"10" & x"AABB", "10" & x"BCBB", "11" & x"0102", "11" & x"340A");
begin
	process(clk)
	begin
		if (clk'event and clk = '1') then 
			data_out <= dataROM(conv_integer(address));
		end if;
	end process;
end Behavioral;

