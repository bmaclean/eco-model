:- [foodchain, population, language].

% Code adapted from David Poole https://www.cs.ubc.ca/~poole/cs312/2018/slides/lect27s.pdf

% DICTIONARY

% Known adjectives:
adjective([herbivore | T],T,Obj) :- herbivore(Obj).
adjective([carnivore | T],T,Obj) :- carnivore(Obj).

% Known nouns:
noun([animal | T],T,Obj) :- animal(Obj).
noun([plant | T],T,Obj) :- plant(Obj).
noun([location | T],T,Obj) :- location(Obj).
noun([X | T],T,X) :- animal(X).
noun([X | T],T,X) :- plant(X).
noun([X | T],T,X) :- location(X).

% Known relations (including verbs, prepositions):
reln([eats | T],T,O1,O2) :- eats(O1,O2).
reln([transfers, energy, to | T],T,O1,O2) :- transfers_energy_to(O1,O2).
reln([lives, in | T],T,O1,O2) :- lives_in(O1,O2).

% question(Query, QR, Obj) is true if some answer exists for the Query given object Obj
question(['Is' | T0],T2,Obj) :-
    noun_phrase(T0,T1,Obj),
    mp(T1,T2,Obj).
question(['What',is, the, Animal, population | _], _, P) :-
    initpopulation(Animal, P).
question(['What',will, be, the, Animal, population, in, T, years | _], _,P) :-
    populationat(Animal, T, P).
question(['What',is | T0], T1, Obj) :-
    mp(T0,T1,Obj).
question(['What',is | T0],T1,Obj) :-
    noun_phrase(T0,T1,Obj).
question(['What' | T0],T2,Obj) :-
    noun_phrase(T0,T1,Obj),
    mp(T1,T2,Obj).

% ask(Q, A) returns the response A to query Q, and false otherwise
ask(Q,A) :-
    question(Q,[],A).

% query(Ans) starts the program, and returns answer Ans if a query result exists,
%   and false otherwise
query(Ans, Resp) :-
    write("Ask me: "), flush_output(current_output),
    readln(Ln),
    setof(Ans, question(Ln,End,Ans), Resp),
    member(End,[[],['?'],['.']]).