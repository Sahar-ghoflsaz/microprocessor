----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:30:55 01/20/2018 
-- Design Name: 
-- Module Name:    Subtracter - Behavioral 
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

entity Subtractor is
Port ( x : in  STD_LOGIC_VECTOR (n-1 downto 0);
       y : in  STD_LOGIC_VECTOR (n-1 downto 0);
       Output : out  STD_LOGIC_VECTOR (2*n-1 downto 0));
end Subtractor;

architecture Behavioral of Subtractor is
	component ClAdder
		port ( A : in  STD_LOGIC_VECTOR (n-1 downto 0);
				  B : in  STD_LOGIC_VECTOR (n-1 downto 0);
				  Cin : in  STD_LOGIC;
				  Sum : out  STD_LOGIC_VECTOR (n-1 downto 0);
				  Cout : out  STD_LOGIC);
		end component;
	signal invertB : Std_logic_vector(n-1 downto 0);
	signal tcout : Std_logic;
	signal output1 : std_logic_vector(n downto 0);
	signal tout : std_logic_vector(n-1 downto 0);
	signal sefr : std_logic_vector(n-1 downto 0) :=(others =>'0');
begin
	invertB <= NOT y;
	CLA: CLAdder port map(x, invertB, '1', tout, tcout);
	output <= sefr & tout;
end Behavioral;

