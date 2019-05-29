 
data Tree a = Node a (Tree a) (Tree a) | Empty deriving (Show)

size :: Tree a -> Int

size Empty  = 0
size (Node x t1 t2) = 1 + size t1 + size t2 

height :: Tree a -> Int 

height Empty = 0
height (Node x t1 t2) = 1 + if(height t1 > height t2) then height t1 else height t2

equal :: Eq a => Tree a -> Tree a -> Bool

equal Empty Empty = True
equal Empty _ = False
equal _ Empty = False
equal (Node x1 l1 r1) (Node x2 l2 r2) = x1 == x2 && equal l1 l2 && equal r1 r2

isomorphic :: Eq a => Tree a -> Tree a -> Bool

isomorphic  Empty Empty = True
isomorphic  Empty _ = False
isomorphic  _ Empty = False
isomorphic (Node x1 l1 r1) (Node x2 l2 r2) = (x1 == x2) && ((isomorphic l1 l2 && isomorphic r1 r2) || (isomorphic l1 r1 && isomorphic l2 r2))

preOrder :: Tree a -> [a] 

preOrder Empty  = []
preOrder (Node x l r) = [x]++(preOrder l)++(preOrder r)

postOrder :: Tree a -> [a]

postOrder Empty = []
postOrder (Node x l r) = (postOrder l)++(postOrder r)++[x]

inOrder :: Tree a -> [a]

inOrder Empty = []
inOrder (Node x l r) = (inOrder l)++[x]++(inOrder r)


bfs :: [Tree a] -> [a]    
    
bfs [] = []
bfs (Empty:xs) = bfs xs
bfs ((Node x l r):xs) = x : (bfs $ xs ++ [l,r])

breadthFirst :: Tree a -> [a]

breadthFirst t = bfs [t]


