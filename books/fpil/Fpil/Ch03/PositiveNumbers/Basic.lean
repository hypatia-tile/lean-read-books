namespace «3.1. Positive Numbers»

/--
Positive numbers:
In some applications, only positive numbers make sense.
-/
inductive Pos : Type where
  | one
  | succ (n : Pos)

def Pos.plus : Pos → Pos → Pos
  | .one, k => .succ k
  | .succ n, k => .succ <| n.plus k

instance : Add Pos where
  add := Pos.plus

end «3.1. Positive Numbers»
