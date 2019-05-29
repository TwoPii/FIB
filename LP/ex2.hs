pot :: Int -> Int -> Int

pot x 0 = 1
pot x y = x * pot x (y-1)


llargada :: [Int] -> Int

llargada [] = 0
llargada (cap:cua) = 1 + llargada cua
--llargada (x:xs) = 1 + llargada xs
--llargada (_:xs) = 1 + llargada xs --> x no importa, variable _, que cada _ es diferent

