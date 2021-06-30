%working_directory(Old, 'c:/users/claud/documents/AI & CS/02_Semester/ATAI/Project').
%[hyper, parameters, util_ilp, maze, ilp_task_adjacent].
%induce(X).
%Use the following parameter settings:
%max_proof_length( 2).   % Max. proof length, counting calls to preds. in hypothesis
%max_clauses( 2).        % Max. number of clauses in hypothesis (hyper)
%max_clause_length( 3).  % Max. number of literals in a clause

next( X, Y):- 
	size(L),
	member( X, L),
	member( Y, L),
	(Y is X+1; Y is X-1).
	
% learn adjecent (do not consider obstacles yet)
%adjecent((B,C),(A,C)):- next(B,A).
%adjecent((B,C),(B,A)):- next(C,A).


	
% Background literals
backliteral( next( X, Y), [X:integer], [Y:integer]).
 
% Refinement of terms
term( cell, (A, B), [A:integer, B:integer]).
		
% background predicates
prolog_predicate(next(_,_)).
  

start_clause( [adjecent( X, Y)] / [ X:cell, Y:cell] ).  
  
% positive and negative examples

ex( adjecent( (3,3), (2,3))). % go left
ex( adjecent( (3,3), (3,2))). % go up
ex( adjecent( (3,3), (4,3))). % go right
ex( adjecent( (1,3), (1,4))). % go down
ex( adjecent( (1,1), (1,2))). 
ex( adjecent( (1,1), (2,1))). 


%nex( adjecent( (1,1), (1,1))). % different cells -> no: runs forever
%nex( adjecent( (3,3), (3,3))). % different cells -> no: runs forever
nex( adjecent( (3,3), (2,4))). % no diagonal cells
nex( adjecent( (2,3), (1,4))). % no diagonal cells
nex( adjecent( (3,4), (4,2))). % no diagonal cells
nex( adjecent( (3,3), (5,3))). % no far cells
nex( adjecent( (3,3), (3,1))). % no far cells

