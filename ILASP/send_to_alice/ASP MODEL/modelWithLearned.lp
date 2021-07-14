%MODEL THAT SOLVES PROBLEM OF PATHFINDING IN THE GRID
%5x5 grid used with my companions:
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

%CONSTRAINTS

%for each position define cell pred.
cell(X,Y) :- row(X), col(Y).

%FIND A PATH FROM START
move(0,0,X,Y) :- start(X,Y).
%for each "move" find another linked to it that is a legit move!
1{move(X,Y,X1,Y1): nextLegit((X,Y), (X1,Y1))}1:- move(_,_, X,Y), not goal(X,Y).

succ(0,1).
succ(X, X+1) :- cell(X,_).

%LEARNED BY ILASP, move on adj cells.
next((V1,V2),(V3,V2)) :- cell(V1,V2), cell(V3,V2), succ(V3,V1).
next((V1,V2),(V3,V2)) :- cell(V1,V2), cell(V3,V2), succ(V1,V3).
next((V1,V2),(V1,V3)) :- cell(V1,V2), cell(V1,V3), succ(V3,V2).
next((V1,V2),(V1,V3)) :- cell(V1,V2), cell(V1,V3), succ(V2,V3).

%LEARNED BY ILASP, move on adj cells. without obstacles
nextLegit((V1,V2),(V3,V2)) :- not obstacle(V1,V2); not obstacle(V3,V2); next((V3,V2),(V1,V2)).
nextLegit((V1,V2),(V1,V3)) :- not obstacle(V1,V2); not obstacle(V1,V3); next((V1,V2),(V1,V3)).

%ON GOAL POSITION STOP
:- goal(X,Y), not move(_,_, X,Y).

#show move/4.

