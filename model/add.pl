:- [foodchain, population, language].

% add animal to the database.
add :-
    write('What is the animals name ? '),
	read(Name),
	
	% adds newly created animal questions game
	% assert(guess(Name)   :- Name, !).
	
	write('How much does it weigh?'),
	read(Weight),
	assert(property(weight, Name,Weight)),
	write('What is its current population?'),
	read(Pop),
	assert(initpopulation(Name,Pop)),
	write('What is its growth rate?'),
	read(GR),
	assert(growthrate(Name,GR)),
	write('Does it eat meat?'),
	read(Response),
    ( (Response == yes ; Response == y)
      ->
	   write('What does it prey upon?'),
	   read(Prey),
	   assert(eats(Name,Prey)),
			   write('Does it prey on anything else?'),
			   read(Response2),
			( (Response2 == yes ; Response2 == y)
				->
				write('What does it prey upon?'),
				read(Prey2),
				assert(prey(Name,Prey2))
				; true)
	   
       ; true).

:- dynamic yes/1,no/1.