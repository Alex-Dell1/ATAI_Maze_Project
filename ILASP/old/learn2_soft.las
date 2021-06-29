row(1..5).
col(1..5).

start(1,1).
goal(5,5).

cell(X,Y) :- row(X), col(Y).

succ(X, X+1) :- cell(X,_), cell(X+1,_).
%pred(X, X-1) :- cell(X,_), cell(X-1,_).

%0 {next((X,Y), (A,B))} 4:- row(X), col(Y), row(A), col(B).

%next((X,Y), (Z, Y)):- cell(X,Y), succ(X,Z). <- LEARN THIS (ONE OF 4 CASES)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%SEARCH_SPACE + EXAMPLES%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#pos(a, {next((4,2), (4,1)), next((4,2), (4,3)), next((4,2), (3,2)), next((4,2), (5,2))}, {}).
#pos(ab, {next((3,4), (2,4))}, {}).
#pos(p, {next((2,3), (2,2)), next((2,3), (1,3)), next((2,3), (2,4)), next((2,3), (3,3))}, {}).

%no out of range or jump
#neg(b, {next((1,1), (0,1))}, {}).
#neg(c, {next((1,1), (3,2))}, {}).
#neg(d, {next((1,1), (1,0))}, {}).
#neg(e, {next((5,5), (6,5))}, {}).
#neg(f, {next((5,5), (5,6))}, {}).
%no diagonal move
#neg(g, {next((2,4), (1,3))}, {}).
#neg(h, {next((2,4), (1,5))}, {}).
#neg(i, {next((2,4), (3,5))}, {}).
#neg(l, {next((2,4), (3,3))}, {}).
%no move same cell
#neg(m, {next((2,4), (2,4))}, {}).

#neg(n, {next((4,2), (2,4))}, {}).


#modeb(1, cell(var(c), var(c))).
#modeb(1, succ(var(c), var(c))).
#modeh(next((var(c), var(c)), (var(c), var(c)))).

#maxv(3).
#max_penalty(50).

