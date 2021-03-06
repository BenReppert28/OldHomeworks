twoConditions([Row|Rows]):-
	length(Row,Width), 
	1 is Width mod 2,
	flatten([Row|Rows],Puzzle),
	inversions(Puzzle,TotalInversions),
	0 is TotalInversions mod 2,
	createSolved(Puzzle,SolvedPuzzle),
	path(Puzzle,SolvedPuzzle,ShortestPath).
	
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

createSolved([Row|Rows],SolvedPuzzle):-
	length(Row,NumCols),
	length([Row|Rows],NumRows),
	WhereSize is NumCols * NumRows,
	WhatSize is WhereSize - 1,
	numlist(1,WhereSize,Wheres),
	numlist(1,WhatSize,Temp),
	append(Temp,[0],Whats),
	createSolved([Row|Rows],Wheres,Whats,SolvedPuzzle).
createSolved(Puzzle,[],[],Puzzle).
createSolved(Puzzle,[HWhere|TWhere],[HWhat|TWhat],SolvedPuzzle):-
	change(Puzzle,HWhere,HWhat,RSolvedPuzzle),
	createSolved(RSolvedPuzzle,TWhere,TWhat,SolvedPuzzle).

path(X,Z,Path):-
	between(0,10,PathLength),
	length(Path,PathLength),
	path_r(X,Z,Path).
	
path_r(Z,Z,[]).
path_r(X,Z,[Direction|Path]):-
	arc(X,Y,Direction),
	path(Y,Z,Path).
	
arc([Row|Rows],UpdatedPuzzle,l):-
	find([Row|Rows],0,Where),
	length(Row,NumCols),
	not(0 is Where mod NumCols),
	NewTile is Where + 1,
	find([Row|Rows],Tile,NewTile),
	change([Row|Rows],Where,Tile,PuzzleUpdate),
	change(PuzzleUpdate,NewTile,0,UpdatedPuzzle).
arc([Row|Rows],UpdatedPuzzle,r):-
	find([Row|Rows],0,Where),
	length(Row,NumCols),
	not(1 is Where mod NumCols),
	NewTile is Where - 1,
	find([Row|Rows],Tile,NewTile),
	change([Row|Rows],Where,Tile,PuzzleUpdate),
	change(PuzzleUpdate,NewTile,0,UpdatedPuzzle).
arc([Row|Rows],UpdatedPuzzle,d):-
	find([Row|Rows],0,Where),
	length(Row,NumCols),
	not(between(1,NumCols,Where)),
	NewTile is Where - NumCols,
	find([Row|Rows],Tile,NewTile),
	change([Row|Rows],Where,Tile,PuzzleUpdate),
	change(PuzzleUpdate,NewTile,0,UpdatedPuzzle).
arc([Row|Rows],UpdatedPuzzle,u):-
	find([Row|Rows],0,Where),
	length(Row,NumCols),
	length([Row|Rows],NumRows),
	Max is NumCols * NumRows,
	MinMax is Max - NumCols + 1,
	not(between(MinMax,Max,Where)),
	NewTile is Where + NumCols,
	find([Row|Rows],Tile,NewTile),
	change([Row|Rows],Where,Tile,PuzzleUpdate),
	change(PuzzleUpdate,NewTile,0,UpdatedPuzzle).
	
find([Row|_],What,Where):-
    findRow(Row,What,Where).
find([Row|Rows],What,Where):-
    length(Row,Cols),
    find(Rows,What,RWhere),
    Where is RWhere + Cols.

findRow([What|_],What,1).
findRow([_|Cols],What,Where):-
    findRow(Cols,What,CWhere),
    Where is CWhere + 1.
	
change([Row|Rows],Where,NewWhat,[NewRow|Rows]):-
    changeRow(Row,Where,NewWhat,NewRow).
change([Row|Rows],Where,NewWhat,[Row|NewRows]):-
    length(Row,NumCols),
    length([Row|Rows],NumRows),
    Most is NumRows * NumCols,
    Least is NumCols + 1,
    between(Least,Most,Where),
    NewWhere is Where - NumCols,
    change(Rows,NewWhere,NewWhat,NewRows).

changeRow([_|Cols],1,NewElement,[NewElement|Cols]).
changeRow([Col|Cols],Where,NewElement,[Col|Result]):-
    length([Col|Cols],NumCols),
    between(2,NumCols,Where),
    CWhere is Where - 1 ,
    changeRow(Cols,CWhere,NewElement,Result).
