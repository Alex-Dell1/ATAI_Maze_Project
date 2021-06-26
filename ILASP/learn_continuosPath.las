row(1..5).
col(1..5).

obstacle(1,2).
obstacle(2,2).
obstacle(3,2).
obstacle(3,3).
obstacle(4,3).
obstacle(4,4).
obstacle(3,4).
obstacle(2,4).
obstacle(1,4).
obstacle(1,5).
obstacle(5,1).

start(1,1).
goal(5,5).

move(X,Y) :- start(X,Y).
0{move(X,Y)}1 :- row(X), col(Y).

% cannot move into obstacles
:- move(X,Y), obstacle(X,Y).

% reachability predicate
arc((X,Y),(X+1,Y)) :- move(X,Y), move(X+1,Y).
arc((X,Y),(X-1,Y)) :- move(X,Y), move(X-1,Y).
arc((X,Y),(X,Y+1)) :- move(X,Y), move(X,Y+1).
arc((X,Y),(X,Y-1)) :- move(X,Y), move(X,Y-1).
reach((X,Y), (X,Y)) :- start(X,Y).
reach(C3,C2) :- arc(C1,C2), reach(C3,C1).

%:- start(X,Y), move(Z,K), not reach((X,Y), (Z,K)). <- LEARN THIS
:- start(X,Y), goal(Z,K), not reach((X,Y), (Z,K)).


%%%%%%%%%%%%%%%%%%%%%SEARCH_SPACE + EXAMPLES%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#pos(a, {move(2,1), move(3,1), move(4,1)}, {move(1,3)}).
%#pos(b, {move(5,2), move(5,3)}, {move(1,4), move(2,3)}).

%#neg(c, {move(2,4), move(4,3), move(5,1)}, {}).
#neg(d, {move(2,3)}, {}).

#modeb(1, start(var(row), var(col))).
#modeb(1, move(var(row), var(col))).
#modeb(1, reach((var(row), var(col)), (var(row), var(col)))).

%#modeb(1, obstacle(var(row), var(col))).

%#minhl(0).
%#maxhl(10).
#maxv(4).
#disallow_multiple_head_variables.
#max_penalty(40).
