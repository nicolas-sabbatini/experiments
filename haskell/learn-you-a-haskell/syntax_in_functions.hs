-- Pattern matching
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

{-# HLINT ignore "Use foldr" #-}

lucky_7 :: (Eq a, Num a) => a -> String
lucky_7 7 = "Lucky number 7!"
lucky_7 _ = "Good luck next time pal!"

factorial :: (Integral a) => a -> a
factorial 0 = 1
factorial n = n * factorial (n - 1)

showList' :: (Show a) => [a] -> String
showList' [] = "End"
showList' (x : xs) = show x ++ showList' xs

letFizzBuzz :: Int -> String
letFizzBuzz num = "The answer is " ++ (let fizz n = if n `mod` 3 == 0 then "Fizz" else ""; buzz n = if n `mod` 5 == 0 then "Buzz" else ""; res n = if null (fizz n ++ buzz n) then show n else fizz n ++ buzz n in res num)

caseofFizzBuzz :: Int -> String
caseofFizzBuzz n =
  "The answer is " ++ case (n `mod` 3, n `mod` 5) of
    (0, 0) -> "FizzBuzz"
    (0, _) -> "Fizz"
    (_, 0) -> "Buzz"
    (_, _) -> show n
