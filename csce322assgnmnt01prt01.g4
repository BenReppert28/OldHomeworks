grammar csce322assgnmnt01prt01;

// tokens
SECTIONSTART: '<<alpha';
SECTIONEND: 'omega>>';
SECTIONTYPEMOVE: 'Moves';
SECTIONTYPEPUZZLE: 'Puzzle';
LISTSTART: '[';
LISTEND: ']';
BOARDSTART: '{';
BOARDEND: '}';
MOVES: ('u' | 'd' | 'l' | 'r');
PUZZLE: ('-')?('0'..'9')+;
ASSIGNMENT: '=';
ENDROW: '$';
ANDSIGN: '&';
WS: (' ' | '\t' | '\n' | '\r') { skip(); };
ANYTHING : (.);

// rules
boss :  ( andsign 
		| sectionstart 
		| sectionend 
		| sectiontypemove
		| sectiontypepuzzle
		| assignment
		| puzzlestart 
		| puzzleend 
		| endofrow 
		| tile 
		| move
		| anything)* eof;
		
andsign: ANDSIGN;
sectionstart: SECTIONSTART {System.out.println("Start Section: <<alpha");};
sectionend: SECTIONEND {System.out.println("End Section: omega>>");};
sectiontypemove: SECTIONTYPEMOVE {System.out.println("Section: Moves");};
sectiontypepuzzle: SECTIONTYPEPUZZLE {System.out.println("Section: Puzzle");};
assignment: ASSIGNMENT {System.out.println("Assignment: =");};
puzzlestart: BOARDSTART {System.out.println("Start Puzzle: {");};
puzzleend: BOARDEND {System.out.println("End Puzzle: }");};
endofrow: ENDROW {System.out.println("End Row: $");};
tile: PUZZLE {System.out.println("Tile: " + $PUZZLE.text);};
move: MOVES {System.out.println("Move: " + $MOVES.text);};
eof: EOF {System.out.println("End of File");};
anything: ANYTHING {System.out.println("Line " + $ANYTHING.getLine() + " Contains Unrecognized Token " + $ANYTHING.text + "."); 
                    System.exit(0);};
