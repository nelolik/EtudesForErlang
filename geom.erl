-module(geom).
-export([area/3]).

%area(rectangle, A, B) when A >= 0, B >= 0  -> A * B;
%area(triangle, A, B) when A >= 0, B >= 0 -> A * B / 2;
%area(ellipse, A, B) when A >= 0, B >= 0 -> math:pi() * A * B;
%area(_,_,_) -> 0.

% area({Sh, A, B}) -> area(Sh, A, B).

area(Sh, A, B) when A >= 0, B >= 0 ->
    case Sh of
        rectangle -> A * B;
        triangle -> A * B / 2.0;
        ellipse -> math:pi() * A * B;
        _ -> 0

    end.