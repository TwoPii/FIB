 import Data.Char

 flatten :: [[Int]] -> [Int]

 flatten [] = []
 flatten ll = foldl (++) [] l 

 myLength :: String -> Int

 myLength str = foldl (\x _ -> x+1) 0 str

 myReverse :: [Int] -> [Int]

 myReverse l = foldl (\xs x -> x:xs) [] l 