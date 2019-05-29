eql :: [Int] -> [Int] -> Bool 

eql [] [] = True
eql [] (y:ys) = False
eql (x:xs) [] = False
eql l1 l2 = ((length l1) == (length l2)) && all (==0) (zipWith (-) l1 l2)
 
--prod :: [Int] -> Int

