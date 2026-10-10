import Fpil.Ch03.PositiveNumbers.Basic
open «3.1. Positive Numbers»
namespace Example
/--
info: failed to synthesize instance of type class
  OfNat Pos 7
numerals are polymorphic in Lean, but the numeral `7` cannot be used in a context where the expected type is
  Pos
due to the absence of the instance above

Hint: Type class instance resolution failures can be inspected with the `set_option trace.Meta.synthInstance true` command.
-/
#guard_msgs in
#check_failure (7 : Pos)

/--
Instead of the numeric literal, the constructors must be used directly
-/
def seven : Pos :=
  Pos.succ (Pos.succ (Pos.succ (Pos.succ (Pos.succ (Pos.succ Pos.one)))))

/--
info: seven + seven : Pos
---
error: unexpected success
-/
#guard_msgs in
#check_failure seven + seven

/--
info: failed to synthesize instance of type class
  HMul Pos Pos ?m.3

Hint: Type class instance resolution failures can be inspected with the `set_option trace.Meta.synthInstance true` command.
-/
#guard_msgs in
#check_failure seven * seven

class Plus (α : Type) where
  plus : α → α → α

open Plus (plus)

instance : Plus Nat where
  plus := Nat.add

/--
info: instPlusNat
-/
#guard_msgs in
#synth Plus Nat

/--
info: @[instance_reducible] def Example.instPlusNat : Plus Nat :=
{ plus := Nat.add }
-/
#guard_msgs in
#print instPlusNat

instance : Plus Pos where
  plus := Pos.plus

/-- info: 14 -/
#guard_msgs in
#eval plus 7 7

/--
info: «3.1. Positive Numbers».Pos.succ
  («3.1. Positive Numbers».Pos.succ
    («3.1. Positive Numbers».Pos.succ
      («3.1. Positive Numbers».Pos.succ
        («3.1. Positive Numbers».Pos.succ
          («3.1. Positive Numbers».Pos.succ
            («3.1. Positive Numbers».Pos.succ
              («3.1. Positive Numbers».Pos.succ
                («3.1. Positive Numbers».Pos.succ
                  («3.1. Positive Numbers».Pos.succ
                    («3.1. Positive Numbers».Pos.succ
                      («3.1. Positive Numbers».Pos.succ
                        («3.1. Positive Numbers».Pos.succ («3.1. Positive Numbers».Pos.one)))))))))))))
-/
#guard_msgs in
#eval plus seven seven

def fourteen : Pos := seven + seven

/--
info: «3.1. Positive Numbers».Pos.succ
  («3.1. Positive Numbers».Pos.succ
    («3.1. Positive Numbers».Pos.succ
      («3.1. Positive Numbers».Pos.succ
        («3.1. Positive Numbers».Pos.succ
          («3.1. Positive Numbers».Pos.succ
            («3.1. Positive Numbers».Pos.succ
              («3.1. Positive Numbers».Pos.succ
                («3.1. Positive Numbers».Pos.succ
                  («3.1. Positive Numbers».Pos.succ
                    («3.1. Positive Numbers».Pos.succ
                      («3.1. Positive Numbers».Pos.succ
                        («3.1. Positive Numbers».Pos.succ («3.1. Positive Numbers».Pos.one)))))))))))))
-/
#guard_msgs in
#eval fourteen

end Example
