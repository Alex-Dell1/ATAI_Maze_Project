/*
    This program learns the reach/3 predicate. Which given two cells A, B in the Maze
    checks whether, B is reachable from A. It also stores the path in a list.
*/

:- use_module('metagol.pl').

metagol:max_clauses(6).

%%% METARULES %%%

metarule(start, [P,Q], [P,A,B,L], [[Q,A,B,[A],L]]).
metarule(rec2, [P,Q,R], [P,A,B,Acc,L], [[Q,A,C], [R,C,Acc], [P,C,B,[C|Acc],L]]).
metarule(ident, [P,Q], [P,A,B], [[Q,A,B]]).

%What I want
reach(A,B,L) :- reach_1(A,B,[A],L).
reach_1(A,A,L,L).
reach_1(A,B,Acc,L) :-
    move(A,C),
    non_member(C,Acc),
    reach_1(C,B,[C|Acc],L).

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

start(1,1).
goal(2,5).

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

non_member(X,L) :-
    \+ member(X,L).

% A position is legal if it's in bounds and does not have an obstacle.
legal_position((X, Y)) :-
    in_range((X, Y)),
    is_free((X, Y)).


% BK previously learned from 'learning_to_walk.pl'.
move(A,B):-
    move_1(A,B),
    legal_position(B).

move_1(A,B):-
    inc_x(A,B).
move_1(A,B):-
    inc_y(A,B).
move_1(A,B):-
    dec_x(A,B).
move_1(A,B):-
    dec_y(A,B).

%%% Here Prolog, this is what you should know. %%%
body_pred(move/2).
body_pred(non_member/2).

%%% EXAMPLES %%%

lttm :-
    Pos = [
        reach((1,1), (2,1), [(2,1), (1,1)])
        %reach((1,1), (3,1), [(3,1), (2,1), (1,1)])
        %reach((1,1), (5,5), [(1,1), (2,1), (3,1), (4,1), (4,2), (5,2), (5,3), (5,4), (5,5)])
    ],

    Neg = [
        reach((1,1), (3,1), [(3,1), (2,1), (1,1), (2,1), (3,1)])
    ],

    learn(Pos, Neg).