:- dynamic initpopulation/2, growthrate/2.
% initpopulation(X, P) defines the initial population P of species X
initpopulation(lion, 120).
initpopulation(buffalo, 1030).
initpopulation(baboon, 200).
initpopulation(mouse, 2000).

% growthrate(X, R) defines the growth rate R of species X
%   a negative growth rate indicates a reducing population
growthrate(lion, 0.04).
growthrate(buffalo, -0.02).
growthrate(baboon, 0.14).
growthrate(mouse, 0.02).

% extinct(S, T) is true if species S has gone extinct at time T
extinct(S, T) :-
    % TODO: arguments not sufficiently instantiated
    populationat(S, T, 0).

% populationat(S, T) is the population of species S after time period T
%   equation is based on Malthusian growth model, P(t) = Pi*e^(rt)
%   population at current point in time can be found with T = 0
populationat(S, T, P) :-
    growthrate(S, R),
    initpopulation(S, I),
    P is I*exp(T*R).
