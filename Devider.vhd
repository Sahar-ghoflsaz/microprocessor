----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:07:21 01/22/2018 
-- Design Name: 
-- Module Name:    Devider - Behavioral 
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

entity Divider is
    Port ( input1 : in  STD_LOGIC_VECTOR (n-1 downto 0);
           input2 : in  STD_LOGIC_VECTOR (n-1 downto 0);
           divOut : out  STD_LOGIC_VECTOR (2*n-1 downto 0));
end Divider;

architecture Behavioral of Divider is
component Subtractor
	Port ( x : in  STD_LOGIC_VECTOR (n-1 downto 0);
			 y : in  STD_LOGIC_VECTOR (n-1 downto 0);
			 Output : out  STD_LOGIC_VECTOR (2*n-1 downto 0));
			 
	end component;
	Type states is (beq, start, s0, s1, s2);
	Signal state : states;
	Signal dividend : std_logic_vector (n-1 downto 0);
	Signal tempout : std_logic_vector (2*n-1 downto 0);
	Signal Counter : std_logic_vector (2*n-1 downto 0) := (others => '0');
	signal ack2 : std_logic;
begin
	Sub : Subtractor port map (input1,10, tempout);
	process(clk) 
	begin
		--
		
--		for I in 0 to 9 loop
--			input1
--		end loop;
		if (clk = '1' and clk'event) then
		--ack <= '0';
			case state is
				when beq =>	if (request = '1') then
										state <= start;
										end if;
					when start =>
						dividend <= input1;
						counter <= (others => '0');
						state <= s0;
				when s0 =>	if input1 > input2 then
									dividend <= input1;
									state <= s1;
								elsif input1 = input2 then
									divOut <= (others => '0');
									divOut(0) <= '1';
									ack <= '1';
									state <= beq;
								else
									divOut <= (others => '0');
									ack <= '1';
									state <= beq;
								end if;
								--check n divide to 0
				when s1 =>  if dividend > input2 then
									dividend <= tempout(n-1 downto 0);
									counter <= counter + 1;
									state <= s1;
								elsif dividend = input2 then
									counter <= counter + 1;
									state <= s2;
								else
									state <= s2;
								end if;
				when s2 =>	divOut <= counter;
								ack <= '1';
								state <= beq;
			end case;
		end if;
	end process;
end Behavioral;

