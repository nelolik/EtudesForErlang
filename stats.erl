-module(stats).
-export([minimum/1, maximum/1, range/1, mean/1, stdv/1]).

minimum([]) -> [];
minimum([H|T]) -> minimum(T, H).

minimum([H|T], M) when H < M -> minimum(T, H);
minimum([_H|T], M) -> minimum(T, M);
minimum([], M)-> M.


maximum([]) -> [];
maximum([H|T]) -> maximum(T, H).

maximum([H|T], M) when H > M -> maximum(T,H);
maximum([_H|T], M) -> maximum(T, M);
maximum([], M) -> M.


range(L) -> range(L, 0).

range([_H|T], R) -> range(T, R + 1);
range([], R) -> R.

mean(L) -> 
    lists:foldl(fun(X,Sum) -> X + Sum end, 0,L) / length(L).

stdv(L) ->
 %   Sum = lists:foldl(fun(X,Sum) -> X + Sum end, 0,L),
%    SumSqares = lists:foldl(fun(X,Sum) -> X*X + Sum end, 0,L),
    {Sum, SumSqares} = lists:foldl(fun(X,{S1,S2}) -> {X + S1, X*X + S2} end, {0,0},L),
    N = length(L),
    math:sqrt((SumSqares * N - Sum * Sum) / (N * (N - 1))).


