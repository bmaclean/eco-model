
% plant(A) defines individual A as a plant
plant(grass).

% animal(A) defines individual A as an animal
animal(lion).
animal(buffalo).
animal(baboon).
animal(mouse).

% eats(A, B) defines a relation such that animal A eats individual B
eats(lion, buffalo).
eats(lion, baboon).
eats(baboon, mouse).
eats(mouse, grass).
eats(buffalo, grass).

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

% energyflow(X, Y) is true if energy flows from X to Y in the ecosystem
energyflow(sun, P) :- plant(P).
energyflow(X, Y) :-
    plant(X), herbivore(Y),
    dif(X, Y).
energyflow(X, Y) :-
    animal(X), carnivore(Y),
    dif(X, Y).
