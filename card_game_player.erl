-module(card_game_player).
-export([start/0]).

start() -> loop(self(), []).

loop(ArbitrPid, Cards) ->
    receive
        {Pid, {newgame, NewCards}} -> 
            io:format("Newgame~n"),
            loop(Pid, NewCards);
        {ArbitrPid, {takecards, NewCards}} ->
            loop(ArbitrPid, Cards ++ NewCards);
        {ArbitrPid, normal_step} ->
            if
                Cards /= [] ->
                    [H|T] = Cards,
                    ArbitrPid ! {self(), [H]},
                    loop(ArbitrPid, T);
                true ->
                    ArbitrPid ! {self(), []},
                    loop(ArbitrPid, [])
            end;
        {ArbitrPid, war_step} ->
            if
                length(Cards) >= 3 ->
                    {H,T} = lists:split(3, Cards),
                    ArbitrPid ! {self(), H},
                    loop(ArbitrPid, T);
                length(Cards) < 3 ->
                    ArbitrPid ! {self(), Cards},
                    loop(ArbitrPid, [])
            end
    end.