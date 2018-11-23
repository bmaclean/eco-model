
% plant(A) defines individual A as a plant
plant(grass).

% animal(A) defines individual A as an animal
animal(lion).
animal(buffalo).
animal(baboon).
animal(mouse).

% location(A) defines location A where animal lives
location(savannah).
location(forest).
location(swamps).

% eats(A, B) defines a relation such that animal A eats individual B
eats(lion, buffalo).
eats(lion, baboon).
eats(baboon, mouse).
eats(mouse, grass).
eats(buffalo, grass).

% lives_in(A, B) defines a relation such that animal A lives in location B
lives_in(lion, savannah).
lives_in(baboon, savannah).
lives_in(mouse, forest).
lives_in(buffalo, swamps).

cohabits(A1, A2) :-
    lives_in(A1, X),
    lives_in(A2, X).

% herbivore(X) returns true if individual X eats only plants
herbivore(X) :-
    eats(X, Y), plant(Y),
    not((eats(X, Z), animal(Z))).

% carnivore(X) returns true if indivual X eats only animals
carnivore(X) :-
    eats(X, Y), animal(Y),
    not((eats(X, Z), plant(Z))).

% property(P, A, V) is some property P of animal A with value V
property(weight, lion, 100).
property(weight, buffalo, 50).
property(weight, monkey, 10).
property(weight, mouse, 1).
property(height, lion, 100).
property(height, buffalo, 50).
property(height, monkey, 10).
property(height, mouse, 1).

% transfers_energy_to(X, Y) is true if energy flows from X to Y in the ecosystem
transfers_energy_to(sun, P) :- plant(P).
transfers_energy_to(X, Y) :-
    plant(X), herbivore(Y),
    dif(X, Y).
transfers_energy_to(X, Y) :-
    animal(X), carnivore(Y),
    dif(X, Y).
