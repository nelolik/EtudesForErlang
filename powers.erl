-module(powers).
-export([raise/2, nth_root/2]).

%raise(0, _) -> 0;
%raise(_, 0) -> 1;
%raise(B, P) when P > 0 -> B * raise(B, P - 1);
% raise(B, P) when P < 0 -> 1 / raise(B, -P).

raise(X, N) -> raise(X, N, 1).

raise(0, _, _) -> 0;
raise(_, 0, Acc) -> Acc;
raise(X, N, Acc) when N > 0 -> raise(X, N - 1, Acc * X);
raise(X, N, Acc) when N < 0 -> raise(X, N + 1, Acc / X).


nth_root(X,N) -> nth_root(X, N, X / 2.0).

nth_root(X, N, A) ->
    F = raise(A, N) - X,
    Fprime = N * raise(A, N-1),
    NextA = A - F / Fprime,
    if
        (A - NextA) > 1.0e-8; (A - NextA) < -1.0e-8 -> nth_root(X, N, NextA);
            
        true -> NextA
            
    end.