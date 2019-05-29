absValue :: Int -> Int
 
absValue n
     | n >= 0  = n
     | otherwise = -n
 
 
power :: Int -> Int -> Int
 
power x 0 = 1
power x n 
     | even n  =  z * z
     | odd n   =  z * z * x
    where 
        z = power x(div n 2)
 
 
slowFib :: Int -> Int
 
slowFib 0 = 0
slowFib 1 = 1
slowFib n = slowFib (n-1) + slowFib (n-2)
 

{-isPrime :: Int -> Bool

isPrime 0 = False
isPrime 1 = False
isPrime n = not (hasDivisor n 2)
    where
        hasDivisor :: Int -> Int-> Bool

        hasDivisor n c
            | c*c > n      = False
            | mod n c == 0 = True
            | otherwise    = hasDivisor n (c+1)
-}

isPrime :: Int -> Bool

isPrime 1 = False
isPrime n = isPrime' 2
    where
        isPrime' d
            | d == n       = True
            | mod n d == 0 = False
            |otherwise     = isPrime' (d+1)

quickFib :: Int -> Int

quickFib n =  fst (quickFib' n)
    
quickFib' :: Int -> (Int, Int)

quickFib' 0 = (0,0)
quickFib' 1 = (1,0)
quickFib' n = (fn , fn1)
    where
        (fn1, fn2) = quickFib' (n-1)
        fn = fn1 + fn2 
