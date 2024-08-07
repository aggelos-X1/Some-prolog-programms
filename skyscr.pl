% skyscr(demo, Solution).
:- lib(ic).
:- lib(ic_global).
:- use_module(library(clpfd)).

% puzzle(demo, 5,
%        [0,2,0,2,4], [4,0,2,0,0],
%        [0,0,0,0,0], [0,3,0,2,0],
%        [[_,_,_,_,_],
%         [_,_,_,_,_],
%         [_,5,_,_,_],
%         [_,_,_,_,_],
%         [_,_,_,_,_]]).

% puzzle(easy4x4, 4,
%        [3,2,1,3], [1,3,3,2],
%        [3,2,2,1], [2,3,1,2],
%        [[_,_,_,_],
%         [_,_,_,_],
%         [_,_,_,_],
%         [_,_,_,_]]).

% puzzle(normal4x4, 4,
%        [0,0,0,0], [3,0,2,0],
%        [0,0,0,0], [0,0,1,2],
%        [[_,_,_,_],
%         [_,_,_,_],
%         [_,_,_,_],
%         [_,_,_,_]]).

% puzzle(hard4x4, 4,
%        [0,2,2,0], [0,0,0,0],
%        [0,0,0,0], [0,2,0,3],
%        [[_,_,2,_],
%         [_,_,_,_],
%         [_,_,4,_],
%         [_,_,_,_]]).

% puzzle(easy5x5, 5,
%        [5,2,2,1,3], [1,4,2,4,2],
%        [4,2,3,2,1], [2,3,1,3,2],
%        [[_,_,_,_,_],
%         [_,_,_,_,_],
%         [_,_,_,_,_],
%         [_,_,_,_,_],
%         [_,_,_,_,_]]).

% puzzle(normal5x5, 5,
%        [0,3,0,0,0], [0,0,0,0,4],
%        [3,2,0,0,0], [0,0,0,5,3],
%        [[_,_,_,_,_],
%         [_,_,_,_,_],
%         [_,_,_,_,_],
%         [_,_,_,_,_],
%         [_,_,_,_,_]]).

% puzzle(hard5x5, 5,
%        [0,2,4,0,0], [0,0,0,3,0],
%        [0,0,2,4,0], [0,3,0,0,0],
%        [[_,_,_,2,_],
%         [_,_,_,_,_],
%         [_,_,_,_,_],
%         [_,_,_,_,_],
%         [_,_,_,_,1]]).

% puzzle(easy6x6, 6,
%        [2,3,3,1,2,3], [1,2,2,4,3,2],
%        [2,4,2,3,2,1], [2,2,2,1,3,3],
%        [[_,_,_,_,4,_],
%         [_,_,_,_,_,_],
%         [_,_,_,_,_,5],
%         [_,_,3,_,_,_],
%         [_,_,_,3,_,_],
%         [3,_,_,_,_,_]]).

% puzzle(normal6x6, 6,
%        [0,4,0,3,0,0], [0,0,0,0,5,0],
%        [3,1,0,3,0,4], [0,0,0,3,4,0],
%        [[_,_,_,_,_,_],
%         [_,_,_,_,_,_],
%         [_,_,_,1,_,_],
%         [_,_,_,_,_,_],
%         [_,_,_,_,_,_],
%         [_,_,2,_,_,_]]).

% puzzle(hard6x6, 6,
%        [4,0,2,0,2,0], [0,3,2,3,0,0],
%        [0,2,2,2,4,0], [0,0,0,4,0,3],
%        [[_,_,_,_,_,_],
%         [_,_,_,_,_,_],
%         [_,_,_,_,_,_],
%         [_,_,3,_,_,_],
%         [_,_,_,_,_,_],
%         [_,_,_,_,_,_]]).

% puzzle(hard7x7, 7,
%        [2,3,0,1,3,2,0], [0,2,0,0,0,0,3],
%        [3,0,3,3,0,0,0], [0,0,2,0,3,0,0],
%        [[_,1,_,_,_,_,_],
%         [_,_,_,_,4,_,_],
%         [_,5,_,_,_,_,_],
%         [_,_,_,_,_,4,_],
%         [_,_,_,_,_,_,_],
%         [_,_,_,_,1,_,_],
%         [_,_,_,5,_,_,_]]).

% puzzle(hard8x8, 8,
%        [3,0,4,2,0,3,3,0], [0,0,3,3,5,3,4,0],
%        [2,0,0,5,3,0,0,0], [3,0,0,0,4,4,0,0],
%        [[_,_,5,_,_,_,_,_],
%         [_,4,3,_,_,_,2,_],
%         [_,_,_,_,_,_,_,1],
%         [_,_,_,_,_,_,_,_],
%         [_,_,_,_,_,5,_,2],
%         [_,_,_,8,_,_,_,_],
%         [_,6,_,_,_,1,4,_],
%         [_,_,_,_,_,_,_,_]]).

% puzzle(hard9x9, 9,
%        [0,0,0,0,1,5,3,0,3], [0,3,3,2,3,0,0,5,0],
%        [2,3,0,0,3,4,2,0,3], [3,0,6,4,3,0,2,2,4],
%        [[_,_,_,_,_,_,_,_,_],
%         [_,1,_,_,_,_,3,_,_],
%         [_,_,_,_,1,2,_,_,5],
%         [_,_,_,4,2,6,_,_,_],
%         [_,_,_,_,_,_,_,1,_],
%         [_,_,7,_,_,8,_,_,_],
%         [_,_,_,_,_,_,_,3,_],
%         [4,_,_,_,_,_,_,_,2],
%         [_,_,_,_,_,9,_,_,_]]).





list_all_different([A]):-
       all_distinct(A).

list_all_different([A|L]):-
        all_distinct(A),
       list_all_different(L).

skyscr(A, Solution):-
       puzzle(A,Num,ADL,ADR,LRA,LRD,S),
       solution(S,Num,ADL,ADR,LRA,LRD,Solution).

reverse_list([A],[AR]):-
       reverse(A,AR).
reverse_list([A|L],[AR|R]):-
       reverse(A,AR),
       reverse_list(L,R).

% print_list([A]):-
% print(A),print('\n NEXT \n').

% print_list([A|L]):-
% print(A),print('\n'),
% print_list(L).


same2([], []).

same2([H1|R1], [H2|R2]):-
    H1 #= H2,
    same2(R1, R2).

same1([], []).

same1([H1|R1], [H2|R2]):-
    same2(H1,H2),
    same1(R1, R2).

solution(S,Num,ADL,ADR,LRA,LRD,SList):-
       create_list(Num,1,SList),
       transpose(SList,USList),
       reverse_list(SList,RSList),
       reverse_list(USList,RUSList),
       list_all_different(SList),
       list_all_different(USList),
       list_all_different(RSList),
       list_all_different(RUSList),
       check_max(SList,ADL),check_max(RSList,ADR),
       check_max(USList,LRA),check_max(RUSList,LRD),
       same1(S,SList),
       search([SList,USList,RSList,RUSList],0,input_order,indomain,complete,[]).

       % print_list(SList),
       % transpose(USList,NUSList),print_list(NUSList),
       % reverse_list(RSList,NRSList),print_list(NRSList),
       % reverse_list(RUSList,NRUSList),transpose(NRUSList,NRUSList2),print_list(NRUSList2).

check_max([A],[Number]):-
       Number#=0.

check_max([A],[Number]):-
      list_max(A,[],MAX),
       nvalue(Number,MAX).

check_max([A|List],[Number|CHECKER]):-
       Number#=0,
       check_max(List,CHECKER).

check_max([A|List],[Number|CHECKER]):-
       list_max(A,[],MAX),nvalue(Number,MAX),
       check_max(List,CHECKER).


create_list(Num,N,[List]):-
       N#=Num,
       length(List,Num),
       List#:: [1 .. Num].

create_list(Num,N,[List|L]):-
       N#<Num,
       length(List,Num),
       List#:: [1 .. Num],N1#=N+1,
       create_list(Num,N1,L).


list_max([A],OML,[N|OML]):-
       ic:maxlist([A|OML],N).

list_max([A|L],OML,NML):-
ic:maxlist([A|OML],N),
   list_max(L,[N|OML], NML).

