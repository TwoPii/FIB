flatten :: [[Int]] -> [Int]

flatten ll = foldl (++) [] ll 

myLength :: String -> Int

myLength str = foldl (\x _ -> x+1) 0 str

myReverse :: [Int] -> [Int]

--myReverse l = foldl (\xs x -> x:xs) [] l 
myReverse ll = foldr (\x xs -> xs++[x]) [] ll

countIn :: [[Int]] -> Int -> [Int] 

countIn ll e = foldr (\x xs -> (foldl (\y z -> (if (z==e) then (y+1) else y)) 0 x):xs) [] ll

firstWord :: String -> String

firstWord str = (takeWhile (/=' ') (dropWhile (== ' ') str))


{--ones :: [Integer]

ones = 1:ones

fibs :: [Integer]

fibs = 0:1:zipWith (+) fibs (tail fibs)
--}
