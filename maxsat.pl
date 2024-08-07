:- lib(ic).
:- lib(branch_and_bound).
% create_formula(NVars, NClauses, Density, Formula) :-
%    formula(NVars, 1, NClauses, Density, Formula).

% formula(_, C, NClauses, _, []) :-
%    C > NClauses.
% formula(NVars, C, NClauses, Density, [Clause|Formula]) :-
%    C =< NClauses,
%    one_clause(1, NVars, Density, Clause),
%    C1 is C + 1,
%    formula(NVars, C1, NClauses, Density, Formula).

% one_clause(V, NVars, _, []) :-
%    V > NVars.
% one_clause(V, NVars, Density, Clause) :-
%    V =< NVars,
%    rand(1, 100, Rand1),
%    (Rand1 < Density ->
%       (rand(1, 100, Rand2),
%        (Rand2 < 50 ->
%         Literal is V ;
%         Literal is -V),
%        Clause = [Literal|NewClause]) ;
%       Clause = NewClause),
%    V1 is V + 1,
%    one_clause(V1, NVars, Density, NewClause).

% rand(N1, N2, R) :-
%    random(R1),
%    R is R1 mod (N2 - N1 + 1) + N1.

maxsat(NV,NC,D, F, S,MN):-
     create_formula(NV, NC,D, F),see_f(F,F1),length(F1,N),see_true_false(NV,N,F1,S,M),MN#= N-M,!.

see_true_false(NV,NC,F,TF,NEWMAX):-
length(TF,NV),TF#:: [0,1],check_and(F,NC,TF,NEWMAX),bb_min(search(TF,0,input_order,indomain,complete,[]),NEWMAX,_).


plus_all([X],X).
plus_all([X|L],W):-W#=X+A ,plus_all(L,A).


see_f([A],[A]):-
   length(A,N),N#>0,!.

see_f([ ],[ ]):-!.

see_f([A|F],F1):-
   length(A,N),N#=0,
   see_f(F,F1),!.

see_f([A|F],F1):-
   length(A,N),N#>0,
   see_f(F,F2), append([A],F2,F1),!.

check_and([F],N,TF,NEWMAX):-
   check_ors(F,TF,N1),NEWMAX #=(N-N1),print(N1),print(F),print('\n'),!.

check_and([F|NF],N,TF,NEWMAX):-
   check_ors(F,TF,N1), N2 #= (N-N1),print(N1),print(F),print('\n'),
   check_and(NF,N2,TF,NEWMAX).

find_member(A,[N|_],N):- A#=1,!.
find_member(A,[N|_],NR):-
   A#=(-1),NR#=neg(N),!.
find_member(A,[_|TF],Q):-
   A#>1,
   A1 #= A-1,
   find_member(A1,TF,Q).
find_member(A,[_|TF],Q):-
   A#<(-1),
   A1 #= A+1,
   find_member(A1,TF,Q).

   check_ors([A],TF,N):- find_member(A,TF,N),!.

   check_ors([A|C],TF,N):-
   find_member(A,TF,Q),
   check_ors(C,TF,N1),  N#= (N1 or Q).
