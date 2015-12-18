module.exports = {
    readPuzzleFile: readPuzzleFile,
    readMovesFile: readMovesFile
};

function readPuzzleFile(file)
{
    var text;
    var lines = new Array();
    var rows = new Array();
    var filesystem = require('fs');

    text = filesystem.readFileSync(file);
    lines = text.toString().split("\n");

    for (var r = 0; r < lines.length; r++) {
        rows[r] = lines[r].split(",");
    }
    
    rows.splice( rows.length - 1 , 1 );

    return rows;
}

function readMovesFile(file)
{
    var moves = new Array();
    var filesystem = require('fs');
    var line = filesystem.readFileSync(file);
    var temp = new Array();
    temp = line.toString().split("\n");
    moves = temp[0].split(",");
    
    return moves
}
