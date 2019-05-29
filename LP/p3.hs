insert :: [Int] -> Int -> [Int]

insert [] x = [x]
insert (x:xs) y 
	| y <= x = [y]++[x]++xs
	| otherwise = [x]++insert xs y 

isort :: [Int] -> [Int]

isort [] = []
isort (head:tail) = insert (isort tail) head

remove :: [Int] -> Int -> [Int]

remove [] _ = []
remove (x: xs) y
	| x == y = xs
	| otherwise = x:remove xs y

ssort :: [Int] -> [Int]

ssort [] = []
ssort (head:tail) = insert (ssort (remove (head:tail) head)) head

merge :: [Int] -> [Int] -> [Int]

merge [] []  = []
merge [] l1 = l1
merge l2 [] = l2
merge (x: xs) (y:ys)
	| x <= y = [x]++merge xs (y:ys)
	| x > y = [y]++merge ys (x:xs)

msort :: [Int] -> [Int]

msort [] = []
msort [last] = [last]
msort list = merge (msort $ take (half list) list) (msort $ drop (half list) list)
	where 
		half = flip div 2 . length

		
		
qsort :: [Int] -> [Int]

qsort xs = qsort' xs []

qsort' :: [Int] -> [Int] -> [Int]

qsort' [] result = result
qsort' [x] result = x:result
qsort' (x:xs) result = qpart xs [] [] result
    where
        qpart :: [Int]->[Int]->[Int]->[Int]->[Int]

        qpart [] part1 part2 result = qsort' part1 (x:qsort' part2 result)
        qpart (y:ys) part1 part2 result
            | y <= x = qpart ys (y:part1) part2 result
            | y >  x = qpart ys part1 (y:part2) result
      
      
      
genQsort :: Ord a => [a] -> [a]
genQsort xs = genQsort' xs []
    where
        genQsort' [] result = result
        genQsort' [x] result = x:result
        genQsort' (x:xs) result = genQpart xs [] [] result
            where
                genQpart [] half1 half2 result = genQsort' half1 (x:genQsort' half2 result)
                genQpart (x':xs') half1 half2 result
                    | x' <= x = genQpart xs' (x':half1) half2 result
                    | x' > x = genQpart xs' half1 (x':half2) result
