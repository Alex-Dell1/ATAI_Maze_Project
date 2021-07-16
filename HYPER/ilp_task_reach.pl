%working_directory(Old, 'c:/users/claud/documents/AI & CS/02_Semester/ATAI/Project/HYPER').
%[hyper, parameters, util_ilp, maze, ilp_task_reach].
%induce(X).
%max_proof_length( 5).   % Max. proof length, counting calls to preds. in hypothesis
%max_clauses( 2).        % Max. number of clauses in hypothesis (hyper)
%max_clause_length( 3).  % Max. number of literals in a clause

next(X,Y):- 
	size(L),
	member(X, L),
	member(Y, L),
	(Y is X+1; Y is X-1).

adjacent((B,C),(A,C)):- next(B,A).
adjacent((B,C),(B,A)):- next(C,A).

move(A,B):-
  adjacent(B,A),
  \+obstacle(B).

move(A,B):-
  adjacent(A,B),
  \+obstacle(B).

	
% Background literals
backliteral( move(X,Y), [X:cell], [Y:cell]).
backliteral( reach(X,Y,L), [X:cell,L:list], [Y:cell]).
 
% Refinement of terms
term( list1, [X|L], [ X:cell, L:list]).
term( list1, [X], [X:cell]).
	
% background predicates
prolog_predicate( move(_,_)).


start_clause( [ reach(X,Y,L)] / [X:cell,Y:cell,L:list1] ).    
  
%reach(A,A,[A]).
%reach(A,B,[A|L]) :- move(A,C), reach(C,B,L).
  
% positive and negative examples

%ex( reach( (1,1), (1,1), [(1,1)])). % -> useless
ex( reach( (1,1), (2,1), [(1,1), (2,1)])). % -> not necessary, reduces the number of hypotheses refined
ex( reach( (3,1), (4,2), [(3,1), (4,1), (4,2)])).
%ex( reach( (4,1), (5,3), [(4,1), (4,2), (5,2), (5,3)])). % -> useless
%ex( reach( (4,1), (5,3), [(4,1), (4,2), (4,3), (5,3)])). % -> useless

%nex( reach( (4,2), (4,2), [])). % -> useless
nex( reach( (1,1), (4,1), [(1,1), (2,1), (3,1), (4,3)])).
nex( reach( (2,3), (2,3), [(1,1)])).
nex( reach( (2,1), (3,3), [(2,1), (2,2), (2,3),(2,2)])).
nex( reach( (3,1), (4,2), [(3,1), (4,1), (3,1)])).
%nex( reach( (4,1), (4,1), [(2,1)])). % -> no change
%nex( reach( (4,2), (4,5), [(4,2), (4,3), (4,4),(4,5)])). % -> no change
%nex( reach( (2,1), (3,3), [(2,2), (2,3), (3,3)])). % -> no change