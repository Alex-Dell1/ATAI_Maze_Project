%working_directory(Old, 'c:/users/claud/documents/AI & CS/02_Semester/ATAI/Project/HYPER').
%[hyper, parameters, util_ilp, maze, ilp_task_adjacent].
%induce(X), show_hyp(X).
%Use the following parameter settings:
%max_proof_length( 2).   % Max. proof length, counting calls to preds. in hypothesis
%max_clauses( 2).        % Max. number of clauses in hypothesis (hyper)
%max_clause_length( 3).  % Max. number of literals in a clause

next( X, Y):- 
	size(L),
	member( X, L),
	member( Y, L),
	(Y is X+1; Y is X-1).
	
% learn adjacent (do not consider obstacles yet)
% adjacent((B,C),(A,C)):- next(B,A).
% adjacent((B,C),(B,A)):- next(C,A).


% Background literals
backliteral( next( X, Y), [X:integer], [Y:integer]).
 
% Refinement of terms
term( cell, (A, B), [A:integer, B:integer]).
		
% background predicates
prolog_predicate(next(_,_)).  

start_clause( [adjacent( X, Y)] / [ X:cell, Y:cell] ).  
  
% positive and negative examples

ex( adjacent( (3,3), (2,3))). % go left
ex( adjacent( (4,5), (4,4))). % go up
ex( adjacent( (3,1), (4,1))). % go right
ex( adjacent( (1,3), (1,4))). % go down
%ex( adjacent( (4,3), (3,3))). % go left
%ex( adjacent( (1,5), (1,4))). % go up
%ex( adjacent( (3,2), (4,2))). % go right
%ex( adjacent( (2,2), (2,3))). % go down


nex( adjacent( (1,2), (1,2))). % different cells -> no: runtime increases
%nex( adjacent( (3,3), (3,3))). % different cells -> no: runtime increases
nex( adjacent( (3,3), (2,4))). % no diagonal cells
nex( adjacent( (3,3), (5,3))). % no far cells
nex( adjacent( (3,3), (3,1))). % no far cells
%nex( adjacent( (3,3), (4,4))). % no diagonal cells -> no: runtime increases
%nex( adjacent( (4,2), (4,1))). % no diagonal cells -> no: runtime further increases
%nex( adjacent( (1,2), (4,3))). % no far cells -> no: runs very long with too many negative examples
%nex( adjacent( (2,3), (1,1))). % no far cells -> no: runs very long with too many negative examples

