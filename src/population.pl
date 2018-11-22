
% initpopulation(X, P) defines the initial population P of species X
initpopulation(lion, 120).

% growthrate(X, R) defines the growth rate R of species X
growthrate(lion, 1.3).

% populationat(S, T) is the population of species S after time period T
populationat(S, T, P) :-
    growthrate(S, R),
    initpopulation(S, I),
    P is (I*exp(T*R)).
