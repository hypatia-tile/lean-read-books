/-!
# 3.1. Positive Numbers — Exercise: Another Representation

<https://lean-lang.org/functional_programming_in_lean/Overloading-and-Type-Classes/Positive-Numbers/>

Represent a positive number as the successor of some `Nat`:

```
structure Pos where
  succ ::
  pred : Nat
```

Define instances of `Add`, `Mul`, `ToString`, and `OfNat` that allow this
version of `Pos` to be used conveniently.
-/
namespace «3.1. Positive Numbers».Exercises.AnotherRepresentation

structure Pos where
  succ ::
  pred : Nat
  deriving DecidableEq

def Pos.toNat (n : Pos) : Nat :=
  .succ n.pred

/--
Addition: n + m = ((n - 1) + (m - 1) + 1) + 1
-/
def Pos.add (n : Pos) (m : Pos) : Pos :=
  Pos.succ <| Nat.succ <| n.pred + m.pred

/--
Multiplication: nm = (n - 1)(m - 1) + (m - 1) + (n - 1) + 1
-/
def Pos.mul (n : Pos) (m : Pos) : Pos :=
  let n := n.pred
  let m := m.pred
  Pos.succ <| n * m + n + m

instance : Add Pos where
  add := Pos.add

instance : Mul Pos where
  mul := Pos.mul

instance : ToString Pos where
  toString n := toString <| n.toNat

instance {n} : OfNat Pos (n + 1) where
  ofNat := .succ n

#guard 7 = Pos.succ 6
#guard 3 + 4 = Pos.succ 6
#guard 6 * 7 = Pos.succ 41
#guard s!"seven: {(1 + 2 * 3 : Pos)}" = "seven: 7"

/--
info: structure «3.1. Positive Numbers».Exercises.AnotherRepresentation.Pos : Type
number of parameters: 0
fields:
  «3.1. Positive Numbers».Exercises.AnotherRepresentation.Pos.pred : Nat
constructor:
  «3.1. Positive Numbers».Exercises.AnotherRepresentation.Pos.succ (pred : Nat) : Pos
-/
#guard_msgs in
#print Pos


end «3.1. Positive Numbers».Exercises.AnotherRepresentation
