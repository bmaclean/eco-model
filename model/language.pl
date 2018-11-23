:- [foodchain, population].

% noun_phrase(T0,T4,Ind) is true if
%  T0 and T4 are list of words, such that
%        T4 is an ending of T0
%        the words in T0 before T4 (written T0-T4) form a noun phrase
%  Ind is an individual that the noun phrase is referring to

% A noun phrase is an article followed by adjectives followed
% by a noun followed by an optional modifying phrase:
noun_phrase(T0,T4,Ind) :-
    article(T0,T1,Ind),
    adjectives(T1,T2,Ind),
    noun(T2,T3,Ind),
    mp(T3,T4,Ind).

% Determiners (articles) are ignored in this oversimplified example.
% They do not provide any extra constraints.
article([the | T],T,_).
article([a | T],T,_).
article([an | T],T,_).
article(T,T,_).

% adjectives(T0,T1,Ind) is true if 
% T0-T1 is an adjective is true of Ind
adjectives(T0,T2,Ind) :-
    adj(T0,T1,Ind),
    adjectives(T1,T2,Ind).
adjectives(T,T,_).

% An optional modifying phrase / relative clause is either
% a relation (verb or preposition) followed by a noun_phrase or
% 'that' followed by a relation then a noun_phrase or
% nothing 
mp(T0,T2,Subject) :-
    reln(T0,T1,Subject,Object),
    noun_phrase(T1,T2,Object).
mp([that|T0],T2,Subject) :-
    reln(T0,T1,Subject,Object),
    noun_phrase(T1,T2,Object).
mp(T,T,_).

% DICTIONARY

adj([herbivore | T],T,Obj) :- herbivore(Obj).
adj([carnivore | T],T,Obj) :- carnivore(Obj).

noun([animal | T],T,Obj) :- animal(Obj).
noun([plant | T],T,Obj) :- plant(Obj).
noun([X | T],T,X) :- animal(X).
noun([X | T],T,X) :- plant(X).

reln([eats | T],T,O1,O2) :- eats(O1,O2).
reln([population, of | T], T, P, Animal) :-  initpopulation(Animal, P).

% question(Question,QR,Object) is true if Query provides an answer about Object to Question
question(['Is' | T0],T2,Obj) :-
    noun_phrase(T0,T1,Obj),
    mp(T1,T2,Obj).
question(['What',is, the, Animal, population | _],_,P) :-
    initpopulation(Animal, P).
question(['What',will, be, the, Animal, population, in, T, years | _],_,P) :-
    populationat(Animal, T, P).
question(['What',is | T0], T1, Obj) :-
    mp(T0,T1,Obj).
question(['What',is | T0],T1,Obj) :-
    noun_phrase(T0,T1,Obj).
question(['What' | T0],T2,Obj) :-
    noun_phrase(T0,T1,Obj),
    mp(T1,T2,Obj).

% ask(Q,A) gives answer A to question Q
ask(Q,A) :-
    question(Q,[],A).

q(Ans) :-
    write("Ask me: "), flush_output(current_output),
    readln(Ln),
    question(Ln,End,Ans),
    member(End,[[],['?'],['.']]).