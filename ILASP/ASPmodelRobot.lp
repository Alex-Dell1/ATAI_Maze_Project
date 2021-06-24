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
goal(4,5).

move(X,Y) :- start(X,Y).
0{move(X,Y)}1 :- row(X), col(Y).

% cannot move into obstacles
:- move(X,Y), obstacle(X,Y).

% reachability predicate
arc((X,Y),(X+1,Y)) :- move(X,Y), move(X+1,Y).
arc((X,Y),(X-1,Y)) :- move(X,Y), move(X-1,Y).
arc((X,Y),(X,Y+1)) :- move(X,Y), move(X,Y+1).
arc((X,Y),(X,Y-1)) :- move(X,Y), move(X,Y-1).
reach(C1,C2) :- arc(C1,C2).
reach(C3,C2) :- arc(C1,C2), reach(C3,C1).

%same_cell((X,Y),(Z,K)) :- row(X), row(Z), col(Y), col(K), X == Z, Y == K.

%:- start(X,Y), move(Z,K), not same_cell((X,Y), (Z,K)), not reach((X,Y), (Z,K)).
:- start(X,Y), goal(Z,K), not reach((X,Y), (Z,K)).

cells_visited(S) :- S = #count {X,Y: move(X,Y)}.
#minimize {S:cells_visited(S)}.

#show move/2.
#show cells_visited/1.
