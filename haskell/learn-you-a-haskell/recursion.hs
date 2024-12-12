fib :: (Integral a) => a -> a
fib 0 = 0
fib 1 = 1
fib 2 = 1
fib x = fib (x - 1) + fib (x - 2)

fibPerf :: (Integral a) => a -> a
fibPerf x = fib_rec x 0 1
  where
    fib_rec :: (Integral a) => a -> a -> a -> a
    fib_rec 0 a _ = a
    fib_rec 1 _ current = current
    fib_rec i prev current = fib_rec (i - 1) current (prev + current)

listMax :: (Ord a) => [a] -> a
listMax [] = error "Empty list"
listMax [x] = x
listMax (x : xs) = max x (listMax xs)

leftPad :: Int -> Char -> String -> String
leftPad 0 _ s = s
leftPad x pad s
  | x <= length s = s
  | otherwise = leftPad x pad (pad : s)

quickSort :: (Ord a) => [a] -> [a]
quickSort [] = []
quickSort (pivot : xs) =
  let smaller = quickSort (filter (<= pivot) xs)
      bigger = quickSort (filter (> pivot) xs)
   in smaller ++ [pivot] ++ bigger
