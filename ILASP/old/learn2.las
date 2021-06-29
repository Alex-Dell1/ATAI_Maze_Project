row(1..5).
col(1..5).

obstacle(1,2).
obstacle(2,2).
%obstacle(3,2).
obstacle(3,3).
%obstacle(4,3).
obstacle(4,4).
obstacle(3,4).
obstacle(2,4).
obstacle(1,4).
obstacle(1,5).
obstacle(5,1).

start(1,1).
goal(5,5).

cell(X,Y) :- row(X), col(Y).

succ(X, X+1) :- cell(X,_), cell(X+1,_).
pred(X, X-1) :- cell(X,_), cell(X-1,_).

%0 {next((X,Y), (A,B))} 4:- row(X), col(Y), row(A), col(B).

%next((X,Y), (Z, Y)):- cell(X,Y), succ(X,Z), not obstacle(Z,Y). <- LEARN THIS (ONE OF 4 CASES)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%SEARCH_SPACE + EXAMPLES%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#pos(a, {next((1,1), (2,1)), next((4,1),(3,1)), next((4,2), (4,1)), next((4,2), (4,3)), next((4,2), (3,2)), next((4,2), (5,2))}, {}).

#neg(b, {next((1,1), (0,1))}, {}).
#neg(d, {next((5,2), (6,2))}, {}).
#neg(c, {next((2,1), (2,2))}, {}).


%#pos(b, {move(5,2), move(5,3)}, {move(1,4), move(2,3)}).
%#neg(c, {move(2,4), move(4,3), move(5,1)}, {}).
%#neg(d, {move(2,3)}, {}).

#modeb(1, cell(var(c), var(c))).
#modeb(1, obstacle(var(c), var(c))).
#modeb(1, succ(var(c), var(c))).
%#modeb(1, pred(var(c), var(c))).
#modeh(next((var(c), var(c)), (var(c), var(c)))).

#maxv(3).
%#disallow_multiple_head_variables.
#max_penalty(50).

