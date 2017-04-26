-module(lists_patterns).
-export([older_then/2]).


older_then(People, Compare) ->
    older_then(People, Compare, []).

older_then([], _, Acc) -> lists:reverse(Acc);
older_then([{Name,Gender,Age}|People], Compare, Acc) when Age > Compare; Gender == $M ->
    older_then(People, Compare, [{Name, Gender, Age}|Acc]);
older_then([{_,_,Age}|People], Compare,Acc) ->
    older_then(People, Compare, Acc).