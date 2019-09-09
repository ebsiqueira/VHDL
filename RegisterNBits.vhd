library ieee;
use ieee.std_logic_1164.all;

entity RegisterNBits is
	generic(N: natural := 8);
	port(
		-- control inputs
		clock, reset,
		enable: in std_logic;
		-- data inputs
		d: in std_logic_vector(N-1 downto 0);
		-- control outputs
		-- data outputs
		q: out std_logic_vector(N-1 downto 0)
	);
end entity;

architecture canonicalForm of RegisterNBits is 
	subtype State is std_logic_vector(N-1 downto 0); -- you can change the State type
	signal currentState, nextState: State;
begin
	-- next-state
		nextState <= d when enable='1' else currentState;
		
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
		q <= currentState;
		
end architecture;