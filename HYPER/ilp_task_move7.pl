%working_directory(Old, 'c:/users/claud/documents/AI & CS/02_Semester/ATAI/Project/HYPER').
%[hyper, parameters, util_ilp, maze7, ilp_task_move7].
%induce(X).
%max_proof_length( 2).   % Max. proof length, counting calls to preds. in hypothesis
%max_clauses( 2).        % Max. number of clauses in hypothesis (hyper)
%max_clause_length( 3).  % Max. number of literals in a clause

next(X,Y):- 
	size(L),
	member(X, L),
	member(Y, L),
	(Y is X+1; Y is X-1).

adjacent((B,C),(A,C)):- next(B,A).
adjacent((B,C),(B,A)):- next(C,A).
	
% Background literals
backliteral( obstacle(X), [X:cell], []).
backliteral( \+ (G), [X:cell], []) :-
	G = obstacle(X).
backliteral( adjacent(X,Y), [X:cell,Y:cell], []).
 
% Refinement of terms
term( fail, fail, fail).
	
		
% background predicates
prolog_predicate( obstacle(_)).
prolog_predicate( adjacent(_,_)).
prolog_predicate( \+(_)).       


start_clause( [move(X,Y)] / [ X:cell, Y:cell] ).
  
  
% positive and negative examples

ex( move( (2,1), (3,1))). % go left
%ex( move( (4,2), (4,1))). % go up
%ex( move( (4,3), (5,3))). % go right
%ex( move( (5,4), (5,5))). % go down


%nex( move( (1,1), (1,1))). % different cells
%nex( move( (1,2), (1,2))). % different cells
%nex( move( (1,1), (1,2))). % no obstacles
nex( move( (2,1), (2,2))). % no obstacles
