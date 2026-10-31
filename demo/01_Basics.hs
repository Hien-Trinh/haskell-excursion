-- 01: Values, functions, types
-- Load in GHCi:  :load demo/01_Basics.hs

module Basics where

-- A value. Names are immutable: you can't reassign `answer` later.
answer :: Int
answer = 42

-- A function. The line above it is the TYPE SIGNATURE (optional, but good style).
-- Read it as: "double takes an Int and returns an Int".
double :: Int -> Int
double x = x * 2

-- No parentheses or commas when calling: `add 3 4`, not add(3, 4).
add :: Int -> Int -> Int
add x y = x + y

-- Currying: every function takes ONE argument. `add 10` is a new function.
addTen :: Int -> Int
addTen = add 10

-- Type inference: no signature here, GHC figures it out. Try  :type square
square x = x * x

-- if/then/else is an EXPRESSION (always needs an else, always returns a value).
describe :: Int -> String
describe n = if even n then "even" else "odd"

-- Guards: a cleaner way to write several conditions.
grade :: Int -> Char
grade score
  | score >= 90 = 'A'
  | score >= 80 = 'B'
  | score >= 70 = 'C'
  | otherwise = 'F'

-- `where` names helper values used in the body.
hypotenuse :: Double -> Double -> Double
hypotenuse a b = sqrt (a2 + b2)
  where
    a2 = a * a
    b2 = b * b

-- Functions are values: pass them to other functions.
twice :: (a -> a) -> a -> a
twice f x = f (f x)

-- twice double 5   ==> 20
-- twice (++ "!") "hi"   ==> "hi!!"

-- Function composition with (.) : read right to left.
doubleThenAddTen :: Int -> Int
doubleThenAddTen = addTen . double
