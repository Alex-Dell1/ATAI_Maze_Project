%working_directory(Old, 'c:/users/claud/documents/AI & CS/02_Semester/ATAI/Project/HYPER').
%[hyper, parameters, util_ilp, maze, ilp_task_move].
%induce(X).
%max_proof_length( 2).   % Max. proof length, counting calls to preds. in hypothesis
%max_clauses( 2).        % Max. number of clauses in hypothesis (hyper)
%max_clause_length( 3).  % Max. number of literals in a clause

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

ex( move( (2,1), (1,1))). % go left
%ex( move( (4,2), (4,1))). % go up -> makes no difference
%ex( move( (4,3), (5,3))). % go right -> makes no difference
%ex( move( (5,4), (5,5))). % go down -> makes no difference
%ex( move( (3,3), (4,3))). % go right -> makes no difference
%ex( move( (5,5), (5,4))). % go up -> makes no difference
%ex( move( (4,3), (3,3))). % go left -> makes no difference
%ex( move( (5,3), (5,4))). % go down -> makes no difference

%nex( move( (1,1), (1,1))). % different cells -> makes no difference
%nex( move( (1,2), (1,2))). % different cells -> makes no difference
nex( move( (1,1), (1,2))). % no move into obstacles
%nex( move( (2,1), (2,2))). % no obstacles -> makes no difference
%nex( move( (4,3), (4,4))). % no obstacles -> makes no difference

