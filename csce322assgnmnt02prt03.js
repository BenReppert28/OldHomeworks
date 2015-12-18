module.exports = {
    withCaL: withCaL
}

function withCaL(game){
    /*
      Returns a function that, given the position of a piece and a roll will determine where the piece will move
      The presence of ladders is ignored.
     */
    var max = 1;
	for(i=0; i<game.length; i++){
		for(j=0; j<game[i].length; j++){
				max++;
		}
	}
	var board = new Array();	//[[0 1]
	board = game[3];			// [2 3]
	var chutes = new Array();	// [4 5]]
	chutes = game[1];
	var ladders = new Array();
	ladders = game[2];
	if(board[0].length % 2 == 0){ //used to swap around elements in the rows.
		var start = 0;
		var end = board[0].length;
		var temp = 0;
		for(i=0; i<=board[0].length;i+=2){
			while(start < end){
				temp = board[i][start];
				board[i][start] = board[i][end];
				board[i][end]=temp;
				start++;
				end--;
			}
		}
		
	} else if(board[0].length % 2 == 1){
		var start = 0;
		var end = board[0].length;
		var temp = 0;
		for(i=1; i<=board[0].length;i+=2){
			while(start < end){
				temp = board[i][start];
				board[i][start] = board[i][end];
				board[i][end] = temp;
				start++;
				end--;
			}
		}
	}
	var rowStart = 0;
	var rowEnd = board[0].length;
	var tmpRow = new Array();
	while(rowStart < rowEnd){
		tmpRow = board[rowStart];
		board[rowStart] = board[rowEnd];
		board[rowEnd] = tmpRow;
		rowStart++;
		rowEnd--;
	}

    function chutesAndLadders(position,roll){
		var chuteLanding = 0;
		var ladderLanding = 0;
		if(position + roll > max){
			return max;
		}else{
			for(i=0; i<chutes.length; i++){
				if(position + roll == chutes[i]){
					chuteLanding = max - chutes[i];
					return board[chuteLanding];
				}
			}
			for(i=0; i<ladders.length; i++){
				if(position + roll == ladders[i]){
					ladderLanding = max - ladders[i];
					return board[ladderLanding];
				}
			}
			return position + roll;
		}
    }

    return chutesAndLadders;
}
