----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:20:13 12/30/2017 
-- Design Name: 
-- Module Name:    CLAdder - Behavioral 
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

entity CLAdder is
    Port ( A : in  STD_LOGIC_VECTOR (n-1 downto 0);
           B : in  STD_LOGIC_VECTOR (n-1 downto 0);
           Cin : in  STD_LOGIC;
           Sum : out  STD_LOGIC_VECTOR (n-1 downto 0);
           Cout : out  STD_LOGIC);
end CLAdder;

architecture Behavioral of CLAdder is

signal h_sum : STD_LOGIC_VECTOR(n-1 DOWNTO 0);
signal CG : STD_LOGIC_VECTOR(n-1 DOWNTO 0);
signal CP : STD_LOGIC_VECTOR(n-1 DOWNTO 0);
signal Ci : STD_LOGIC_VECTOR(n-1 DOWNTO 1);

begin
    h_sum <= A XOR B;
    CG <= A AND B;
    CP <= A OR B;
    
	 PROCESS (CG, CP, Ci, Cin)
    BEGIN
    Ci(1) <= CG (0) OR (CP(0) AND Cin);
        inst: FOR i IN 1 TO n-2 LOOP
              Ci(i+1) <= CG (i) OR (CP(i) AND Ci(i));
              END LOOP;
    Cout <= CG (n-1) OR (CP(n-1) AND Ci(n-1));
    END PROCESS;

    sum(0) <= h_sum(0) XOR CIN;
    sum(n-1 DOWNTO 1) <= h_sum(n-1 DOWNTO 1) XOR Ci(n-1 DOWNTO 1);
end Behavioral;

