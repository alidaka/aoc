module Main where
import System.Environment

main :: IO ()


data Wrapped a = Wrap a

return :: a -> Wrapped a
return x = Wrap x

fmap :: (a -> b) -> (Wrapped a -> Wrapped b)
fmap f (Wrap x) = Wrap (f x)

bind :: (a -> Wrapped b) -> (Wrapped a -> Wrapped b)
bind f (Wrap x) = f x


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

  --print (['a','b','c'] == "abc")
  --let (a:b:c) = ['c', 'a', 'b'] in print a

--primes = filterPrime [2..]
  --where filterPrime (p:xs) =
      ----p : filterPrime [x | x <- xs, x `mod` p /= 0]

