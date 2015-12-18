import Prelude
import System.Environment ( getArgs )
import Data.List
import Helpers
  
-- The main method that will be used for testing / command line access
main = do
  args <- getArgs
  filename <- readFile (head args)
  (moves,puzzle) <- readBossPuzzleFile filename
  (printPuzzle (multipleMoves moves puzzle))

-- YOUR CODE SHOULD COME AFTER THIS POINT
multipleMoves :: [Char] -> [[Int]] -> [[Int]]
multipleMoves moves puzzle -- = [[]]
 | (checkSolved puzzle) == True = puzzle --if board is solved return the board unchanged
 | (rem (findStuff puzzle 0) (length puzzle)) == 1 && moves == 'l'                = puzzle --left move not allowed
 | (rem (findStuff puzzle 0) (length puzzle)) == 0 && moves == 'r'                = puzzle --right move not allowed
 | (findStuff puzzle 0) < length puzzle && moves == 'u'                           = puzzle --up move not allowed
 | (findStuff puzzle 0) >= (length puzzle / (head) length puzzle) && moves == 'd' = puzzle --down move not allowed
 | moves == 'l' = nZeroAfter ((findStuff puzzle 0)-1)
 | moves == 'r' = nZeroAfter ((findStuff puzzle 0)+1)
 | moves == 'u' = nZeroAfter ((findStuff puzzle 0)+length puzzle)
 | moves == 'd' = nZeroAfter ((findStuff puzzle 0)-length puzzle)
 where
  nZeroAfter   = (findStuff puzzle 0)
  nZeroBefore  = (findStuff puzzle 0)
  nValueToMove = (findStuff puzzle nZeroAfter)
  --up (find 0) + length puzzle
  --down (find 0) - length puzzle
  --left (find 0) - 1
  --right (find 0) +1
  --possible work out: find what move it is, then return find 0 with whatever mod it needs to be to pass into the swap
 
 --        find    row    replace  output 
setRow :: Int -> [Int] -> Int -> [Int]
setRow 1 (he:ta) new = (new:ta)
setRow p (he:ta) new = he:(setRow(p-1) ta new)

findStuff :: [[Int]] -> Int -> Int
findStuff (row:rows) something
     | elem something row = findRow something row
     | otherwise          = (find something rows) + (length row)
	  
findRow :: Int -> [Int] -> Int
findRow el (he:ta)
    | el == he  = 1
    | otherwise = (findRow el ta) + 1
 
checkSolved :: [[Int]] -> Bool
checkSolved puzzle = puzzle == solvedPuzzle
	    where solvedPuzzle = createSolved puzzle

createSolved :: [[Int]] -> [[Int]]
createSolved (row:rows) = placeTiles nRows nCols tiles
	     where nRows = length (row:rows)
	     	   nCols = length (row)
		   tiles = [1..((nRows*nCols)-1)] ++ [0]

placeTiles :: Int -> Int -> [Int] -> [[Int]]
placeTiles 0 _ _ 	    	  = []
placeTiles nRows nCols tiles 	  = (take nCols tiles):(placeTiles (nRows-1) nCols (drop nCols tiles)) -- take copies the first n elements from the front of a list, drop copies a list, without its first n elements
