/*
    This program is used to learn the predicate move/2. It assumes that
    it is already known how to check whether a cell belongs to a grid.
*/

:- use_module('metagol.pl').

metagol:max_clauses(5).

%%% METARULES %%%
metarule(ident, [P,Q], [P,A,B], [[Q,A,B]]). % Identity
%metarule(postcon, [P,Q,R], [P,A,B], [[Q,A,B], [R,B]]). % Postcondition
metarule(i_postcon, [P,Q,R], [P,A,B], [[R,B], [Q,A,B]]). % Inverted postcondition

%%% BACKGROUND KNOWLEDGE %%%
width(5).
height(5).


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



%%% Here Prolog, this is what you should know. %%%
body_pred(inc_x/2).
body_pred(dec_x/2).
body_pred(inc_y/2).
body_pred(dec_y/2).
body_pred(in_range/1).

%%% EXAMPLES %%%

learn :-
    Pos = [
        move((2,1), (3,1)),
        move((4,2), (4,3)),
        move((3,1), (2,1)),
        move((4,3), (4,2))
    ],

    Neg = [
        move((5,1), (6,1)),
        move((3,5), (3,6)),
        move((1,1), (0,1)),
        move((4,1), (4,0))
    ],

    learn(Pos, Neg).
