%working_directory(Old, 'c:/users/claud/documents/AI & CS/02_Semester/ATAI/Project').
%[hyper, parameters, util_ilp, maze, ilp_task_path_maze].
%induce(X).
%max_proof_length( 2).   % Max. proof length, counting calls to preds. in hypothesis
%max_clauses( 2).        % Max. number of clauses in hypothesis (hyper)
%max_clause_length( 3).  % Max. number of literals in a clause

next(X,Y):- 
	size(L),
	member(X, L),
	member(Y, L),
	(Y is X+1; Y is X-1).

adjecent((B,C),(A,C)):- next(B,A).
adjecent((B,C),(B,A)):- next(C,A).

action(A,B):-
  adjecent(B,A),
  \+obstacle(B).

action(A,B):-
  adjecent(A,B),
  \+obstacle(B).
	
% Background literals
backliteral( action(X,Y), [X:cell, Y:cell], []).
backliteral( path(X,Y,L), [ X:cell, Y:cell], [L:list]).
 
% Refinement of terms
term( list, [X|L], [ X:cell, L:list]).
term( list, [], []).
	
		
% background predicates
prolog_predicate( action(_,_)).


start_clause( [ path(X,Y,L)] / [X:cell,Y:cell,L:list] ).    
  
  
% positive and negative examples

ex( path( (4,3), (4,3), [(4,3)])).
ex( path( (1,1), (2,1), [(1,1), (2,1)])). 
ex( path( (3,1), (4,2), [(3,1), (4,1), (4,2)])).
ex( path( (3,3), (3,1), [(3,3), (3,2), (3,1)])).
ex( path( (5,2), (4,5), [(5,2), ( 5, 3), ( 5, 4), (5,5), (4,5)])).
ex( path( (2,3), (4,1), [(2,3), (3,3), (4,3), (4,2), (4,1)])).
ex( path( (3,1), (3,3), [(3,1), (4,1), (4,2), (4,3), (3,3)])).

nex( path( (4,2), (4,2), [])).
nex( path( (4,2), (4,2), [(4,2),(4,2)])).
%nex( path( (1,1), (2,1), [])).
nex( path( (2,3), (2,3), [(1,1)])).
nex( path( (2,3), (2,3), [(1,1), (1,1)])).
nex( path( (3,1), (4,2), [(3,1), (4,2)])).
%nex( path( (3,1), (4,2), [(3,1), (4,1)])). % not good