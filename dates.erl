-module(dates).
-export([date_parts/1, julian/1]).


date_parts(Date) -> 
    PartsBin = re:split(Date, "-"),
    PartsLists = bin_to_list(PartsBin, []),
    NumbersList = list_to_number(PartsLists, []),
    if
        NumbersList == error -> error;
            
        true -> NumbersList %lists:reverse(NumbersList)
            
    end.



bin_to_list([H|T],Parts) -> bin_to_list(T, [binary:bin_to_list(H)|Parts]);
bin_to_list([], Parts) -> Parts.


list_to_number([H|T], Parts) -> 
    {N, _} = string:to_integer(H),
    if
        N == error -> error;
            
        true -> list_to_number(T, [N|Parts])
            
    end;
list_to_number([], Parts) -> Parts.

julian(Date) ->
    DateNumbers = date_parts(Date),
    DaysImMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31],
    DaysImMonthLeap = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31],

    if
        DateNumbers == error -> error;
            
        true -> 
            [Y, M | [D]] = DateNumbers,
            Leap_year = is_leap_year(Y),
            if
                Leap_year == true -> julian(Y, M, D, DaysImMonthLeap, 0);
                    
                true -> julian(Y, M, D, DaysImMonth, 0)
                    
            end
            
            
    end.

julian(Y, M, D, DArr, Summ) ->
    Rest = (13 - stats:range(DArr)),
    %io:format("~p~n", Rest),
    if
         Rest < M ->
            [ThisMonth | RestM] = DArr,
            julian(Y, M, D, RestM, Summ + ThisMonth);
            
        true -> Summ + D
            
    end.
    

parts([H|T]) -> [H, T].


is_leap_year(Year) -> 
    (Year rem 4 == 0 andalso Year rem 100 /= 0) 
    orelse(Year rem 400 == 0).