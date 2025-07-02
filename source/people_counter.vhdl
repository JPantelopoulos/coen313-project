-- Name: John Pantelopoulos
-- Date: June 19, 2025

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Entity declaration
entity people_counter is
   port(
      ent_sensor : in std_logic; -- entrance sensor data input
      ext_sensor : in std_logic; -- exit sensor data input
      threshold : in std_logic_vector(7 downto 0);
      reset, clk : in std_logic;
      max_capacity : out std_logic;
      disp_out : out std_logic_vector(7 downto 0)
   );
end people_counter;

-- Architecture body
architecture sequential_arch of people_counter is
   -- signal declarations
   signal delay_reg_1, delay_reg_2 : std_logic;
   signal p1, p2 : std_logic;
   signal p1_reg, p2_reg : std_logic;
   signal op : std_logic_vector(1 downto 0);
   signal inc, dec : std_logic_vector(7 downto 0);
   signal r_next, r_reg : std_logic_vector(7 downto 0);
   
begin
   -- Edge Detectors
   -- entrance sensor
   process(clk, reset)
   begin
      if (reset = '1') then
	     delay_reg_1 <= '0';
	  elsif (clk'event and clk = '1') then
	     delay_reg_1 <= ent_sensor;
	  end if;
   end process;
   
   p1 <= (not delay_reg_1) and ent_sensor;
   
   -- exit sensor
   process(clk, reset)
   begin
      if (reset = '1') then
	     delay_reg_2 <= '0';
	  elsif (clk'event and clk = '1') then
	     delay_reg_2 <= ext_sensor;
	  end if;
   end process;
   
   p2 <= (not delay_reg_2) and ext_sensor;
   
   process(clk, reset)
   begin
      if (reset = '1') then
	     p1_reg <= '0';
		 p2_reg <= '0';
	  elsif (clk'event and clk = '1') then
	     p1_reg <= p1;
		 p2_reg <= p2;
	  end if;
   end process;
   
   op <= p2_reg & p1_reg;
   
   -- Next-state Logic
   -- incrementor w/ overflow protection
   inc <= r_reg when unsigned(r_reg) = 255 else
          std_logic_vector(unsigned(r_reg) + 1);
      
   -- decrementor w/ underflow protection
   dec <= r_reg when unsigned(r_reg) = 0 else
	      std_logic_vector(unsigned(r_reg) - 1);

   with op select
      r_next <= inc when "01", -- increment if someone enters
		        dec when "10", -- decrement if someone leaves
				r_reg when "11", -- do nothing if someone enters and another leaves
		        r_reg when others; -- "00" (do nothing if no one enters nor leaves)


   -- State Register
   process(clk, reset)
   begin
      if (reset = '1') then
         r_reg <= (others => '0');
      elsif (clk'event and clk = '1') then
         r_reg <= r_next;
      end if;
   end process;   


   -- Output Logic
   disp_out <= r_reg when unsigned(r_reg) <= unsigned(threshold) else
	           threshold;
				  
   max_capacity <= '1' when (unsigned(r_reg) >= unsigned(threshold)) else
	               '0';

end sequential_arch;	  
