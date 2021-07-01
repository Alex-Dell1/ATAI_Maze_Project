:- use_module('metagol.pl').

%metagol:max_clauses(2).

%%% METARULES %%%
metarule(recursion, [P,Q,R], [P,A,B], [[R,A], [R,B], [Q,A,C], [R,C], [P,C,B]]).
metarule(ident, [P,Q], [P,A,B], [[Q,A,B]]).
metarule(postcon, [P,Q,R], [P,A,B], [[R,B], [R,A], [Q,A,B]]).

%%% BACKGROUND KNOWLEDGE %%%
width(3).
height(3).

% Check whether two coordinates are in bounds.
in_range((X, Y)) :-
    width(MaxWidth),
    height(MaxHeight),
    integer(X),
    (ground(X) -> integer(X); true),
    integer(Y),
    (ground(Y) -> integer(Y); true),
    X > 0, 
    X =< MaxWidth,
    Y > 0, 
    Y =< MaxHeight.

inc_x((X, Y), (X1, Y)) :-
    integer(X),
    (ground(X1) -> integer(X1); true),
    succ(X, X1).

dec_x((X, Y), (X1, Y)) :-
    integer(X),
    (ground(X1) -> integer(X1); true),
    succ(X1, X).

inc_y((X, Y), (X, Y1)) :-
    integer(Y),
    (ground(Y1) -> integer(Y1); true),
    succ(Y, Y1).

dec_y((X, Y), (X, Y1)) :-
    integer(Y),
    (ground(Y1) -> integer(Y1); true),
    succ(Y1, Y).

adj(A,B) :-
    inc_x(A,B).
adj(A,B) :-
    dec_x(A,B).
adj(A,B) :-
    inc_y(A,B).
adj(A,B) :-
    dec_y(A,B).

%%% Here Prolog, this is what you should know. %%%
body_pred(adj/2).
body_pred(in_range/1).

reach_from_scratch :-
    Pos = [
        reach((1,1), (1,2)),
        reach((1,1), (1,3)),
        reach((1,2), (1,3))
    ],

    learn(Pos, []).