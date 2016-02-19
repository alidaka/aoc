module Main where
import System.Environment

main :: IO ()

nql s
  | s == []      = 0
  | first == '(' = 1 + (nql rest)
  | first == ')' = -1 + (nql rest)
  | otherwise    = (nql rest)
  where (first:rest) = s

main = do
  args <- getArgs
  let s = args!!0 in do
    print (nql s)
