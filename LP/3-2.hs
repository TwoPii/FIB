data Queue a = Queue [a] [a] deriving (Show)
 
create :: Queue a

create = Queue [] []
 

push :: a -> Queue a -> Queue a

push x (Queue l1 l2) = Queue l1 (x:l2) 

top :: Queue a -> a

top (Queue (m:ms) _) = m
top (Queue [] (x:xs)) =  top' xs
    where top' (y:ys) = if(null ys) then y else top' ys
          
pop :: Queue a -> Queue a

pop (Queue [] []) = Queue [] []
pop (Queue (x:xs) []) = Queue xs []
pop (Queue [] (l2)) = pop (Queue (reverse l2) [])
pop (Queue (x:xs) l2) = Queue xs l2

empty :: Queue a -> Bool

empty (Queue [] []) = True
empty (Queue _ _ ) = False

instance Eq a => Eq (Queue a)
    where
        (Queue x1s y1s) == (Queue x2s y2s) = (x1s++(reverse y1s)) ==  (x2s++(reverse y2s))

   
