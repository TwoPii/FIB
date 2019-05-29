main :: IO ()

main = do
    l <- getLine
    let w = words l
    if((head w) == "*")    then return ()
                    else awesome w
    if((head w) /= "*") then main else return ()
        

    
    
awesome :: [String] -> IO ()

awesome x = putStrLn "t"
