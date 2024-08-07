:- lib(ic).
:- lib(ic_global).
:- use_module(library(clpfd)).

% ASP,Assignment den bgazei ta sosta apotelesmata dioti den prolabena na sinexiso thn askisi logo exetastikis
assignment_csp(NPersons,NHours,PALL,N):-
    activitys_differnt(XL,DI),length(DI,Z),
    create_persons(XL,1,NPersons,NHours,DI,[0],PALL),
    check_double_list(PALL,0,N).


check_list([_],N,Z):-
    Z#=N+1.

check_list([_|P],N,Z):-
    NA#=1+N,
    check_list(P,NA,Z).

check_double_list([A],N,Z):-
    check_list(A,0,NA),
    Z#=NA+N.

check_double_list([A|P],N,Z):-
    check_list(A,0,NA),
    NAN#=NA+N,
    check_double_list(P,NAN,Z).



check_double([A-B],[A-B]).

check_double([A-B|L],[A-B|L1]):-
    \+member(B-A,L),
    check_double(L,L1).

check_double([A-B|L],[A-B]):-
    member(B-A,L),
    delete(B-A,L,NL),NL=[].

check_double([A-B|L],[A-B|L1]):-
    member(B-A,L),
    delete(B-A,L,NL),
    check_double(NL,L1).



acti(ACLIST2,ACLIST,LA):-
findall(ACLIST1,activity(_,act(_,ACLIST1)),ACLIST),
findall(ACLIST1,activity(_,act(ACLIST1,_)),ACLIST2),
findall(Q,(activity(_,act(AC1,AC2)),Q #:: AC2-AC1),LA).

checkone_to_all(A1,B1,[A],[B],[I2],I,L):-
    checkone(A1,B1,A,B,I,I2,L),!.
checkone_to_all(A1,B1,[A],[B],[I2],I,[]):-
    \+checkone(A1,B1,A,B,I,I2,L),!.

checkone_to_all(A1,B1,[A|AZ],[B|BZ],[I2|IL],I,NL):-
    checkone(A1,B1,A,B,I,I2,L),
    checkone_to_all(A1,B1,AZ,BZ,IL,I,OL),append(L,OL,NL),!.

checkone_to_all(A1,B1,[A|AZ],[B|BZ],[I2|IL],I,OL):-
    \+checkone(A1,B1,A,B,I,I2,L),
    checkone_to_all(A1,B1,AZ,BZ,IL,I,OL),!.

checkall(A1,B1,[A],[B],[I1],I2,L):-
    checkone_to_all(A,B,A1,B1,I2,I1,L).


checkall(A1,B1,[A|AZ],[B|BZ],[I1|I],I2,NL):-
    checkone_to_all(A,B,A1,B1,I2,I1,L),
    checkall(A1,B1,AZ,BZ,I,I2,OL),
    append(L,OL,NL).

checkone(A1,B1,A,B,I1,I2,[I1-I2]):-
    (A1#\=A ; B1#\=B),
    ((A1#=B) ; (B1#=A);
    (A1#=<A,B1#>A);(A1#<A,B1#>=A);(A1#<B,B1#>=B)).


all_cost([A],A).

all_cost([A|L],N):-
    N#=OLDN+A,all_cost(L,OLDN).

see_cost(P,C,CF):-
    element(I1,P,P1), element(I2,C,C1),
    P1#=I2,findall(C1,search([P1,C1],0,input_order,indomain,complete,[]),CALL),all_cost(CALL,CF).

create_persons(Anot,N,NPersons,NHours,COST,PRV,[PA1]):-
    N#=NPersons,
    create_person(Anot,NHours,PRV,COST,PA1).

create_persons(Anot,N,NPersons,NHours,COST,PRV,PALL):-
    N#<NPersons,
    create_person(Anot,NHours,PRV,COST,PA1),
    N1#=N+1,
    append(PA1,PRV,PRVN),
    create_persons(Anot,N1,NPersons,NHours,COST,PRVN,POLD),
    append([PA1],POLD,PALL).


create_person(Anot,NHours,PRV,COST,PA1):-
    length(P1,15),
    P1#::1 .. 15,ordered(<,P1),
    delete_many(P1,PRV,P1N),
    letcheck(Anot,P1N,PA1),
    see_cost(PA1,COST,CF),
    CF#=<NHours.



delete_many(P,[A],P):-
    A#=0.
delete_many(P,[A],PN):-
    delete(A,P,PN).

delete_many(P,[A|PRV],PN):-
    A#=0,
    delete_many(P,PRV,PN).

delete_many(P,[A|PRV],PN):-
    delete(A,P,P1),
    delete_many(P1,PRV,PN).



letcheck([A-B],P,W):-
    check2(A,B,P,W).

letcheck([A-B|L],P,WN):-
    check2(A,B,P,W),
    letcheck(L,W,WN).

check2(A,B,P1,WL):-
    member(A,P1),
    element(I1,P1,W),
    ( W#\=B),findall(W,search([W],0,input_order,indomain,complete,[]),WL).

check2(A,B,P1,WL):-
    member(B,P1),
    element(I1,P1,W),
    (W#\=A),findall(W,search([W],0,input_order,indomain,complete,[]),WL).

check2(A,B,P1,P1):-
    \+member(B,P1),\+member(A,P1).


activitys_differnt(NXL,DI) :-
    acti(A,B,DI),element(I,A,X1),
    element(J,B,X2),element(JI,DI,X12),I#=J,I#=JI,
    findall(X1,search([X1,X2,X12,I],0,input_order,indomain,complete,[]),L1),
    findall(X2,search([X1,X2,X12,I],0,input_order,indomain,complete,[]),L2),
    findall(I,search([I,X1,X2,X12],0,input_order,indomain,complete,[]),L4),
    findall(X12,search([X12,X1,X2,I],0,input_order,indomain,complete,[]),L3),
    checkall(L1,L2,L1,L2,L4,L4,XL),check_double(XL,NXL).



activity(a01, act(0,3)).
activity(a02, act(0,4)).
activity(a03, act(1,5)).
activity(a04, act(4,6)).
activity(a05, act(6,8)).
activity(a06, act(6,9)).
activity(a07, act(9,10)).
activity(a08, act(9,13)).
activity(a09, act(11,14)).
activity(a10, act(12,15)).
activity(a11, act(14,17)).
activity(a12, act(16,18)).
activity(a13, act(17,19)).
activity(a14, act(18,20)).
activity(a15, act(19,20)).


% activity(a001, act(41,49)).
% activity(a002, act(72,73)).
% activity(a003, act(80,85)).
% activity(a004, act(65,74)).
% activity(a005, act(96,101)).
% activity(a006, act(49,55)).
% activity(a007, act(51,59)).
% activity(a008, act(63,65)).
% activity(a009, act(66,69)).
% activity(a010, act(80,87)).
% activity(a011, act(71,76)).
% activity(a012, act(64,68)).
% activity(a013, act(90,93)).
% activity(a014, act(49,56)).
% activity(a015, act(23,29)).
% activity(a016, act(94,101)).
% activity(a017, act(25,34)).
% activity(a018, act(51,54)).
% activity(a019, act(13,23)).
% activity(a020, act(67,72)).
% activity(a021, act(19,21)).
% activity(a022, act(12,16)).
% activity(a023, act(99,104)).
% activity(a024, act(92,94)).
% activity(a025, act(74,83)).
% activity(a026, act(95,100)).
% activity(a027, act(39,47)).
% activity(a028, act(39,49)).
% activity(a029, act(37,39)).
% activity(a030, act(57,66)).
% activity(a031, act(95,101)).
% activity(a032, act(71,74)).
% activity(a033, act(86,93)).
% activity(a034, act(51,54)).
% activity(a035, act(74,83)).
% activity(a036, act(75,81)).
% activity(a037, act(33,43)).
% activity(a038, act(29,30)).
% activity(a039, act(58,60)).
% activity(a040, act(52,61)).
% activity(a041, act(35,39)).
% activity(a042, act(46,51)).
% activity(a043, act(71,72)).
% activity(a044, act(17,24)).
% activity(a045, act(94,103)).
% activity(a046, act(77,87)).
% activity(a047, act(83,87)).
% activity(a048, act(83,92)).
% activity(a049, act(59,62)).
% activity(a050, act(2,4)).
% activity(a051, act(86,92)).
% activity(a052, act(94,103)).
% activity(a053, act(80,81)).
% activity(a054, act(39,46)).
% activity(a055, act(60,67)).
% activity(a056, act(72,78)).
% activity(a057, act(58,61)).
% activity(a058, act(8,18)).
% activity(a059, act(12,16)).
% activity(a060, act(47,50)).
% activity(a061, act(49,50)).
% activity(a062, act(71,78)).
% activity(a063, act(34,42)).
% activity(a064, act(21,26)).
% activity(a065, act(92,95)).
% activity(a066, act(80,81)).
% activity(a067, act(74,79)).
% activity(a068, act(28,29)).
% activity(a069, act(100,102)).
% activity(a070, act(29,37)).
% activity(a071, act(4,12)).
% activity(a072, act(79,83)).
% activity(a073, act(98,108)).
% activity(a074, act(91,100)).
% activity(a075, act(82,91)).
% activity(a076, act(59,66)).
% activity(a077, act(34,35)).
% activity(a078, act(51,60)).
% activity(a079, act(92,94)).
% activity(a080, act(77,83)).
% activity(a081, act(38,48)).
% activity(a082, act(51,59)).
% activity(a083, act(35,39)).
% activity(a084, act(22,24)).
% activity(a085, act(67,68)).
% activity(a086, act(90,97)).
% activity(a087, act(82,83)).
% activity(a088, act(51,53)).
% activity(a089, act(78,88)).
% activity(a090, act(74,79)).
% activity(a091, act(100,105)).
% activity(a092, act(53,63)).
% activity(a093, act(57,66)).
% activity(a094, act(32,41)).
% activity(a095, act(48,56)).
% activity(a096, act(92,96)).
% activity(a097, act(4,8)).
% activity(a098, act(31,33)).
% activity(a099, act(69,77)).
% activity(a100, act(88,93)).
