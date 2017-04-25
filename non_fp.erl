-module(non_fp).



generate_teeth([], _, Acc) -> lists:reverse(Acc);
generate_teeth([Current|ExistingTeeth], GoodProbability, Acc) when Current == $F ->
    generate_teeth(ExistingTeeth, GoodProbability, [[0]|Acc]);
generate_teeth([Current|ExistingTeeth0], GoodProbability, Acc) when Current == $T ->
    CT = 


generate_tooth($F) -> [0];
