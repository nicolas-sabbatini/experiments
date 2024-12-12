boomBangs :: [Int] -> [String]
boomBangs xs = [if x < 10 then "BOOM!" else "BANG!" | x <- xs, odd x]

not_13_15_19 :: [Int]
not_13_15_19 = [x | x <- [10 .. 20], x /= 13, x /= 15, x /= 19]

-- bigResOnly [1..10] [1..10]
-- [54,60,56,63,70,56,64,72,80,54,63,72,81,90,60,70,80,90,100]
bigResOnly :: (Num a, Ord a) => [a] -> [a] -> [a]
bigResOnly xs ys = [x * y | x <- xs, y <- ys, x * y > 50]

onlyEvens :: (Integral a) => [[a]] -> [[a]]
onlyEvens xxs = [[x | x <- xs, even x] | xs <- xxs]

flatList :: [[a]] -> [a]
flatList xxs = [x | xs <- xxs, x <- xs]
