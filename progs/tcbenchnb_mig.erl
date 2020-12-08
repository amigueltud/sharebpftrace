-module(tcbenchnb_mig).
-export([start/2, init/2, thread/1, runone/0, run10100/0, run10100000/0, runone100000/0, run100000one/0, run100000100/0, run10000010000/0]).

runone() ->
%  start(10, 100000).
  start(1, 1).

run10100000() ->
  start(10, 100000).

run10100() ->
  start(10, 1000).

runone100000() ->
  start(1, 100000).

run100000one() ->
  start(100000, 1).

run100000100() ->
  start(100000, 100).

run10000010000() ->
  start(100000, 10000).


start(Total_Rounds, Step) ->
%   io:format("Proc;Threads;Diff micros~n"),
  spawn(?MODULE, init, [Total_Rounds, Step]).

init(Total_Rounds, Step) ->
  Start_Time = os:timestamp(),
  create_threads(0, 0, Total_Rounds, Step, Start_Time).

create_threads(Total_Rounds, _, Total_Rounds, _, _) ->
  init:stop();

create_threads(Round, Step, Total_Rounds, Step, Last_Time) ->
  wait_threads(Round, 0, Total_Rounds, Step, Last_Time);

create_threads(Round, Created, Total_Rounds, Step, Last_Time) ->
  spawn(?MODULE, thread, [self()]),
  create_threads(Round, Created+1, Total_Rounds, Step, Last_Time).

wait_threads(Round, Step, Total_Rounds, Step, Last_Time) ->
  Time = os:timestamp(),
  Diff = timer:now_diff(Time, Last_Time),
%  io:format("~p~n", [Diff div 1000]),
%   io:format("Proc:~p\t\tThreads:~p\tDiff micros:~p\tDiff millis:~p\tDiff secs:~p\tAvg micros:~p~n", [Round, Step, Diff, Diff div 1000, Diff div 1000 div 1000, Diff div Step]),
  io:format("~p;~p;~p~n", [Round, Step, Diff]),
  create_threads(Round+1, 0, Total_Rounds, Step, Time);

wait_threads(Round, Started, Total_Rounds, Step, Last_Time) ->
  receive
    started ->
      wait_threads(Round, Started+1, Total_Rounds, Step, Last_Time)
  end.

thread(Parent) ->
  Parent ! started.

