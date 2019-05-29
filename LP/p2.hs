myLength :: [Int] -> Int

myLength [] = 0
myLength (x:xs) = 1 + myLength xs

myMaximum :: [Int] -> Int

myMaximum [last] = last
myMaximum (x:xs) = max x (myMaximum xs)

average :: [Int] -> Float

average [] = 0
average (x: xs) =  fromIntegral (sumrec (x:xs)) / fromIntegral (myLength (x:xs))

sumrec :: [Int] -> Int

sumrec [] = 0
sumrec (x: xs) = x + sumrec xs

--buildPalindrome :: [Int] -> [Int]

--buildPalindrome x = reverse x ++ x

buildPalindrome :: [Int]->[Int]

buildPalindrome x = reverse' x ++ x

reverse' :: [Int]->[Int]

reverse' [] = []
reverse' [x] = [x]
reverse' (y:ys) = (reverse' ys) ++ [y]

remove :: [Int] -> [Int] -> [Int]

remove x [] = x
remove x (y:ys) = remove (remove' x y) ys

remove' :: [Int] -> Int -> [Int]

remove' [] _ = []
remove' (x:xs) y
	| x == y = remove' xs y
	| otherwise = x:(remove' xs y)

flatten :: [[Int]] -> [Int]

flatten [] = []
flatten (llista: llistes) = llista ++ flatten llistes

oddsNevens :: [Int] -> ([Int],[Int])

oddsNevens [] = ([],[])
oddsNevens list = oddsNevens' list [] []

oddsNevens' :: [Int]->[Int]->[Int]->([Int],[Int])

oddsNevens' [] odds evens = (odds, evens)
oddsNevens' (x:xs) odds evens
	| mod x 2 == 0 = oddsNevens' xs odds (evens++[x])
	| otherwise = oddsNevens' xs (odds++[x]) evens

primeDivisors :: Int -> [Int]

primeDivisors 0 = []
primeDivisors 1 = []
primeDivisors x =  reverse (primeDivisors' x (primes x))

primeDivisors' :: Int->[Int]->[Int]

primeDivisors' _ [] = []
primeDivisors' 0 _ = []
primeDivisors' 1 _ = []
primeDivisors' 2 _ = [2]
primeDivisors' x (y: ys)
	| mod x y == 0 = [y]++primeDivisors' x ys
	| otherwise = primeDivisors' x ys


primes :: Int -> [Int]

primes 0 = []
primes 1 = []
primes x 
	| (hasDivisor x 2) == False  = [x]++primes (x-1)
	| otherwise = primes(x-1)

hasDivisor :: Int -> Int-> Bool

hasDivisor n c
    | c*c > n      = False
    | mod n c == 0 = True
    | otherwise    = hasDivisor n (c+1)

 
