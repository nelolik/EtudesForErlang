-module(teeth).
-export([alert/1]).

alert(PocketDepths) -> alert(PocketDepths, [], 1).

alert([], TeethNumbers, _) -> lists:reverse(TeethNumbers);
alert([CurrentDepths|DepthsListTail], TeethNumbers, CurrentTeeth) ->
    TeethCondition = checkTeeth(CurrentDepths),
    if
        TeethCondition == ok -> alert(DepthsListTail, TeethNumbers, CurrentTeeth + 1);
            
        TeethCondition == bad -> alert(DepthsListTail, [CurrentTeeth|TeethNumbers], CurrentTeeth + 1)
            
    end.

checkTeeth([]) -> ok;
checkTeeth([H|T]) when H < 4 -> checkTeeth(T);
checkTeeth([H|_]) when H == 4 -> bad.
