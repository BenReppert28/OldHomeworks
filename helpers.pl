:- module( helpers,
	   [ readBPF/2
	   , printPuzzle/1
	   ]
    ).

readBPF(File,Puzzle):-
    open(File,read,Input),
    readPuzzle(Input,Puzzle),
    close(Input).

readPuzzle(Input,[]):-
    at_end_of_stream(Input),
    !.
readPuzzle(Input,[Row|Rows]):-
    \+ at_end_of_stream(Input),
    read(Input,Row),
    readPuzzle(Input,Rows).

printPuzzle(Puzzle):-
    writeln(puzzle),
    printRows(Puzzle).

printRows([]).
printRows([Row|Rows]):-
    writeln(Row),
    printRows(Rows).
