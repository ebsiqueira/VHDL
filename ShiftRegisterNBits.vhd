library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ShiftRegisterNBits is
	generic(N: natural := 8);
	port(
		-- control inputs
		clock, reset,
		load, enable, toLeft: in std_logic;
		-- data inputs
		d: in std_logic_vector(N-1 downto 0);
		dLeft, dRight: in std_logic;
		-- control outputs
		-- data outputs
		q: out std_logic_vector(N-1 downto 0);
		qLeft, qRight: out std_logic
	);
end entity;

architecture canonicalForm of ShiftRegisterNBits is 
	subtype State is std_logic_vector(N-1 downto 0); -- you can change the State type
	signal currentState, nextState: State;
begin
	-- next-state
	nextState <= d when load='1' else
					 currentState when enable='0' else
					 currentState(N-2 downto 0)&dRight when toLeft='1' else
					 dLeft & currentState(N-1 downto 1);
					 
		
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