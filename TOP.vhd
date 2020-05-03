----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:44:30 01/22/2018 
-- Design Name: 
-- Module Name:    TOP - Behavioral 
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

entity TOP is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           counter : out  STD_LOGIC_VECTOR (2*n-1 downto 0));
end TOP;

architecture Behavioral of TOP is
	component ALU is 
		Port ( op1 : in  STD_LOGIC_VECTOR (n-1 downto 0);
           op2 : in  STD_LOGIC_VECTOR (n-1 downto 0);
           cmd : in  STD_LOGIC_VECTOR (1 downto 0);
           clk : in  STD_LOGIC;
			  req : in  STD_LOGIC;
           alu_out : out  STD_LOGIC_VECTOR (2*n-1 downto 0);
           ack : out  STD_LOGIC);
	end component;
	component ROM is 
		Port (address : in  STD_LOGIC_VECTOR (2 downto 0);
				clk : in STD_LOGIC;
				data_out : out STD_LOGIC_VECTOR (2*n+1 downto 0));
	end component;
	
	signal address :std_logic_vector(2 downto 0) :=(others=>'0');
	signal dataIN :std_logic_vector (2*n+1 downto 0);
	signal operand1: std_logic_vector (n-1 downto 0);
	signal operand2: std_logic_vector (n-1 downto 0);
	signal operator: std_logic_vector (1 downto 0);
	signal dataOUT: std_logic_vector (2*n-1 downto 0);
	signal ack1: std_logic ;	
	signal req1 : std_logic:='0';
   Type states is (beq,start ,s0, s1);
	Signal state : states := beq;
	Signal count : std_logic_vector(2*n-1 downto 0) := (others=>'0');
	
	begin
	ROML: ROM port map( address , clk, dataIN); 
	ALUL: ALU port map(operand1 ,operand2 ,operator ,clk ,req1 ,dataOUT ,ack1);
		process(clk, rst) 
		begin 

				if( rst = '1') then 
					address <= (others=>'0');
					count <= (others=>'0');
					counter <= (others=>'0');
				elsif (clk='1' and clk'event) then 
					req1 <= '0';
					case state is 
						when beq =>	if (address < "111") then
											address <= address + 1;	
											state <= start;
										else
											address <= "000";
											state <= start;
										end if;
						when start =>	req1 <= '1';
											operator <= dataIN(2*n+1 downto 2*n);
											operand1 <= dataIN(2*n-1 downto n);
											operand2 <= dataIN(n-1 downto 0);
											count <= count + 1;
											state <= s0;
						
						when s0 => state<=s1;  --to calculate

						when s1 =>  if (ack1 = '1' )then 
											counter <= count;
											state <= beq;
										end if;

						when others => null;
					end case;
				end if;
		end process;
end Behavioral;

