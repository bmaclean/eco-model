
% plant(A) defines individual A as a plant
plant(grass).

% animal(A) defines individual A as an animal
animal(lion).
animal(buffalo).
animal(monkey).
animal(mouse).

% eats(A, B) defines a relation such that animal A eats individual B
eats(lion, buffalo).
eats(lion, monkey).
eats(monkey, mouse).
eats(mouse, grass).
eats(buffalo, grass).

% property(P, A, V) is some property P of animal A with value V
% property(weight, lion, 100).


% herbivore(X) returns true if individual X eats only plants
herbivore(X) :-
    eats(X, Y), plant(Y),
    not((eats(X, Z), animal(Z))).

% carnivore(X) returns true if indivual X eats only animals
carnivore(X) :-
    eats(X, Y), animal(Y),
    not((eats(X, Z), plant(Z))).
