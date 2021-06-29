row(1..3).
col(1..3).

cell(X,Y) :- row(X), col(Y).

succ(X, X+1) :- cell(X,_), cell(X+1,_).
%pred(X, X-1) :- cell(X,_), cell(X-1,_).

%0 {next((X,Y), (A,B))} 4:- row(X), col(Y), row(A), col(B).

%next((X,Y), (Z, Y)):- cell(X,Y), succ(X,Z). <- LEARN THIS (ONE OF 4 CASES)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%SEARCH_SPACE + EXAMPLES%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#pos(a, {next((2,2), (2,1)), next((2,2), (1,2)), next((2,2), (3,2)), next((2,2), (2,3))}, {}).
#pos(ba, {next((3,1), (2,1)), next((3,1), (3,2))}, {}).
#pos(bb, {next((1,3), (1,2)), next((1,3), (2,3))}, {}).

%no out of range or jump
#neg(c, {next((2,2), (2,2))}, {}).
#neg(c, {next((3,1), (3,1))}, {}).
#neg(d, {next((2,2), (3,1))}, {}).
#neg(e, {next((2,2), (1,1))}, {}).
#neg(f, {next((1,1), (3,3))}, {}).


#modeb(1, cell(var(c), var(c))).
#modeb(1, succ(var(c), var(c))).
#modeh(next((var(c), var(c)), (var(c), var(c)))).

#maxv(3).
#max_penalty(50).

