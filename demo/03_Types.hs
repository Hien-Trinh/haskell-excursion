-- 03: Your own types, Maybe, type classes
-- Load in GHCi:  :load demo/03_Types.hs

module Types where

-- An algebraic data type: a Shape is EITHER a Circle OR a Rectangle.
-- `deriving` tells the compiler to automatically add boilerplate code for typeclass instances
-- `deriving Show` lets GHCi print it; `Eq` gives us ==.
data Shape
  = Circle Double -- radius
  | Rectangle Double Double -- width, height
  deriving (Show, Eq)

-- Pattern match on each constructor.
area :: Shape -> Double
area (Circle r) = pi * r * r
area (Rectangle w h) = w * h

-- Try deleting the Rectangle line: with -Wall, GHC warns the match is incomplete.

-- Records: named fields.
data Person = Person
  { name :: String,
    age :: Int
  }
  deriving (Show)

alice :: Person
alice = Person {name = "Alice", age = 30}

-- name alice              ==> "Alice"
-- alice { age = 31 }      ==> a NEW Person; alice itself never changes

-- No null in Haskell. "Might be missing" is written in the type: Maybe.
safeDiv :: Int -> Int -> Maybe Int
safeDiv _ 0 = Nothing
safeDiv x y = Just (x `div` y)

-- The caller is forced to handle both cases.
showResult :: Maybe Int -> String
showResult Nothing = "can't divide by zero"
showResult (Just n) = "result: " ++ show n

-- A type class is like an interface. Here's our own one.
class Describable a where
  describe :: a -> String

instance Describable Shape where
  describe (Circle r) = "a circle of radius " ++ show r
  describe (Rectangle w h) = "a " ++ show w ++ "x" ++ show h ++ " rectangle"

instance Describable Bool where
  describe True = "yes"
  describe False = "no"

-- Works on a whole list of shapes at once.
totalArea :: [Shape] -> Double
totalArea shapes = sum (map area shapes)

-- totalArea [Circle 1, Rectangle 2 3]
