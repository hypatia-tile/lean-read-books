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

section

/--
info: instAddPos
-/
#guard_msgs in
#synth Add Pos

/--
info: instMulPos
-/
#guard_msgs in
#synth Mul Pos

attribute [-instance] instAddPos instMulPos

/--
info: failed to synthesize instance of type class
  HAdd Pos Pos ?m.3

Hint: Type class instance resolution failures can be inspected with the `set_option trace.Meta.synthInstance true` command.
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
end

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
info: 14
-/
#guard_msgs in
#eval plus seven seven

def fourteen : Pos := seven + seven

/--
info: 14
-/
#guard_msgs in
#eval fourteen

/--
info: class Add.{u} (α : Type u) : Type u
number of parameters: 1
fields:
  Add.add : α → α → α
constructor:
  Add.mk.{u} {α : Type u} (add : α → α → α) : Add α
-/
#guard_msgs in
#print Add

/--
info: class Zero.{u} (α : Type u) : Type u
number of parameters: 1
fields:
  Zero.zero : α
constructor:
  Zero.mk.{u} {α : Type u} (zero : α) : Zero α
-/
#guard_msgs in
#print Zero

/--
info: class One.{u} (α : Type u) : Type u
number of parameters: 1
fields:
  One.one : α
constructor:
  One.mk.{u} {α : Type u} (one : α) : One α
-/
#guard_msgs in
#print One

/--
info: class OfNat.{u} (α : Type u) : Nat → Type u
number of parameters: 2
fields:
  OfNat.ofNat : α
constructor:
  OfNat.mk.{u} {α : Type u} {x✝ : Nat} (ofNat : α) : OfNat α x✝
-/
#guard_msgs in
#print OfNat

inductive LT4 where
  | zero
  | one
  | two
  | three
  deriving DecidableEq

instance : OfNat LT4 0 where
  ofNat := .zero

instance : OfNat LT4 1 where
  ofNat := .one

instance : OfNat LT4 2 where
  ofNat := .two

instance : OfNat LT4 3 where
  ofNat := .three

#guard (0 : LT4) = .zero
#guard (1 : LT4) = .one
#guard (2 : LT4) = .two
#guard (3 : LT4) = .three

/--
info: failed to synthesize instance of type class
  OfNat LT4 4
numerals are polymorphic in Lean, but the numeral `4` cannot be used in a context where the expected type is
  LT4
due to the absence of the instance above

Hint: Type class instance resolution failures can be inspected with the `set_option trace.Meta.synthInstance true` command.
-/
#guard_msgs in
#check_failure (4 : LT4)

end Example
