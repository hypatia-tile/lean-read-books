/-!
# 3.1. Positive Numbers — Exercise: Even Numbers

<https://lean-lang.org/functional_programming_in_lean/Overloading-and-Type-Classes/Positive-Numbers/>

Define a datatype that represents only even numbers. Define instances of
`Add`, `Mul`, and `ToString` that allow it to be used conveniently.
`OfNat` requires a feature that is introduced in the next section.
-/
namespace «3.1. Positive Numbers».Exercises.EvenNumbers

structure Even where
  double ::
  half : Nat
  deriving DecidableEq

def Even.toNat (n : Even) : Nat :=
  n.half * 2

def Even.add (n : Even) (m : Even) : Even :=
  let n := n.half
  let m := m.half
  Even.double <| n + m

def Even.mul (n : Even) (m : Even) : Even :=
  let n := n.half
  let m := m.half
  Even.double <| n * m * 2

instance : ToString Even where
  toString n := toString <| n.toNat

instance : Add Even where
  add := Even.add

instance : Mul Even where
  mul := Even.mul

instance : Zero Even where
  zero := Even.double Nat.zero

instance [h : OfNat Even n] : OfNat Even (n + 2) where
  ofNat := Even.double <| Nat.succ <| h.ofNat.half

#guard (2 : Even) = Even.double 1
#guard (2 + 14 : Even) = 16
#guard (6 * 8 : Even) = 48

/--
info: failed to synthesize instance of type class
  OfNat Even 3
numerals are polymorphic in Lean, but the numeral `3` cannot be used in a context where the expected type is
  Even
due to the absence of the instance above

Hint: Type class instance resolution failures can be inspected with the `set_option trace.Meta.synthInstance true` command.
-/
#guard_msgs in
#check_failure (3 : Even)

end «3.1. Positive Numbers».Exercises.EvenNumbers
