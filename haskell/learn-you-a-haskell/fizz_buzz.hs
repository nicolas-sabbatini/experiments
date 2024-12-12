fizzBuzz :: Int -> String
fizzBuzz n
  | n `mod` 15 == 0 = "FizzBuzz"
  | n `mod` 3 == 0 = "Fizz"
  | n `mod` 5 == 0 = "Buzz"
  | otherwise = show n

fizzBuzzV2 :: Int -> String
fizzBuzzV2 n = if null res then show n else res
  where
    fizzV2 n = if n `mod` 3 == 0 then "Fizz" else ""
    buzzV2 n = if n `mod` 5 == 0 then "Buzz" else ""
    res = fizzV2 n ++ buzzV2 n

fizzBuzzList :: Int -> [String]
fizzBuzzList list_end = [res x | x <- [1 .. list_end]]
  where
    fizz n = if n `mod` 3 == 0 then "Fizz" else ""
    buzz n = if n `mod` 5 == 0 then "Buzz" else ""
    res n = if null (fizz n ++ buzz n) then show n else fizz n ++ buzz n
