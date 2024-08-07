:- lib(ic).
:- lib(ic_global).
% ?- findall((L1, L2), numpart(24, L1, L2), L), length(L, N).
% L1 = L1
% L2 = L2
% L = [([1, 2, 3, 8, 13, 14, 15, 16, 18, 19, 20, 21], [4, 5, 6, 7, 9, 10, 11, 12, 17, 22, 23, 24]),..........]
% N = 296
% Yes (5.23s cpu)
% ?- findall((L1, L2), numpart(28, L1, L2), L), length(L, N).
% L1 = L1
% L2 = L2
% L = [([1, 2, 3, 5, 13, 14, 17, 18, 19, 20, 21, 22, 23, 25], [4, 6, 7, 8, 9, 10, 11, 12, 15, 16, 24, 26, 27, 28]),..........]
% N = 1443
% Yes (64.66s cpu)
% ?- findall((L1, L2), numpart(32, L1, L2), L), length(L, N).
% L1 = L1
% L2 = L2
% L = [([1, 2, 3, 4, 9, 16, 18, 19, 20, 21, 22, 23, 25, 26, 27, 28], [5, 6, 7, 8, 10, 11, 12, 13, 14, 15, 17, 24, 29, 30, 31, 32]),..........]
% N = 17444
% Yes (816.50s cpu)

even(N):- mod(N,2) #= 0.

numpart(N,L1,L2):-
    even(N),
    N1 is N/2,N2 is  round(N1),N3 is integer(N2),
    length(L1,N3),
    L1 #:: 1..N,
    length(L2,N3),
    L2 #:: 2..N,
    find_sum(N,NSUM),
    ordered_my_sum(L1,NSUM),
    find_riza(N,NRIZA),
    square(L1,NR1),
    NRIZA #=NR1,
    ordered(<,L2),
    different(L1,L2),!,
    search(L1,0,input_order,indomain,complete,[]).



square([A],A1):-A1 #= A*A,!.
square([A|B],A1):- square(B,X),
A1 #= X+A*A.


ordered_my_sum(List, Sum) :-
    ordered(<, List),
    sum(List) #= Sum.

find_sum(A,N3):- N is A*(A+1)/4,N2 is  round(N),N3 is integer(N2).
find_riza(A,N3):- N is A*(A+1)*(2*A+1)/12,N2 is  round(N),N3 is integer(N2).


same([N1|L1],[N2]):- N1#\=N2,!.

same([N1|L1], [N2|L2]):-
N1#\=N2,
    same([N1|L1],L2).
same([N1],[N2]):- N1#\=N2,!.

same([N1], [N2|L2]):-
N1#\=N2,
    same([N1],L2).


different([N1],L2):-
    same([N1],L2).

different([N1|L1],L2):-
    same([N1|L1],L2),
    different(L1,L2) .
