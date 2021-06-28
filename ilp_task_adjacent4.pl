%working_directory(Old, 'c:/users/claud/documents/AI & CS/02_Semester/ATAI/Project').
%[hyper, parameters, util_ilp, maze, ilp_task_adjacent4].
%induce(X).

next(X,Y):- 
	size(L),
	member(X, L),
	member(Y, L),
	(Y is X+1; Y is X-1).

adjecent((B,C),(A,C)):- next(B,A).
adjecent((B,C),(B,A)):- next(C,A).
	
% Background literals
backliteral( obstacle(X), [X:cell], []).
backliteral( \+ (G), [X:cell], []) :-
	G = obstacle(X).
backliteral( adjecent(X,Y), [X:cell,Y:cell], []).
 
% Refinement of terms
term( fail, fail, fail).
	
		
% background predicates
prolog_predicate( obstacle(_)).
prolog_predicate( adjecent(_,_)).
prolog_predicate( \+(_)).       


start_clause( [action(X,Y)] / [ X:cell, Y:cell] ).
  
  
% positive and negative examples

ex( action( (2,1), (3,1))). % go left
ex( action( (4,2), (4,1))). % go up
ex( action( (4,3), (5,3))). % go right
ex( action( (5,4), (5,5))). % go down
ex( action( (5,2), (5,3))). % go down
ex( action( (2,5), (3,5))). % go right

nex( action( (1,1), (1,1))). % different cells
%nex( action( (2,1), (2,1))). % different cells
%nex( action( (4,2), (3,1))). % no diagonal cells
%nex( action( (4,2), (5,3))). % no diagonal cells
%nex( action( (4,2), (3,3))). % no diagonal cells
%nex( action( (4,3), (5,2))). % no diagonal cells
%nex( action( (2,1), (4,1))). % no far cells
%nex( action( (4,1), (4,3))). % no far cells
nex( action( (1,1), (1,2))). % no obstacles
nex( action( (2,1), (2,2))). % no obstacles
%nex( action( (1,2), (2,2))). % no obstacles
%nex( action( (4,1), (4,0))). % no out of grid
%nex( action( (5,5), (5,6))). % no out of grid
%nex( action( (5,1), (5,2))). % no obstacles