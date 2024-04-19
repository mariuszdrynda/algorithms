reverse : List a -> List a
reverse xs = let 
    revAcc : List a -> List a -> List a
    revAcc acc [] = acc
    revAcc acc (x :: xs) = revAcc (x :: acc) xs
    in revAcc [] xs 
-- reverse : List a -> List a
-- reverse = \xs => let 
--     revAcc : List a -> List a -> List a
--     revAcc = \acc => \l => case l of
--         [] => acc
--         (::) x xs => revAcc ((::) x acc) xs
--     in revAcc [] xs 