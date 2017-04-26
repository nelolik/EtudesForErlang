-module(non_fp).
-export([generate_teeth/2]).

generate_teeth(ListOfTeeth, GoodProbability) -> 
        generate_teeth(ListOfTeeth, GoodProbability, []).

generate_teeth([], _, Acc) -> lists:reverse(Acc);
generate_teeth([Current|ExistingTeeth], GoodProbability, Acc) when Current == $F ->
    generate_teeth(ExistingTeeth, GoodProbability, [[0]|Acc]);
generate_teeth([Current|ExistingTeeth], GoodProbability, Acc) when Current == $T ->
    CT = generate_tooth(GoodProbability),
    generate_teeth(ExistingTeeth, GoodProbability, [CT | Acc]).


generate_tooth(GoodProbability) ->
    random:seed(now()),
    Rand_num = random:uniform(),
    if
        Rand_num > GoodProbability -> Base_depth = 3;
            
        true -> Base_depth = 2
            
    end,
    generate_tooth(Base_depth, 6, []).


generate_tooth(_, Number, Acc) when Number == 0 -> Acc;
generate_tooth(Base_depth, Number, Acc) ->
    generate_tooth(Base_depth, Number - 1, [Base_depth + random:uniform(3) - 2 | Acc]).