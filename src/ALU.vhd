----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/18/2025 02:50:18 PM
-- Design Name: 
-- Module Name: ALU - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port ( i_A : in STD_LOGIC_VECTOR (7 downto 0);
           i_B : in STD_LOGIC_VECTOR (7 downto 0);
           i_op : in STD_LOGIC_VECTOR (2 downto 0);
           o_result : out STD_LOGIC_VECTOR (7 downto 0);
           o_flags : out STD_LOGIC_VECTOR (3 downto 0));
end ALU;

architecture Behavioral of ALU is

signal w_b_mux : std_logic_vector(7 downto 0);
signal w_sum : std_logic_vector(8 downto 0);
signal w_c_out : std_logic;
signal w_c_in : std_logic_vector (8 downto 0);
signal w_mux_output : std_logic_vector(7 downto 0);

begin

    
    w_b_mux <= (not i_B) when i_op(0) = '1' else
               i_B;
    w_c_in <= "00000000" & i_op(0);
    w_sum <= std_logic_vector(unsigned('0' & i_A) + unsigned('0' & w_b_mux) + unsigned(w_c_in));
    w_c_out <= w_sum(8);
    
    w_mux_output <= w_sum(7 downto 0) when i_op = "000" else
                    w_sum(7 downto 0) when i_op = "001" else
                    (i_A AND i_B) when i_op = "010" else
                    (i_A OR i_B) when i_op = "011" else
                    "00000000";
    
    -- output logic for the flags
    o_flags(0) <= (not (i_op(0) XOR i_A(7) XOR i_B(7))) AND (i_A(7) XOR w_sum(7)) AND (not i_op(1));
    o_flags(1) <= (not i_op(1)) AND w_c_out;
    o_flags(2) <= (not (w_mux_output(7) OR w_mux_output(6) OR w_mux_output(5) OR w_mux_output(4) 
                    OR w_mux_output(3) OR w_mux_output(2) OR w_mux_output(1) OR w_mux_output(0)));
    o_flags(3) <= w_mux_output(7);
    
    o_result <= w_mux_output;
    
    


end Behavioral;
