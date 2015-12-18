oddWidthEvenInversions([Row|Rows]):-
	length(Row,Width), 
	1 is Width mod 2,
	flatten([Row|Rows],Puzzle),
	inversions(Puzzle,TotalInversions),
	0 is TotalInversions mod 2.
	
inversions([],0).
inversions([_],0).
inversions([Head,Next|Tail], Total):-
	firstGreaterIncrement([Head,Next|Tail], HTotal),
	inversions([Next|Tail], TTotal),
	Total is HTotal + TTotal.
	
firstGreaterIncrement([],0).
firstGreaterIncrement([_],0).
firstGreaterIncrement([Ha,Ne|_],0):-
	Ha < Ne.
firstGreaterIncrement([_,Ne|_],0):-
	Ne is 0.
firstGreaterIncrement([Ha,_|Ta],Counter):-
	firstGreaterIncrement([Ha|Ta],Inversion),
	Counter is Inversion + 1.
