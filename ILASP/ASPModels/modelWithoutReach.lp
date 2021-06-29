%MODEL THAT SOLVES PROBLEM OF PATHFINDING IN THE GRID
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
cell(X,Y) :- row(X), col(Y).

%FIND A PATH FROM START
move(0,0,X,Y) :- start(X,Y).
1{move(X,Y,X1,Y1): next((X,Y), (X1,Y1))}1:- move(_,_, X,Y), not goal(X,Y).

%next((X,Y), (Z, Y)):- row(X), col(Y), succ(X,Z), not obstacle(Z,Y).
%next((X,Y), (Z, Y)):- row(X), col(Y), pred(X,Z), not obstacle(Z,Y).
%next((X,Y), (X, Z)):- row(X), col(Y), succ(Y,Z), not obstacle(X,Z).
%next((X,Y), (X, Z)):- row(X), col(Y), pred(Y,Z), not obstacle(X,Z).

%next((X,Y), (Z, Y)):- cell(X,Y), succ(X,Z), not obstacle(Z,Y).
%next((X,Y), (Z, Y)):- cell(X,Y), succ(Z,X), not obstacle(Z,Y).
%next((X,Y), (X, Z)):- cell(X,Y), succ(Y,Z), not obstacle(X,Z).
%next((X,Y), (X, Z)):- cell(X,Y), succ(Z,Y), not obstacle(X,Z).

%LEARNED BY ILASP, move on adj cells.
next((V1,V2),(V3,V2)) :- cell(V1,V2), cell(V3,V2), succ(V3,V1).
next((V1,V2),(V3,V2)) :- cell(V1,V2), cell(V3,V2), succ(V1,V3).
next((V1,V2),(V1,V3)) :- cell(V1,V2), cell(V1,V3), succ(V3,V2).
next((V1,V2),(V1,V3)) :- cell(V1,V2), cell(V1,V3), succ(V2,V3).

%CANNOT MOVE INTO OBSTACLES
:- move(X,Y,Z,K), obstacle(Z,K).
%ON GOAL POSITION STOP
:- goal(X,Y), not move(_,_, X,Y).

succ(0,1).
succ(X, X+1) :- cell(X,_).

#show move/4.
%#show cells_visited/1.

