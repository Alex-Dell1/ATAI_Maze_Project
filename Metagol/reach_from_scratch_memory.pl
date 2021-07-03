:- use_module('metagol.pl').

metagol:max_clauses(7).

metarule(ident, [P,Q], [P,A,B], [[Q,A,B]]).
metarule(ident2, [P,Q], [P,A,B,[A,B]], [[Q,A,B]]).
metarule(prepostcon, [P,Q,R], [P,A,B], [[R,B], [Q,A,B]]).
metarule(recursion, [P,Q,R], [P,A,B,[A|L1]], [[R,B], [Q,A,C], [R,C], [P,C,B,L1]]).

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

is_free(A) :-
    \+ obstacle(A).

legal_position(A) :-
    in_range(A),
    is_free(A).

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
    %(ground(X) -> integer(X); true),
    integer(Y),
    (ground(Y1) -> integer(Y1); true),
    succ(Y1, Y).

%%% Here Prolog, this is what you should know. %%%
body_pred(dec_y/2).
body_pred(dec_x/2).
body_pred(inc_y/2).
body_pred(inc_x/2).
body_pred(legal_position/1).

reach(A,B):-legal_position(B),inc_x(A,B).
reach(A,B):-in_range(B),dec_y(A,B).
reach(A,B):-legal_position(B),inc_y(A,C),legal_position(C),reach(C,B).
reach(A,B):-dec_x(A,B).

rfs :-
    Pos = [
        reach((1,1), (2,1), [(1,1), (2,1)]),
        reach((4,4), (4,3), [(4,4), (4,3)]),
        reach((5,2), (5,3), [(5,2), (5,3)]),
        reach((5,5), (4,5), [(5,5), (4,5)]),
        reach((3,1), (4,2), [(3,1), (4,1), (4,2)]),
        reach((3,1), (4,5), [(3,1), (4,1), (4,2), (4,3), (5,3), (5,4), (5,5), (4,5)])
    ],
	Neg = [
        reach((1,1); (1,1), [(1,1)]),
        reach((5,1), (6,1), [(5,1), (6,1)]),
        reach((1,1), (1,0), [(1,1), (1,0)]),
        reach((5,5), (5,6), [(5,5), (5,6)]),
        reach((1,1), (1,2), [(1,1), (1,2)]),
        reach((4,1), (5,1), [(4,1), (5,1)]),
        reach((4,2), (3,2), [(4,2), (3,2)]),
        reach((5,2), (5,1), [(5,2), (5,1)])
    ],
    learn(Pos, Neg).
