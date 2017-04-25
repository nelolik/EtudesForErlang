-module(dijkstra).
-export([gcd/2]).

gcd(A, B) -> 
    if
        A == B -> A;
            
        A > B -> gcd(A - B, B);
            
        A < B -> gcd(A, B - A)
    end.