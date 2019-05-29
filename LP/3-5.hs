data Expr = Val Int | Add Expr Expr | Sub Expr Expr | Mul Expr Expr | Div Expr Expr

eval1 :: Expr -> Int

eval1 (Val x) = x
eval1 (Add expr1 expr2) = eval1 expr1 + eval1 expr2
eval1 (Sub expr1 expr2) = eval1 expr1 - eval1 expr2
eval1 (Mul expr1 expr2) = eval1 expr1 * eval1 expr2
eval1 (Div expr1 expr2) = div (eval1 expr1) (eval1 expr2)

eval2 :: Expr -> Maybe Int

eval2 (Val x) = Just x
eval2 (Add expr1 expr2) = do{i<-eval2 expr1; j<-eval2 expr2; Just (i + j)}
eval2 (Sub expr1 expr2) = do{i<-eval2 expr1; j<-eval2 expr2; Just (i - j)}
eval2 (Mul expr1 expr2) = do{i<-eval2 expr1; j<-eval2 expr2; Just (i * j)}
eval2 (Div expr1 expr2) = do{i<-eval2 expr1; j<-eval2 expr2; if(j == 0) then Nothing else Just (div i j)}

eval3 :: Expr -> Either String Int

eval3 (Val x) = Right x
eval3 (Add expr1 expr2) = do{i<-eval3 expr1; j<-eval3 expr2; Right (i + j)}
eval3 (Sub expr1 expr2) = do{i<-eval3 expr1; j<-eval3 expr2; Right (i - j)}
eval3 (Mul expr1 expr2) = do{i<-eval3 expr1; j<-eval3 expr2; Right (i * j)}
eval3 (Div expr1 expr2) = do{i<-eval3 expr1; j<-eval3 expr2; if(j == 0) then Left "div0" else Right (div i j)}
