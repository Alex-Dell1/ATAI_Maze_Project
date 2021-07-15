/*
    This program is used to learn the predicate move/2. It assumes that
    it is already known how to check whether a cell belongs to a grid.
*/

:- use_module('metagol.pl').

metagol:max_clauses(5).

%%% METARULES %%%
metarule(ident, [P,Q], [P,A,B], [[Q,A,B]]). % Identity
metarule(postcon, [P,Q,R], [P,A,B], [[Q,A,B], [R,B]]). % Postcondition
metarule(i_postcon, [P,Q,R], [P,A,B], [[R,B], [Q,A,B]]). % Inverted postcondition

%%% BACKGROUND KNOWLEDGE %%%
width(5).
height(5).

obstacle((1,2)).
obstacle((2,2)).
obstacle((3,2)).
obstacle((4,4)).
obstacle((3,4)).
obstacle((2,4)).
obstacle((1,4)).
obstacle((1,5)).
obstacle((5,1)).

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

is_free((X, Y)) :-
    \+ obstacle((X, Y)).

% A position is legal if it's in bounds and does not have an obstacle.
legal_position((X, Y)) :-
    in_range((X, Y)),
    is_free((X, Y)).

%%% Here Prolog, this is what you should know. %%%
body_pred(inc_x/2).
body_pred(dec_x/2).
body_pred(inc_y/2).
body_pred(dec_y/2).
body_pred(legal_position/1).

%%% EXAMPLES %%%

learn_to_walk :-
    Pos = [
        move((2,1), (3,1)),
        move((4,2), (4,3)),
        move((3,1), (2,1)),
        move((4,3), (4,2)),
        move((3,1), (4,1)),
        move((5,2), (5,3)),
        move((2,1), (1,1)),
        move((5,3), (5,2))
    ],

    Neg = [
        move((4,1), (5,1)),
        move((3,3), (3,4)),
        move((1,1), (0,1)),
        move((5,2), (5,1))
    ],

    learn(Pos, Neg).