-module(card_game_arbitr).
-export([start/0]).

start() -> play_game().

play_game() ->
    Deck = cards:make_deck(),
    ShaffledDeck = cards:shuffle(Deck),
    {Player1Cards, Player2Cards} = 
        lists:split(trunc(length(ShaffledDeck) / 2), ShaffledDeck),
    io:format("Before spawn~n"),
    
    Player1Pid = spawn(fun card_game_player:start/0),
    Player2Pid = spawn(fun card_game_player:start/0),
    
    Player1Pid ! {self(), {newgame, Player1Cards}},
    Player2Pid ! {self(), {newgame, Player2Cards}},

    io:format("Before game loop~n"),
    
    game_loop(Player1Pid, Player2Pid, normal_step, []).


game_loop(Pid1, Pid2, Command, CardsOnDeck) ->
    case Command of
        normal_step ->
            io:format("Normal step~n"),
            Pid1 ! {self(), normal_step},
            receive
                {Pid1, Cards1} -> void
            end,
            Pid2 ! {self(), normal_step},
            receive
                {Pid2, Cards2} -> void
            end,
            if
                (Cards1 == []) -> player2wins;
                (Cards2 == []) -> player1wins;
                true ->
                    CompResult = cards:compare(hd(Cards1), hd(Cards2)),
                    case CompResult of
                        equial ->game_loop(Pid1, Pid2, war_step, Cards1 ++ Cards2);
                        more -> Pid1 ! {self(), {takecards, Cards1 ++ Cards2}},    
                            game_loop(Pid1, Pid2, normal_step, []);
                        less -> Pid2 ! {self(), {takecards, Cards1 ++ Cards2}},    
                            game_loop(Pid1, Pid2, normal_step, []);
                        error -> {error, {someerrorincompare}}
                    end    
            end;
        war_step ->
            io:format("War step~n"),
            Pid1 ! {self(), war_step},
            receive
                {Pid1, Cards1} -> void
            end,
            Pid2 ! {self(), war_step},
            receive
                {Pid2, Cards2} -> void
            end,
            if
                (Cards1 == []) -> player2wins;
                (Cards2 == []) -> player1wins;
                true ->
                    CompResult = cards:compare(hd(Cards1), hd(Cards2)),
                    case CompResult of
                        equial -> 
                            game_loop(Pid1, Pid2, war_step, Cards1 ++ Cards2 ++ CardsOnDeck);
                        more -> 
                            Pid1 ! {self(), {takecards, Cards1 ++ Cards2 ++ CardsOnDeck}},    
                            game_loop(Pid1, Pid2, normal_step, []);
                        less -> 
                            Pid2 ! {self(), {takecards, Cards1 ++ Cards2 ++ CardsOnDeck}},    
                            game_loop(Pid1, Pid2, normal_step, []);
                        error ->
                            {error, {someerrorincompare}}
                            
                    end
            end
    end.
    
