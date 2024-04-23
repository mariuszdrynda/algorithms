data Q = F | S | HALT --set of states

data Gamma = Z | O | B --zero, one or blank
    deriving(Show)

data TuringMachine = TuringMachine [Gamma] Int
    deriving(Show)

update_tape :: [Gamma] -> Int -> Gamma -> [Gamma]
update_tape (x:xs) 0 value = value : xs
update_tape (x:xs) index value = x : update_tape xs (index - 1) value

subtractOne :: Q -> TuringMachine -> TuringMachine
subtractOne F (TuringMachine memoryTape positionOfHead) = case memoryTape !! positionOfHead of
    Z -> subtractOne F (TuringMachine memoryTape (positionOfHead + 1))
    O -> subtractOne F (TuringMachine memoryTape (positionOfHead + 1))
    B -> subtractOne S (TuringMachine memoryTape (positionOfHead - 1))
subtractOne S (TuringMachine memoryTape positionOfHead) = case memoryTape !! positionOfHead of
    Z -> subtractOne S (TuringMachine (update_tape memoryTape positionOfHead O) (positionOfHead - 1))
    O -> subtractOne HALT (TuringMachine (update_tape memoryTape positionOfHead Z) positionOfHead)
    B -> subtractOne HALT (TuringMachine memoryTape positionOfHead)
subtractOne HALT tm = tm

main = do print $ subtractOne q0 (TuringMachine initialMemoryTape initialPositionOfHead) --works for any positive integer
    where
        initialMemoryTape = [O, Z, Z, Z, Z, Z, B] --has to ends with B
        initialPositionOfHead = 0
        q0 = F