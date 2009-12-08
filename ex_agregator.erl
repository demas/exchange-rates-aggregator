-module(ex_agregator).
-export([register_agregator/0, process/2]).

register_agregator()->
    register(agregator, start_agregator()).

start_agregator()->
    spawn(fun prepare_agregator/0).

prepare_agregator()->
    loop_agregator().

loop_agregator()->
    receive
	{From, {process, Data}}->
	    io:format("here: ~p~n", [Data]),
	    From ! {self(), "print"},
	    loop_agregator();
	{From, Other}->
	    io:format("Invalid input in agregator ~p~n", [Other]),
	    From ! {self(), {error,Other}},
	    loop_agregator()
    end.

agregator_rpc(Pid, Data)->
    Pid ! {self(), Data},
    receive
	{NewPid, Responce}->
	    Responce
    end.

process(Pid, Data)->
    agregator_rpc(Pid, {process, Data}).

    