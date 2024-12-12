{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

{-# HLINT ignore "Use map" #-}

hundredIs :: (Ord a, Num a) => a -> Ordering
hundredIs = compare 100

divBy10 :: (Floating a) => a -> a
divBy10 = (/ 10)

maxOr100 :: (Ord a, Num a) => a -> a
maxOr100 = max 100

isUppercase :: Char -> Bool
isUppercase = (`elem` ['A' .. 'Z'])

-- Can't use (- 10) because it interpret the expresion as a negative number
subtract10 :: (Num a) => a -> a
subtract10 = subtract 10

applyTwice :: (a -> a) -> a -> a
applyTwice fun x = fun (fun x)

zipMap :: (a -> b -> c) -> [a] -> [b] -> [c]
zipMap _ [] _ = []
zipMap _ _ [] = []
zipMap fun (x : xs) (y : ys) = fun x y : zipMap fun xs ys

largestDivisible :: (Integral a) => a -> a -> a
largestDivisible listStart target = head (filter canDiv [listStart, listStart - 1 ..])
  where
    canDiv n = n `mod` target == 0

sumOddSquaresTill :: (Integral a) => a -> a
sumOddSquaresTill limit = sum (takeWhile (< limit) (filter odd (map (^ 2) [1 ..])))

sumOddSquaresTill_v2 :: (Integral a) => a -> a
sumOddSquaresTill_v2 limit = sum . takeWhile (< limit) . filter odd . map (^ 2) $ [1 ..]

sumOddSquaresTill_v3 :: (Integral a) => a -> a
sumOddSquaresTill_v3 limit = sum takeUntill
  where
    takeUntill = takeWhile (< limit) oddSquares
    oddSquares = filter odd . map (^ 2) $ [1 ..]

-- With lambdas: length ( filter (\ xs -> length xs < 10) (map chain [1..1000]))
-- With sections: length (let g xs = length xs < 10 in filter g (map chain [1..1000]))
chain :: (Integral a) => a -> [a]
chain 1 = [1]
chain n
  | even n = n : chain (n `div` 2)
  | odd n = n : chain (n * 3 + 1)

-- lambdas can have multiple arguments: zipWith (\a b -> (a * 32 + 3) / b) [5,4,3,2,1] [1,2,3,4,5]
-- Lambdas can pattern match: map (\(a, b) -> a + b) [(1,2),(3,5),(6,3),(2,6),(2,5)]

elemFold :: (Eq a) => a -> [a] -> Bool
elemFold y = foldl (\acc x -> (x == y) || acc) False

mapFoldr :: (a -> b) -> [a] -> [b]
mapFoldr f = foldr (\x acc -> f x : acc) []

-- negateAbs = map (\x -> negate (abs x))
negateAbs :: (Num a) => [a] -> [a]
negateAbs = map (negate . abs)
