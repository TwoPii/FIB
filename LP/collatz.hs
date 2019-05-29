serieCollatz :: Int -> [Int]

serieCollatz x = iterate collatz x

collatz :: Int -> Int

collatz x
		| ((mod x 2) == 0) 	= div x 2
		| otherwise 		= 3*x + 1