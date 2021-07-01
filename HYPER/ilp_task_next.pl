%working_directory(Old, 'c:/users/claud/documents/AI & CS/02_Semester/ATAI/Project').
%[hyper, parameters, util_ilp, maze, ilp_task_adjacent6].
%induce(X).
:- use_module(library(lists)).

% learn next (do not consider obstacles)
%next( X, Y):- 
%	size(L),
%	member( X, L),
%	member( Y, L),
%	(Y is X+1; Y is X-1).
	
%succ(X, Y) :- integer(X), Y is X + 1, X >= 0.
%succ(X, Y) :- integer(Y), X is Y - 1, X >= 0.

	
% Background literals
%backliteral( member(X,L), [L:list], [X:item] ).  % Background literal
backliteral( succ( X, Y), [X:item, Y:item], []).
backliteral( \+ (G), [X:item, Y:item], []) :-
	G = succ( X, Y).

 
% Refinement of terms
%term( list, [X|L], [ X:item, L:list]).
%term( list, [], []).
term(fail, fail, fail).
		
% background predicates

%prolog_predicate(member(_,_)).
%prolog_predicate(succ(_,_)).
prolog_predicate( \+(_)). 


start_clause( [next( X, Y)] / [ X:item, Y:item] ).  
  
% positive and negative examples

ex( next( 1,2)).
ex( next( 4,3)).
%ex( next( 4,3)).
%ex( next( 2,1)).
%ex( next( 3,2)).
%ex( next( 4,5)).

nex( next( (2, 4))).
nex( next( (2, 2))). 
nex( next( (5, 2))).
%nex( next( (5, 6))).
%nex( next( (0, 1))).
%nex( next( (1, 1))). 