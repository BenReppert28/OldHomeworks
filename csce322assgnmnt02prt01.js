module.exports = {
    oneMove: oneMove
}

var helpers = require( './helpers' );

function oneMove(puzzle){
    
    function singleMove(direction){
		var boolSwitch = true;
		if(direction[0] == 'r'){ //array[row][column] right/left rows up/down column
			for(i=0; i<puzzle.length; i++){      
				for(j=0; j<puzzle[0].length; j++){
					if(puzzle[i][j] == 0 && j-1 >= 0 && boolSwitch == true){
						puzzle[i][j] = puzzle[i][j-1];
						puzzle[i][j-1] = "0";
						boolSwitch = false;
					}
				}
			}
		}
		if(direction[0] == 'l'){
			for(i=0; i<puzzle.length; i++){
				for(j=0; j<puzzle[0].length; j++){
					if(puzzle[i][j] == 0 && j+1 < puzzle[0].length && boolSwitch == true){
						puzzle[i][j] = puzzle[i][j+1];
						puzzle[i][j+1] = "0";
						boolSwitch = false;
					}
				}
			}
		}
		if(direction[0] == 'u'){
			for(i=0; i<puzzle.length; i++){
				for(j=0; j<puzzle[0].length; j++){
					if(puzzle[i][j] == 0 && i+1 < puzzle.length && boolSwitch == true){
						puzzle[i][j] = puzzle[i+1][j];
						puzzle[i+1][j] = "0";
						boolSwitch = false;
					}
				}
			}
		}
		if(direction[0] == 'd'){
			for(i=0; i<puzzle.length; i++){
				for(j=0; j<puzzle[0].length; j++){
					if(puzzle[i][j] == 0 && i-1 >= 0 && boolSwitch == true){
						puzzle[i][j] = puzzle[i-1][j];
						puzzle[i-1][j] = "0";
						boolSwitch = false;
					}
				}
			}
		}
		
		return puzzle;
    }

    return singleMove;
}
