module Main where
import System.Environment

main :: IO ()

nql s = do
  if s == [] then
    0
  else
    let (first:rest) = s in do
      if first == '(' then
        1 + (nql rest)
      else
        -1 + (nql rest)

main = do
  args <- getArgs
  print "Input:"
  let s = args!!0 in do
    print s
    print (nql s)

  --print (['a','b','c'] == "abc")
  --let (a:b:c) = ['c', 'a', 'b'] in print a

--primes = filterPrime [2..]
  --where filterPrime (p:xs) =
      ----p : filterPrime [x | x <- xs, x `mod` p /= 0]

