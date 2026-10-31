-- 04: A real program. Pure logic + a thin IO shell.
-- Run it:      runghc demo/04_WordCount.hs < demo/sample.txt
-- Or compile:  ghc -O2 demo/04_WordCount.hs -o wordcount && ./wordcount < demo/sample.txt

module Main where

import Data.Char (isAlpha, toLower)
import Data.List (sortBy)
import Data.Ord (comparing, Down (..))
import qualified Data.Map as Map

-- PURE: no IO in the type, so it can't read files, print, or touch the network.
-- Same input, same output, every time. Easy to test in GHCi.
wordFreq :: String -> [(String, Int)]
wordFreq text =
  take 5
    . sortBy (comparing (Down . snd))
    . Map.toList
    . Map.fromListWith (+)
    $ [(w, 1) | w <- words cleaned]
  where
    cleaned = map (\c -> if isAlpha c then toLower c else ' ') text

-- IMPURE: the IO in the type says "this talks to the outside world".
main :: IO ()
main = do
  text <- getContents                  -- read all of stdin
  putStrLn "Top 5 words:"
  mapM_ printRow (wordFreq text)
  where
    printRow (w, n) = putStrLn ("  " ++ w ++ ": " ++ show n)
