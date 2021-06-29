row(1..5).
col(1..2).

obstacle(1,2).

start(1,1).
goal(5,5).

%%%%%%%%%%%%%%

cell(X,Y) :- row(X), col(Y).

succ(0,1).
succ(X, X+1) :- cell(X,_).

move(0,0,X,Y) :- start(X,Y).
1{move(X,Y,X1,Y1): next((X,Y), (X1,Y1))}1:- move(_,_, X,Y), not goal(X,Y).

%PATHS ADJACENTS
next((V1,V2),(V3,V2)) :- cell(V1,V2), cell(V3,V2), succ(V3,V1).
next((V1,V2),(V3,V2)) :- cell(V1,V2), cell(V3,V2), succ(V1,V3).
next((V1,V2),(V1,V3)) :- cell(V1,V2), cell(V1,V3), succ(V3,V2).
next((V1,V2),(V1,V3)) :- cell(V1,V2), cell(V1,V3), succ(V2,V3).

#show move/4.
