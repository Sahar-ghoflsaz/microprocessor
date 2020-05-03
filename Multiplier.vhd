----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:11:45 12/30/2017 
-- Design Name: 
-- Module Name:    Multiplier - Behavioral 
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
use work.MyPackage.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Multiplier is
    Port ( x : in  STD_LOGIC_VECTOR (n-1 downto 0);
           y : in  STD_LOGIC_VECTOR (n-1 downto 0);
			  clk : in std_logic;
			  request : in std_logic;
           Output : out  STD_LOGIC_VECTOR (2*n-1 downto 0);
			  ack : out STD_LOGIC);
end Multiplier;

architecture Behavioral of Multiplier is
component ClAdder
 Port ( A : in  STD_LOGIC_VECTOR (n-1 downto 0);
           B : in  STD_LOGIC_VECTOR (n-1 downto 0);
           Cin : in  STD_LOGIC;
           Sum : out  STD_LOGIC_VECTOR (n-1 downto 0);
           Cout : out  STD_LOGIC);
	end component;
	Type states is (beq, start, s0, s1,s2);
	Signal state : states := beq;
	signal temp : std_logic_vector(n-1 downto 0) := (others=>'0');
	signal outtemp: std_logic_vector(n-1 downto 0);
	signal counter : Integer range 0 to 2**n-1 := 1;
	signal tempCarry : std_logic_vector(n-1 downto 0) := (others=>'0');
	signal coutCarry : std_logic;
	signal outcarry: std_logic_vector(n-1 downto 0);
	signal temptemp : std_logic_vector(n-1 downto 0) := (others=>'0');
	signal coutt : std_logic;
	signal input : std_logic_vector(n-1 downto 0):=(others=>'0');
	constant sefr : std_logic_vector(n-2 downto 0):=(others=>'0');
	begin
	
	CLA: CLAdder port map(input, temp, '0', outtemp, coutt);
	temptemp <= sefr & coutt;
	CLACarry: CLAdder port map(temptemp, tempCarry, '0', outCarry, coutCarry);
	
	process(clk)
		begin
			if (clk = '1' and clk'event) then
				ack <= '0';
				case state is
					when beq =>	if (request = '1') then
										
										state <= start;
										end if;
					when start =>
						input <= x;
						temp <= (others => '0');
						tempCarry <= (others => '0');
						counter <= 1;
						state <= s0;
					when s0 => 	if (counter < y) then
										
										state <= s1;
									else 
										output <= outCarry & outtemp;
										ack <= '1';
										state <= beq;
									end if;
					when s1 => temp <= outtemp;
									tempCarry <= outCarry;
									counter <= counter +1;
									state <= s0;
					when others => null;
				end case;
			end if;	
			
			
	end process;
end Behavioral;


