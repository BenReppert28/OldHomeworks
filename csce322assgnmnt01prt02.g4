grammar csce322assgnmnt01prt02;

@members{
			int columncount = 0;
			int rowcount = 1;
			int andcount = 0;
			int tilecount = 0;
			int maxBoard = 0;
			boolean belowZero = false;
			boolean ruleBreak = false;
		}
		
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
		| movestart
		| move
		| moveend
		| tile 
		| anything)* eof;
		
andsign: ANDSIGN;
sectionstart: SECTIONSTART;
sectionend: SECTIONEND;
sectiontypemove: SECTIONTYPEMOVE;
sectiontypepuzzle:SECTIONTYPEPUZZLE;
assignment: ASSIGNMENT;
puzzlestart: BOARDSTART;
puzzleend: BOARDEND;
movestart: LISTSTART;
moveend: LISTEND;
endofrow: ENDROW {rowcount++;};
tile: PUZZLE {tilecount++; 
              if(Integer.parseInt($PUZZLE.text) > maxBoard){
			   maxBoard = Integer.parseInt($PUZZLE.text);
			  }
			  if(Integer.parseInt($PUZZLE.text) < 0){
			   belowZero = true;
			  }
			 };
move: MOVES;
eof: EOF { columncount = tilecount / rowcount;
		   if(maxBoard > tilecount || belowZero == true){
			System.out.println("Semantic Error: Rule 1 Violated");
			ruleBreak = true;
		   }
		   if(rowcount <= 2 || rowcount >= 10){
			System.out.println("Semantic Error: Rule 2 Violated");
			ruleBreak = true;
		   }
		   if(columncount <= 2 || columncount >= 10){
		    System.out.println("Semantic Error: Rule 3 Violated");
			ruleBreak = true;
		   }
		   if(ruleBreak == false){
		    System.out.println("The puzzle has " + (tilecount-1) + " tiles");
		   }
		  };
anything: ANYTHING {System.out.println("Line " + $ANYTHING.getLine() + " Contains Unrecognized Token " + $ANYTHING.text); System.exit(0);};
