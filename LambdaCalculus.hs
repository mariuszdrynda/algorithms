--https://en.wikipedia.org/wiki/Lambda_calculus
--https://en.wikipedia.org/wiki/Church_encoding

data LC = APP LC LC
    | VAR String
    | LAM LC LC -- lambda abstraction
    deriving(Show, Eq)

exec :: LC -> LC
exec (APP (LAM (VAR name) y) z) = apply z name y
exec (LAM x y) = LAM (exec x) (exec y)
exec (APP x y) = APP (exec x) (exec y)
exec x = x

apply :: LC -> String -> LC -> LC
apply a name (LAM x y) = LAM (apply a name x) (apply a name y)
apply a name (APP x y) = APP (apply a name x) (apply a name y)
apply a name (VAR x) = if x == name then a else VAR x

is_free :: LC -> Bool
is_free (VAR _) = True
is_free (APP (LAM _ _) _) = False
is_free (APP x y) = is_free x && is_free y
is_free (LAM _ y) = is_free y

execute :: LC -> LC
execute x = if is_free x then x else execute $ exec x

-- examples
zero = LAM (VAR "f") (LAM (VAR "x") (VAR "x"))
one = LAM (VAR "f") (LAM (VAR "x") (APP (VAR "f") (VAR "x")))
two = LAM (VAR "f") (LAM (VAR "x") (APP (VAR "f") (APP (VAR "f") (VAR "x"))))
successor = LAM (VAR "n") (LAM (VAR "f") (LAM (VAR "x") (APP (VAR "f") (APP (APP (VAR "n") (VAR "f")) (VAR "x")))))
plus = LAM (VAR "m") (LAM (VAR "n") (LAM (VAR "f") (LAM (VAR "x") (APP (APP (VAR "m") (VAR "f")) (APP (APP (VAR "n") (VAR "f")) (VAR "x"))))))
true = LAM (VAR "a") (LAM (VAR "b") (VAR "a"))
true' = LAM (VAR "t.a") (LAM (VAR "t.b") (VAR "t.a"))
false = LAM (VAR "a") (LAM (VAR "b") (VAR "b"))
and' = LAM (VAR "p") (LAM (VAR "q") (APP (APP (VAR "p") (VAR "q")) (VAR "p")))
or' =  LAM (VAR "p") (LAM (VAR "q") (APP (APP (VAR "p") (VAR "p")) (VAR "q")))

main = do
    print $ execute (APP plus one)
    print $ execute (APP successor zero) == one --True
    print $ execute (APP successor (APP successor zero)) == two--True
    print $ execute (APP successor one) == two --True
    print $ execute (APP plus one) == successor --True
    print $ execute (APP (execute $ APP and' true) false) == false --True
    print $ execute (APP (execute $ APP or' false) false) == false --True
    print $ execute (APP true true) == (LAM (VAR "b") true) --True
    print $ execute (APP (APP true' true) false) == true --True
    -- for now there is a bug when we sometimes apply lambda abstraction to theirself
    -- print $ execute (APP (APP true true) false) == true --True
    -- print $ execute (APP (APP or' true) false) == true --True