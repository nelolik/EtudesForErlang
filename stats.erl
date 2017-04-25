-module(stats).
-export([minimum/1, maximum/1, range/1]).

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
