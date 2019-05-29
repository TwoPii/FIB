multEq :: Int -> Int -> [Int]

multEq x y = iterate (*t) 1
	where t = x * y 

selectFirst :: [Int] -> [Int] -> [Int] -> [Int]

selectFirst [] _ _ = []

selectFirst x [] l2 = []
selectFirst (x:xs) l1 l2 
	| (selectFirst' x l1 l2) = [x]++(selectFirst xs l1 l2)
	| otherwise 			= selectFirst xs l1 l2

selectFirst' :: Int ->[Int] -> [Int] -> Bool

selectFirst' x []  _        = False
selectFirst' x (y:ys) []
	| (x == y) 				= True
	| otherwise				= selectFirst' x ys []
selectFirst' x [] (z:zs)	= False
selectFirst' x (y:ys) (z:zs)
	| (x == y) && (x == z) 	= False
	| (x == y) 				= True
	| (x == z)				= False
	| otherwise 			= selectFirst' x ys zs

myIterate :: (a -> a) -> a -> [a]

myIterate f x = scanl (\t _ -> f t) x (repeat x) 

type SymTab a = String -> Maybe a

empty :: SymTab a

empty = (\ _ -> Nothing)

get :: SymTab a -> String -> Maybe a

get t str  = t str
 

set :: SymTab a -> String -> a -> SymTab a

set taula str vas x 
	| (x == str) = Just vas
	| otherwise  = taula x 