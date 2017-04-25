-module(ask_area).
-export([area/0]).

area() ->
    ShInput = get_shape(),
    ShAtom = char_to_shape(ShInput),
    if
        ShAtom == unknown -> string:concat("Unknown shape ", ShInput);
            
        true -> {Din1, Din2} = get_dimentions(ShAtom),
            {Dnum1, Dnum2} = get_dimentions(Din1, Din2),
            calculate(ShAtom, Dnum1, Dnum2)
            
    end.
    

    
char_to_shape(L) -> 
    case L of
    "R" -> rectangle;
    "r" -> rectangle;
    "T" ->triangle;
    "t" -> triangle;
    "E" -> ellipse;
    "e" -> ellipse;
    _ -> unknown
    end.

get_number(N) ->
    case string:to_float(N) of
        {error, no_float} -> 
            case string:to_integer(N) of
                {error, no_float} -> no_number;
                {IntNum, _} -> IntNum
            end;
        {FlNum, _} -> FlNum
    end.

get_dimentions(N1, N2) ->
    Dim1 = get_number(N1),
    Dim2 = get_number(N2),
    {Dim1, Dim2}.


calculate(_, no_number, no_number) ->
    io:format("Error in both numbers.");
calculate(_, no_number, _) ->
    io:format("Error in first number.");
calculate(_, _, no_number) ->
    io:format("Error in second number");
calculate(Sh, D1, D2) when D1 >= 0, D2 >= 0 -> geom:area(Sh, D1, D2);
calculate(_, _, _) -> 
    io:format("Both numbers must be greater then or equal to zero.").

get_shape() ->
    {ok,[Sh]} = io:fread("R)ectangle, T)riangle, E)llipse > ","~s"),
    Sh.

get_dimentions(rectangle) -> 
    {ok, [W]} = io:fread("Enter width > ", "~s"),
    {ok, [H]} = io:fread("Enter height > ", "~s"),
    {W, H};
get_dimentions(triangle) ->
    {ok, [B]} = io:fread("Enter base > ", "~s"),
    {ok, [H]} = io:fread("Enter height > ", "~s"),
    {B, H};
get_dimentions(ellipse) -> 
    {ok, [A1]} = io:fread("Enter major axis > ", "~s"),
    {ok, [A2]} = io:fread("Enter minor axis > ", "~s"),
    {A1, A2}.


