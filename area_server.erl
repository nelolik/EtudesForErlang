-module(area_server).
-export([start/0, rpc/2]).

loop() -> 
    receive
        {rectangle, Width, Ht} ->
            io:format("*Area of rectangle is ~p~n*", [Width * Ht]),
            loop();
        {circle, R} -> 
            io:format("*Area of circle is ~p~n*", [3.14159 * R * R]),
            loop();
        {triangle, A, B} ->
            io:format("*Area of triangle is ~p~n*", [A * B / 2]),
            loop();
        Other -> 
            io:format("*I don`t know what the area of a ~p is ~n", [Other]),
            loop()
    end.

rpc(Pid, Request) -> 
    Pid ! {self(), Request},
    receive
        {Pid, Response} ->
            Response
        end.

loop1() ->
    receive
        {From, {rectangle, Width, Ht}} ->
            From ! {self(), Width * Ht},
            loop1();
        {From, {circle, R}} -> 
            From ! {self(), 3.14159 * R * R},
            loop1();
        {From, {triangle, A, B}} ->
            From ! {self(), A * B / 2},
            loop1();
        {From, Other} ->
            From ! {self(), {error, Other}},
            loop1()
    end.

start() ->spawn(fun loop1/0).