import Prelude
import System.Environment ( getArgs )
import Data.List
import Helpers
  
-- The main method that will be used for testing / command line access
main = do
  args <- getArgs
  filename <- readFile (head args)
  (_,puzzle) <- readBossPuzzleFile filename
  (printSolvable (puzzleSolvable puzzle))

printSolvable :: Bool -> IO ()
printSolvable True    = print "The puzzle is solvable"
printSolvable False   = print "The puzzle is not solvable"

-- YOUR CODE SHOULD COME AFTER THIS POINT
puzzleSolvable :: [[Int]] -> Bool
puzzleSolvable puzzle = False --find how to count the  inversions and do math. output true/false where needed

myCompare :: Int -> Int -> Int
a `myCompare` b
 | a > b = inversions + 1
 | otherwise = inversions
