ones :: [Integer]

ones = 1:ones

nats :: [Integer]

nats = iterate (+1) 0

natsfromOne :: [Integer]

natsfromOne = iterate (+1) 1

ints :: [Integer]

ints = 0:(concatMap (\x -> [x,-x]) natsfromOne)

triangulars :: [Integer]

triangulars = scanl (+) 0 natsfromOne

factorials :: [Integer]

factorials = scanl (*) 1 natsfromOne

fibs :: [Integer]

fibs = 0:1:zipWith (+) fibs (tail fibs)

natsfromTwo :: [Integer]

natsfromTwo = iterate (+1) 2

primes :: [Integer]

primes = primes' natsfromTwo
    where primes' (x: xs) = x: (primes' $ filter (\y -> mod y x /= 0) xs)
          
--hammings :: [Integer]

--hammings = 1:(filter (\y -> (mod y 2 == 0) || (mod y 3 == 0) || (mod y 5 == 0)) natsfromOne)

hammings :: [Integer]
hammings = 1 : map (2*) hammings `merge` map (3*) hammings `merge` map (5*) hammings
  where merge (x:xs) (y:ys)
          | x < y = x : xs `merge` (y:ys)
          | x > y = y : (x:xs) `merge` ys
          | otherwise = x : xs `merge` ys

group' :: (Eq a) => [a] -> [[a]]

group' []     = []
group' (x:xs) = (x : takeWhile (== x) xs) : group' (dropWhile (== x) xs)

say :: Integer -> Integer

say el = (read (foldr (\x xs -> (show . length) x ++ head x : xs) [] $ group' (show el)))

lookNsay :: [Integer]

lookNsay = 1 : map say lookNsay

nextRow :: [Integer] -> [Integer]
nextRow row = zipWith (+) ([0] ++ row) (row ++ [0])
 

tartaglia :: [[Integer]]
tartaglia = iterate nextRow [1]
