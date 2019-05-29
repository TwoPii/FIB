main :: IO ()

main =  do 
        (x:xs) <- getLine
        if ((x == 'A') || x == 'a') then putStrLn ("Hello!")
                    else putStrLn ("Bye!")
