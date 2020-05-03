----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:48:58 01/21/2018 
-- Design Name: 
-- Module Name:    VHDL - Behavioral 
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

entity ALU is
    Port ( op1 : in  STD_LOGIC_VECTOR (n-1 downto 0);
           op2 : in  STD_LOGIC_VECTOR (n-1 downto 0);
           cmd : in  STD_LOGIC_VECTOR (1 downto 0);
           clk : in  STD_LOGIC;
			  req : in  STD_LOGIC;
           alu_out : out  STD_LOGIC_VECTOR (2*n-1 downto 0);
           ack : out  STD_LOGIC);
end ALU;

architecture Behavioral of ALU is
	component Adder
		Port ( input1 : in  STD_LOGIC_VECTOR (n-1 downto 0);
           input2 : in  STD_LOGIC_VECTOR (n-1 downto 0);
           output : out  STD_LOGIC_VECTOR (2*n-1 downto 0));
		end component;
	component Divider
		Port ( input1 : in  STD_LOGIC_VECTOR (n-1 downto 0);
           input2 : in  STD_LOGIC_VECTOR (n-1 downto 0);
			  clk : in STD_LOGIC;
			  request : in std_logic;
           divOut : out  STD_LOGIC_VECTOR (2*n-1 downto 0);
			  ack : out STD_LOGIC);
		end component;
	component Subtractor
		Port ( x : in  STD_LOGIC_VECTOR (n-1 downto 0);
				y : in  STD_LOGIC_VECTOR (n-1 downto 0);
				Output : out  STD_LOGIC_VECTOR (2*n-1 downto 0));
		end component;
	component Multiplier
    Port ( x : in  STD_LOGIC_VECTOR (n-1 downto 0);
           y : in  STD_LOGIC_VECTOR (n-1 downto 0);
			  clk : in std_logic;
			  request : in std_logic;
           Output : out  STD_LOGIC_VECTOR (2*n-1 downto 0);
			  ack : out STD_LOGIC);
		end component;
	Signal tempAdd : STD_LOGIC_VECTOR (2*n-1 downto 0);
	Signal tempSub : STD_LOGIC_VECTOR (2*n-1 downto 0);
	Signal tempDiv : STD_LOGIC_VECTOR (2*n-1 downto 0);
	Signal tempMul : STD_LOGIC_VECTOR (2*n-1 downto 0);
	--Signal ack1 : STD_LOGIC:='0';
	Signal ack2 : STD_LOGIC:='0';
	Signal ack3 : STD_LOGIC:='0';
	--Signal ack4 : STD_LOGIC:='0';
	signal reqmul : std_logic:='0'; 
	signal reqdiv:	std_logic:='0'; 
	Type states is (s0, s1, s2, s3, s4, s5, s6, s7);
	Signal state : states;
begin
	AdderUUT: Adder port map (op1, op2, tempAdd);
	DividerUUT: divider port map (op1, op2, clk, reqdiv, tempDiv, ack2);	
	MultiplierUUT: multiplier port map (op1, op2, clk, reqmul, tempMul, ack3);	
	SubtractorUUT: subtractor port map (op1, op2, tempSub);
	process(clk)
	begin
	
		if (clk'event and clk='1') then 
		ack <= '0';
		reqmul <= '0';
		reqdiv <='0';
			case state is 
				when s0 => 
							if (req = '1') then
								state <= s2;
							else
								state <= s0;
							end if;
				when s2 => 
							case cmd is 
								when "00" => state <= s3;
								when "01" => state <= s4;
								when "10" => state <= s5;
												reqmul<= '1';
								when "11" => state <= s6;
												reqdiv<= '1';
								when others => null;
							end case;
				when s3 =>
								alu_out <= tempAdd;
								ack <= '1';
								state <= s7;
				when s4 =>
								alu_out <= tempSub;
								ack <= '1';
								state <= s7;
				when s5 =>
							if (ack3 ='1') then
								alu_out <= tempMul;
								ack <= '1';
								state <= s7;
							else 
								ack <= ack3;
								state <= s5;
							end if;
				when s6 =>
							if (ack2 ='1') then
								alu_out <= tempDiv;
								ack <= '1';
								state <= s7;
							else 
								ack <= ack2;
								state <= s6;
							end if;
				when s7 => 
					state <= s0;
					ack <= '0';
				when others => null;
				end case;
			end if;
		end process;
end Behavioral;

