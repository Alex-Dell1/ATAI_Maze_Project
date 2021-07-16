%working_directory(Old, 'c:/users/claud/documents/AI & CS/02_Semester/ATAI/Project/HYPER').
%[hyper, parameters, util_ilp, maze, ilp_task_move_reach].
%induce(X), show_hyp(X).
%max_proof_length( 7).   % Max. proof length, counting calls to preds. in hypothesis
%max_clauses( 4).        % Max. number of clauses in hypothesis (hyper)
%max_clause_length( 3).  % Max. number of literals in a clause

%learn move and reach at once

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
backliteral( move(X,Y), [X:cell], [Y:cell]).
backliteral( reach(X,Y,L), [X:cell,L:list], [Y:cell]).
 
% Refinement of terms
term( list1, [X|L], [ X:cell, L:list]).
term( list1, [X], [X:cell]).
	
		
% background predicates
prolog_predicate( obstacle(_)).
prolog_predicate( adjacent(_,_)).
prolog_predicate( \+(_)).       


start_clause( [move(X,Y)] / [ X:cell, Y:cell] ).
start_clause( [ reach(X,Y,L)] / [X:cell,Y:cell,L:list1] ).   
  
  
% positive and negative examples

ex( move( (2,1), (3,1))). % go left
nex( move( (2,1), (2,2))). % no obstacles

%ex( reach( (1,1), (1,1), [(1,1)])). -> no effect
ex( reach( (1,1), (2,1), [(1,1), (2,1)])). 
ex( reach( (3,1), (4,2), [(3,1), (4,1), (4,2)])).

nex( reach( (1,1), (4,1), [(1,1), (2,1), (3,1), (4,3)])).
nex( reach( (2,3), (2,3), [(1,1)])).
nex( reach( (2,1), (3,3), [(2,1), (2,2), (2,3),(2,2)])).
nex( reach( (3,1), (4,2), [(3,1), (4,1), (3,1)])).
%nex( reach( (4,2), (4,2), [])). % -> decreases number of hypotheses generated slightly
nex( reach( (2,1), (3,3), [(2,2), (2,3), (3,3)])). % -> increases number of hypotheses significantly when both neg. examples are added!




