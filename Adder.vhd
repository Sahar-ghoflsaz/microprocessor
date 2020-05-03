----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:52:18 01/21/2018 
-- Design Name: 
-- Module Name:    Adder - Behavioral 
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
use work.MyPackage.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Adder is
    Port ( input1 : in  STD_LOGIC_VECTOR (n-1 downto 0);
           input2 : in  STD_LOGIC_VECTOR (n-1 downto 0);
           output : out  STD_LOGIC_VECTOR (2*n-1 downto 0));
end Adder;

architecture Behavioral of Adder is
	component ClAdder
		port ( A : in  STD_LOGIC_VECTOR (n-1 downto 0);
				 B : in  STD_LOGIC_VECTOR (n-1 downto 0);
				 Cin : in  STD_LOGIC;
				 Sum : out  STD_LOGIC_VECTOR (n-1 downto 0);
				 Cout : out  STD_LOGIC);
		end component;
	signal sumOut : std_logic_vector (n-1 downto 0);
	signal carryOut : std_logic;
	signal temp : std_logic_vector (n downto 0);
	constant sefr: std_logic_vector (n-2 downto 0):=(others=>'0');

begin
	Add: CLAdder port map(input1, input2, '0', sumOut, carryOut);
	temp <= carryOut & sumOut;
	output <= sefr & temp;
end Behavioral;

