class Point p where
     sel :: Int -> p -> Double
     dim :: p -> Int
     child :: p -> p -> [Int] -> Int
     dist :: p -> p -> Double
     list2Point :: [Double] -> p 
         
data Point3d = Point3d {x :: Double, y :: Double, z :: Double} 
instance Point Point3d where
	sel num p 
		| (num == 1) = (x p)
		| (num == 2) = (y p)
		| (num == 3) = (z p)

	dim _ = 3
	child e1 e2 (l:ls) 
		| (l == 1) && ((x e1) > (x e2)) = 4 + child e1 e2 ls
		| (l == 1) 						= child e1 e2 ls
		| (l == 2) && ((y e1) > (y e2)) = 2 + child e1 e2 ls
		| (l == 2) 						= child e1 e2 ls
		| (l == 3) && ((z e1) > (z e2)) = 1 + child e1 e2 ls
		| (l == 3) 						= child e1 e2 ls



	list2Point (x:y:z) = Point3d x y (head z)
	dist p1 p2 = sqrt (dx*dx + dy*dy + dz*dz) 
		where 
            dx = (x p1) - (x p2)
            dy = (y p1) - (y p2)
            dz = (z p1) - (z p2)

instance Eq Point3d where
	p1 == p2  = ((x p1) == (x p2)) && ((y p1) == (y p2)) && ((z p1) == (z p2))
instance Show Point3d where
	show p = "("++show (x p)++","++show (y p)++","++show (z p)++")"
	

data Kd2nTree a = Node a  [Int] [Kd2nTree a] | Empty 

instance Eq a => Eq (Kd2nTree a) where
    Empty == Empty = True
    _     == Empty = False
    Empty == _     = False
    (Node x l t) == (Node x2 l2 t2) = x==x2 && l==l2 && t==t2

instance Show a => Show (Kd2nTree a) where
	show (Node x l []) = show x ++ " " ++ show l ++"\n"
	show (Node x l t)  = show x ++ " " ++ show l ++"\n"++"    " ++ "<"++show (child x t l)++ "> " ++ show t
instance Point a => Point (Kd2nTree a) where

