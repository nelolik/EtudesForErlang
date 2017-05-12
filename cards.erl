-module(cards).
-export([make_deck/0, show_deck/1, shuffle/1, compare/2]).


make_deck() ->
    Lear = ["Clubs", "Diamonds", "Hearts", "Spades"],
    Card = ["A", 2, 3, 4, 5, 6, 7, 8, 9, 10, "J", "Q", "K"],
    [{C, L} || C <- Card, L <- Lear].

show_deck(Deck) ->
    lists:foreach(fun(Item) -> io:format("~p~n", [Item]) end, Deck).


shuffle(List) -> shuffle(List, []).
shuffle([], Acc) -> Acc;
shuffle(List, Acc) ->
    {Leading, [H | T]} = lists:split(random:uniform(length(List)) - 1, List),
    shuffle(Leading ++ T, [H | Acc]).

compare([],[]) -> equial;
compare([],_) -> less;
compare(_,[]) -> more;
compare({C1,_L1}, {C2,_L2}) ->
    if
        C1 == C2 -> equial;
            
        true -> 
            case C1 of
                "A" -> more;
                "K" when C2 /= $A -> more;
                "K" when C2 == $A -> less;
                "Q" when (C2 /= "A") and (C2 /= "K") -> more;
                "Q" when (C2 == "A") or (C2 == "K") -> less;
                "J" when (C2 /= "A") and (C2 /= "K") and (C2 /= "Q") -> more;
                "J" when (C2 == "A") or (C2 == "K") or (C2 == "Q") -> less;
                10 when (C2 /= "A") and (C2 /= "K") and (C2 /= "Q") and (C2 /= "J") -> more;
                10 when (C2 == "A") or (C2 == "K") or (C2 == "Q") or (C2 == "J") -> less;
                9 when (C2 /= "A") and (C2 /= "K") and (C2 /= "Q") and (C2 /= "J") and (C2 /= 10) -> more;
                9 when (C2 == "A") or (C2 == "K") or (C2 == "Q") or (C2 == "J") or (C2 == 10) -> less;
                8 when (C2 /= "A") and (C2 /= "K") and (C2 /= "Q") and (C2 /= "J") 
                                                                    and (C2 /= 10) and (C2 /= 9) -> more;
                8 when (C2 == "A") or (C2 == "K") or (C2 == "Q") or (C2 == "J") 
                                                                    or (C2 == 10) or (C2 == 9) -> less;
                7 when (C2 /= "A") and (C2 /= "K") and (C2 /= "Q") and (C2 /= "J") 
                                                    and (C2 /= 10) and (C2 /= 9) and (C2 /= 9) -> more;
                7 when (C2 == "A") or (C2 == "K") or (C2 == "Q") or (C2 == "J") 
                                                    or (C2 == 10) or (C2 == 9) or (C2 == 9) -> less;
                6 when (C2 == 5) or (C2 == 4) or (C2 == 3) or (C2 == 2) -> more;
                6 when (C2 /= 5) and (C2 /= 4) and (C2 /= 3) and (C2 /= 2) -> less;
                5 when (C2 == 4) or (C2 == 3) or (C2 == 2) -> more;
                5 when (C2 /= 4) and (C2 /= 3) and (C2 /= 2) -> less;
                4 when (C2 == 3) or (C2 == 2) -> more;
                4 when (C2 /= 3) and (C2 /= 2) -> less;
                3 when (C2 == 2) -> more;
                3 when (C2 /= 2) -> less;
                2 -> less;
                true -> error
            end
            
    end.