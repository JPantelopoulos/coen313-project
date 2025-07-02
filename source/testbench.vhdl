library ieee;
use ieee.std_logic_1164.all;

-- Entity declaration
entity people_counter_testbench is
end people_counter_testbench;

-- Architecture body
architecture tb_arch of people_counter_testbench is
   -- component declaration
   component people_counter
      port(
	     ent_sensor : in std_logic;
		 ext_sensor : in std_logic;
		 threshold : in std_logic_vector(7 downto 0);
		 reset, clk : in std_logic;
		 max_capacity : out std_logic;
		 disp_out : out std_logic_vector(7 downto 0)
	  );
   end component;
   
   -- signal declarations
   signal ent_sensor_out, ext_sensor_out : std_logic;
   signal thres : std_logic_vector(7 downto 0);
   signal clear, clock : std_logic;
   signal count : std_logic_vector(7 downto 0);
   signal max_cap : std_logic;
   
begin
   -- component instantiation
   uut : people_counter
      port map (ent_sensor => ent_sensor_out, ext_sensor => ext_sensor_out, 
	              threshold => thres, reset => clear, clk => clock,
				     disp_out => count, max_capacity => max_cap);

   -- test vector generator
   process
   begin
      -- initialize all signals
	  clear <= '1';
      ent_sensor_out <= '0';
	  ext_sensor_out <= '0';-- set the threshold
	  clock <= '0';
      wait for 2 ns;
	  
	  -- set threshold
	  thres <= "00000100"; -- 4
	  wait for 2 ns;
	  
      -- deassert clear
	  clear <= '0';
	  
	  -- increment the counter to (threshold + 1)
	  -- Note: r_reg | count
	  
	  -- 1 | 1
	  clock <= '1';
	  wait for 2 ns;
	  ent_sensor_out <= '1';
	  clock <= '0';
	  wait for 2 ns;
	  clock <= '1';
	  wait for 2 ns;
	  ent_sensor_out <= '0';
	  clock <= '0';
	  wait for 2 ns;
	  
	  -- 2 | 2
	  clock <= '1';
	  wait for 2 ns;
	  ent_sensor_out <= '1';
	  clock <= '0';
	  wait for 2 ns;
	  clock <= '1';
	  wait for 2 ns;
	  ent_sensor_out <= '0';
	  clock <= '0';
	  wait for 2 ns;
	  
	  -- 3 | 3
	  clock <= '1';
	  wait for 2 ns;
	  ent_sensor_out <= '1';
	  clock <= '0';
	  wait for 2 ns;
	  clock <= '1';
	  wait for 2 ns;
	  ent_sensor_out <= '0';
	  clock <= '0';
	  wait for 2 ns;
	  
	  -- 4 | 4
	  clock <= '1';
	  wait for 2 ns;
	  ent_sensor_out <= '1';
	  clock <= '0';
	  wait for 2 ns;
	  clock <= '1';
	  wait for 2 ns;
	  ent_sensor_out <= '0';
	  clock <= '0';
	  wait for 2 ns;
	  
	  -- 5 | 4
	  clock <= '1';
	  wait for 2 ns;
	  ent_sensor_out <= '1';
	  clock <= '0';
	  wait for 2 ns;
	  clock <= '1';
	  wait for 2 ns;
	  ent_sensor_out <= '0';
	  clock <= '0';
	  wait for 2 ns;
	  
	  -- if someone enters and another leaves at the same time
	  -- 5 | 4
	  clock <= '1';
	  wait for 2 ns;
	  ent_sensor_out <= '1';
	  ext_sensor_out <= '1';
	  clock <= '0';
	  wait for 2 ns;
	  clock <= '1';
	  wait for 2 ns;
	  ent_sensor_out <= '0';
	  ext_sensor_out <= '0';
	  clock <= '0';
	  wait for 2 ns;
	  
	  -- if no one enters or leaves
	  -- 5 | 4
	  clock <= '1';
	  wait for 2 ns;
	  clock <= '0';
	  wait for 2 ns;
	  clock <= '1';
	  wait for 2 ns;
	  clock <= '0';
	  wait for 2 ns;
	  
	  -- decrement the counter to 0
	  -- 4 | 4
	  clock <= '1';
	  wait for 2 ns;
	  ext_sensor_out <= '1';
	  clock <= '0';
	  wait for 2 ns;
	  clock <= '1';
	  wait for 2 ns;
	  ext_sensor_out <= '0';
	  clock <= '0';
	  wait for 2 ns;
	  
	  -- 3 | 3
	  clock <= '1';
	  wait for 2 ns;
	  ext_sensor_out <= '1';
	  clock <= '0';
	  wait for 2 ns;
	  clock <= '1';
	  wait for 2 ns;
	  ext_sensor_out <= '0';
	  clock <= '0';
	  wait for 2 ns;
	  
	  -- 2 | 2
	  clock <= '1';
	  wait for 2 ns;
	  ext_sensor_out <= '1';
	  clock <= '0';
	  wait for 2 ns;
	  clock <= '1';
	  wait for 2 ns;
	  ext_sensor_out <= '0';
	  clock <= '0';
	  wait for 2 ns;
	  
	  -- 1 | 1
	  clock <= '1';
	  wait for 2 ns;
	  ext_sensor_out <= '1';
	  clock <= '0';
	  wait for 2 ns;
	  clock <= '1';
	  wait for 2 ns;
	  ext_sensor_out <= '0';
	  clock <= '0';
	  wait for 2 ns;
	  
	  -- 0 | 0
	  clock <= '1';
	  wait for 2 ns;
	  ext_sensor_out <= '1';
	  clock <= '0';
	  wait for 2 ns;
	  clock <= '1';
	  wait for 2 ns;
	  ext_sensor_out <= '0';
	  clock <= '0';
	  wait for 2 ns;
	  
	  -- test the underflow protection
	  clock <= '1';
	  wait for 2 ns;
	  ext_sensor_out <= '1';
	  clock <= '0';
	  wait for 2 ns;
	  clock <= '1';
	  wait for 2 ns;
	  ext_sensor_out <= '0';
	  clock <= '0';
	  wait for 2 ns;
	  
	  -- reset the counter
	  clear <= '1';
	  wait for 2 ns;
	  
   end process;
   
   -- verifier
   -- process
      -- -- variable declaration
	  -- variable error_status : boolean;
	  
   -- begin
      -- wait on clock, clear;
	  -- wait for 55 ns;
	  -- if ((clear = '1' and count = "00000000" and status = '0') or -- Testing:
	      -- (clear = '0' and count = "00000001" and status = '0') or -- *reset
		  -- (clear = '0' and count = "00000010" and status = '0') or -- *incrementor
		  -- (clear = '0' and count = "00000011" and status = '0') or -- *decrementor & underflow protection
	      -- (clear = '0' and count = "00000100" and status = '1') or -- *op = "00" | "11" conditions
		  -- (clear = '0' and count = "00000000" and status = '0'))
      -- then		  
	     -- error_status := false;
      -- else
         -- error_status := true;
      -- end if;
      
	  -- -- error reporting
      -- assert (not error_status);
         -- report "test failed." severity note;
   
   -- end process;

end tb_arch;  
