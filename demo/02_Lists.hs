-- 02: Lists, pattern matching, recursion, laziness
-- Load in GHCi:  :load demo/02_Lists.hs

module Lists where

-- Pattern matching: one equation per "shape" of input.
--   []     = the empty list
--   (x:xs) = first element x, followed by the rest xs
mySum :: [Int] -> Int
mySum [] = 0
mySum (x : xs) = x + mySum xs

myLength :: [a] -> Int
myLength [] = 0
myLength (_ : xs) = 1 + myLength xs -- `_` means "don't care"

-- The famous two-line quicksort.
quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (p : xs) = quicksort smaller ++ [p] ++ quicksort larger
  where
    smaller = [x | x <- xs, x < p] -- list comprehension
    larger = [x | x <- xs, x >= p]

-- The big three higher-order functions.
squares :: [Int]
squares = map (^ 2) [1 .. 10]

evens :: [Int]
evens = filter even [1 .. 20]

total :: Int
total = foldr (+) 0 [1 .. 100]

-- Laziness: this list is INFINITE, but Haskell only computes what you ask for.
naturals :: [Integer]
naturals = [1 ..]

-- take 5 naturals   ==> [1,2,3,4,5]

-- Infinite Fibonacci, defined in terms of itself.
fibs :: [Integer]
fibs = 0 : 1 : zipWith (+) fibs (drop 1 fibs)

-- take 15 fibs
-- fibs !! 100   (Integer never overflows)

-- First 10 primes, with a lazy sieve.
primes :: [Int]
primes = sieve [2 ..]
  where
    sieve (p : xs) = p : sieve [x | x <- xs, x `mod` p /= 0]

-- FizzBuzz: 3 -> "Fizz", 5 -> "Buzz", 15 -> "FizzBuzz", else the number itself.
fizzbuzz :: Int -> String
fizzbuzz n
  | n `mod` 15 == 0 = "FizzBuzz"
  | n `mod` 3 == 0 = "Fizz"
  | n `mod` 5 == 0 = "Buzz"
  | otherwise = show n

-- Try:  mapM_ (putStrLn . fizzbuzz) [1 .. 15]
