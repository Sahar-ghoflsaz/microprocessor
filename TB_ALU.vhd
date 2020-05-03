--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:19:24 01/23/2018
-- Design Name:   
-- Module Name:   C:/Users/nimabarani/Desktop/ISE/Microcontroller/TB_ALU.vhd
-- Project Name:  Microcontroller
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ALU
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY TB_ALU IS
END TB_ALU;
 
ARCHITECTURE behavior OF TB_ALU IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         op1 : IN  std_logic_vector(7 downto 0);
         op2 : IN  std_logic_vector(7 downto 0);
         cmd : IN  std_logic_vector(1 downto 0);
         clk : IN  std_logic;
         req : IN  std_logic;
         alu_out : OUT  std_logic_vector(15 downto 0);
         ack : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal op1 : std_logic_vector(7 downto 0) := x"ab";
   signal op2 : std_logic_vector(7 downto 0) := x"ac";
   signal cmd : std_logic_vector(1 downto 0) := "10";
   signal clk : std_logic := '0';
   signal req : std_logic := '1';

 	--Outputs
   signal alu_out : std_logic_vector(15 downto 0);
   signal ack : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
  clk <= not clk after 1000 ns;
 
   process
	begin 
	
   wait for 20 ns;
	req <= '0';
	wait for 1000 ns;
	req <= '1';

	end process;
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          op1 => op1,
          op2 => op2,
          cmd => cmd,
          clk => clk,
          req => req,
          alu_out => alu_out,
          ack => ack
        );

END;
