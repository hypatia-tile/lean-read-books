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

def Pos.mul : Pos → Pos → Pos
  | .one, k => k
  | .succ n, k => n.mul k + k

instance : Mul Pos where
  mul := Pos.mul

def Pos.toNat : Pos → Nat
  | .one => 1
  | .succ n => .succ <| n.toNat

instance : ToString Pos where
  toString x := toString (x.toNat)

end «3.1. Positive Numbers»
