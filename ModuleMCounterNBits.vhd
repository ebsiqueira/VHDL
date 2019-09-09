library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ModuleMCounterNBits is
	generic(N: natural := 6;
			  M: natural := 60);
	port(
		-- control inputs
		clock, reset,
		load, enable: in std_logic;
		-- data inputs
		d: in std_logic_vector(N-1 downto 0);
		-- control outputs
		-- data outputs
		q: out std_logic_vector(N-1 downto 0)
	);
end entity;

architecture canonicalForm of ModuleMCounterNBits is 
	subtype State is unsigned(N-1 downto 0); -- you can change the State type
	signal currentState, nextState: State;
begin
	-- next-state
	nextState <= unsigned(d) when load='1' else
					 currentState when enable='0' else
					 (others=>'0') when (currentState = M-1) else
					 currentState+1;
		
	-- memory register
	process(clock, reset) is
	begin
		if reset='1' then
			currentState <= (others=>'0'); -- you can change the reset state
		elsif rising_edge(clock) then
			currentState <= nextState;
		end if;
	end process;
	
	-- output-logic
		q <= std_logic_vector(currentState);
		
end architecture;