-module(parallelprocess).
-export([start/0, sum/2, sumz/0, add/2, calc/2, pt/1, lastdigit/1, prime/1, primality/1, digitize/1]).


add(M, N) ->
	io:fwrite("Process:~p. Will sum:~p+~p\n", [self(), M, N]),
	M + N.

calc(A, B) ->
	Self = self(),       % The spawned funs need a Pid to send to, use a closure
	Padd = spawn(fun() -> Self ! {self(), add(A, B)} end),
	wait_for_response(Padd, 0).
	% POne = spawn(fun() -> Self ! {self(), add(A)} end),
	% PTwo = spawn(fun() -> Self ! {self(), add(B)} end),
	% wait_for_response(POne, PTwo, 0).

wait_for_response(undefined, Sum) ->
	Sum;
wait_for_response(Padd, Sum) ->
	receive
		{Padd, V} -> wait_for_response(undefined, Sum + V)
	end.



sumz() ->
	receive {Term1, Term2} ->
		Self = self(),
		spawn(fun() -> Self ! {self(), sum(Term1, Term2)} end)
	end.

sum(Term1, Term2) ->
	Term1 + Term2.

start() ->
	ParentPid = self(),
	io:fwrite("Root process:~p~n\n", [ParentPid]),

	ProcSumz = spawn(parallelprocess, sumz, []),
	ProcSumz ! {1, 2},

	Calc1 = calc(1,2),
	Calc2 = calc(Calc1,2),
	Calc3 = calc(Calc2,2),
	io:fwrite("Calc1:~p.\n", [Calc1]),
	io:fwrite("Calc2:~p.\n", [Calc2]),
	io:fwrite("Calc3:~p.\n", [Calc3]),
	io:fwrite("ProcSumz:~p.\n", [ProcSumz]),
	io:fwrite("\n").

% last(L) -> last(L, #{}).
% last([], Acc) -> Acc;
% last([H|T], #{}) -> last(T, #{ H => 1 });
% % last([H|T], Acc = #{ H := C }) -> last(T, Acc#{ H := C + 1});
% last([H|T], Acc = #{ H1 := C }) when H1 =:= H -> last(T, Acc#{ H := C + 1});
% last([H|T], Acc) -> last(T, Acc#{ H => 1 }).

pt(M) ->
	io:fwrite("~p\n", M).

digitize(N) when N < 10 -> N;
digitize(N) when N >= 10 -> digitize(digitize(N div 10) + N rem 10).

lastdigit(D) -> D rem 10.

prime(1) -> false;
prime(2) -> true;
prime(3) -> true;
prime(5) -> true;
prime(7) -> true;

% prime(P) when digitize(P) == 9 -> false;

prime(P) ->
	D=digitize(P),
	% io:fwrite("digitize of ~p is ~p~n", [P, D]),
	% case D of
	% 	{D} when D == 9 -> false;
	% 	{D} when D < 9 -> io:fwrite("call prime of ~p~n", [P]),
	% if
	% 	P rem 2 == 0 -> false;
	% 	% P rem 10 == 1 -> io:fwrite("will call next~n"), prime(P, P-1);
	% 	P rem 10 == 1 -> prime(P, P-1);
	% 	P rem 10 == 3 -> prime(P, P-1);
	% 	P rem 10 == 5 -> false;
	% 	P rem 10 == 7 -> prime(P, P-1);
	% 	P rem 10 == 9 -> prime(P, P-1);
	% 	true -> nil
	% end
	% end.
	DIV = trunc(math:sqrt(P))*2+1,
	if
		P rem 2 == 0 -> false;
		P rem 10 == 5 -> false;
		true ->
			if
				% D == 9 -> io:fwrite("digitize of ~p is ~p~n", [P, D]), false;
				D == 9 -> false;
				% P rem 10 == 1 -> io:fwrite("will call next~n"), prime(P, P-1);
				P rem 10 == 1 -> prime(P, DIV);
				P rem 10 == 3 -> prime(P, DIV);
				P rem 10 == 7 -> prime(P, DIV);
				P rem 10 == 9 -> prime(P, DIV);
				true -> nil
			end
	end.

% prime(P, D) -> io:fwrite("/2:will divide ~p rem ~p and counter 0~n", [P, D]), prime(P, D, 0).
prime(P, D) -> prime(P, D, 0).

prime(_, _, 1) -> false;
prime(_, 1, _) -> true;
prime(P, D, C) ->
	if
		% P rem D == 0 -> io:fwrite("/3:true:will divide ~p rem ~p and counter:~p~n", [P, D-1, C+1]), prime(P, D-1, C+1);
		% true -> io:fwrite("/3:false:will divide ~p rem ~p and counter:~p~n", [P, D-1, C]), prime(P, D-1, C)
		P rem D == 0 -> prime(P, D-2, C+1);
		true -> prime(P, D-2, C)
	end.

forp(0, C) -> C;
forp(N, C) when N > 0 ->
	% io:fwrite("~p:\t~w~n", [N, prime(N)]),
	PP = prime(N),
	if
		% PP == true -> io:fwrite("~p:\t~w~n", [N, prime(N)]), forp(N-1, C+1);
		PP == true -> forp(N-1, C+1);
		true -> forp(N-1, C)
	end.

primality(P) ->
	forp(P, 0).

