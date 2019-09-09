library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity BinaryCounterNBits is
	generic(N: natural := 8);
	port(
		-- control inputs
		clock, reset,
		load, enable, incr: in std_logic;
		-- data inputs
		d: in std_logic_vector(N-1 downto 0);
		-- control outputs
		-- data outputs
		q: out std_logic_vector(N-1 downto 0)
	);
end entity;

architecture canonicalForm of BinaryCounterNBits is 
	subtype State is unsigned(N-1 downto 0); -- you can change the State type
	signal currentState, nextState: State;
	------
	signal operando: unsigned(N-1 downto 0);
begin
	-- next-state
	operando <= to_unsigned(1,operando'length) when incr='1' else
					to_unsigned(-1,N);
	nextState <= unsigned(d) when load='1' else
					 currentState when enable='0' else
					 currentState+operando;
		
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