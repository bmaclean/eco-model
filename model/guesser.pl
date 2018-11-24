:- [foodchain, population, language, add].

% Begin guessing game, undo purges previous entries.

go :- guess(Animal),
      write('I guess that the animal is: '),
      write(Animal),
      nl,
      undo.
	  
guess(monkey)    :- monkey, !.
guess(cheetah)   :- cheetah, !.
guess(tiger)     :- tiger, !.
guess(emu)       :- ostrich, !.
guess(penguin)   :- penguin, !.
guess(unknown).            


monkey  :- herbivore,
			mammal.
cheetah :- mammal, 
           carnivore, 
           verify(have_dark_spots).
tiger   :- mammal,  
         carnivore,
         verify(have_black_stripes).
emu     :- bird,  
           verify(not_fly), 
           verify(has_long_neck).
penguin :- bird, 
           verify(not_fly), 
           verify(swims),
           verify(black_and_white).
herbivore :- verify(eat_plants). 
mammal    :- verify(have_hair), !.
bird      :- verify(have_feathers), !.
bird      :- verify(flys), 
             verify(lays_eggs).

carnivore :- verify(eat_meat), !.
carnivore :- verify(have_pointed_teeth), 
             verify(have_claws).



ask(Question) :-
    write('Does the animal: '),
    write(Question),
    write('? '),
    read(Response),
    nl,
    ( (Response == yes ; Response == y)
      ->
       assert(yes(Question)) ;
       assert(no(Question)), fail).

:- dynamic yes/1,no/1.


verify(S) :-
   (yes(S) 
    ->
    true ;
    (no(S)
     ->
     fail ;
     ask(S))).

undo :- retract(yes(_)),fail. 
undo :- retract(no(_)),fail.
undo.