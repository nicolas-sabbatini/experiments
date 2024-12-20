module Main where

import System.Environment (getArgs)
import System.Random (randomRIO)

main :: IO ()
main = do
  u <- fmap (subtract 1 . read . head) getArgs
  r <- randomRIO (0, 10000) :: IO Int
  let a =
        [ e
          | let e = sum ([t | t1 <- [1 .. 100000], let t = mod t1 u]) + r,
            _ <- [1 .. 10000]
        ]
  print $ a !! r
