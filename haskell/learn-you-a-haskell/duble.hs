dubleIt :: (Num a) => a -> a
dubleIt x = x + x

dubleUs :: (Num a) => a -> a -> a
dubleUs x y = dubleIt x + dubleIt y

dubleIfSmall :: (Num a, Ord a) => a -> a
dubleIfSmall x = if x > 100 then x else dubleIt x

-- Comprencion de listas
mod_7 = [x | x <- [1 .. 100], x `mod` 7 == 0]

duble_0_100 = [dubleIt x | x <- [1 .. 100]]
