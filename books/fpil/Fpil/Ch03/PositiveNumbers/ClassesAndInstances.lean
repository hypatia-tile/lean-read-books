import Fpil.Ch03.PositiveNumbers.Basic
open «3.1. Positive Numbers»
namespace Example

/--
Instead of the numeric literal, the constructors must be used directly
-/
def seven : Pos :=
  Pos.succ (Pos.succ (Pos.succ (Pos.succ (Pos.succ (Pos.succ Pos.one)))))

section

/--
info: instOfNatPosHAddNatOfNat
-/
#guard_msgs in
#synth OfNat Pos 1

attribute [-instance] instOfNatPosHAddNatOfNat

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

/--
info: instOfNatPosHAddNatOfNat
-/
#guard_msgs in
#synth OfNat Pos 256

/--
info: @[instance_reducible] def «3.1. Positive Numbers».instOfNatPosHAddNatOfNat : {n : Nat} → OfNat Pos (n + 1) :=
fun {n} => { ofNat := instOfNatPosHAddNatOfNat.natPlusOne n }
-/
#guard_msgs in
#print instOfNatPosHAddNatOfNat

section «trace meta synthInstance»
set_option trace.Meta.synthInstance true
/--
info: failed to synthesize instance of type class
  OfNat Pos 0
numerals are polymorphic in Lean, but the numeral `0` cannot be used in a context where the expected type is
  Pos
due to the absence of the instance above
---
trace: [Meta.synthInstance] ❌️ OfNat Pos 0
  [Meta.synthInstance] ✅️ new goal OfNat Pos 0
    [Meta.synthInstance.instances] #[@Lean.Grind.Semiring.ofNat, @Zero.toOfNat0, @instOfNatPosHAddNatOfNat]
  [Meta.synthInstance.apply] ❌️ apply @instOfNatPosHAddNatOfNat to OfNat Pos 0
    [Meta.synthInstance.tryResolve] ❌️ OfNat Pos 0 ≟ OfNat Pos (?m.4 + 1)
  [Meta.synthInstance.apply] ✅️ apply @Zero.toOfNat0 to OfNat Pos 0
    [Meta.synthInstance.tryResolve] ✅️ OfNat Pos 0 ≟ OfNat Pos 0
    [Meta.synthInstance] ✅️ new goal Zero Pos
      [Meta.synthInstance.instances] #[@Lean.Grind.AddCommMonoid.toZero, @Zero.ofOfNat0]
  [Meta.synthInstance.apply] ✅️ apply @Zero.ofOfNat0 to Zero Pos
    [Meta.synthInstance.tryResolve] ✅️ Zero Pos ≟ Zero Pos
  [Meta.synthInstance.apply] ✅️ apply @Lean.Grind.AddCommMonoid.toZero to Zero Pos
    [Meta.synthInstance.tryResolve] ✅️ Zero Pos ≟ Zero Pos
    [Meta.synthInstance] ✅️ new goal Lean.Grind.AddCommMonoid Pos
      [Meta.synthInstance.instances] #[@Lean.Grind.AddCommGroup.toAddCommMonoid, @Lean.Grind.NatModule.toAddCommMonoid]
  [Meta.synthInstance.apply] ✅️ apply @Lean.Grind.NatModule.toAddCommMonoid to Lean.Grind.AddCommMonoid Pos
    [Meta.synthInstance.tryResolve] ✅️ Lean.Grind.AddCommMonoid Pos ≟ Lean.Grind.AddCommMonoid Pos
    [Meta.synthInstance] ✅️ new goal Lean.Grind.NatModule Pos
      [Meta.synthInstance.instances] #[@Lean.Grind.IntModule.toNatModule, @Lean.Grind.Semiring.toNatModule]
  [Meta.synthInstance.apply] ✅️ apply @Lean.Grind.Semiring.toNatModule to Lean.Grind.NatModule Pos
    [Meta.synthInstance.tryResolve] ✅️ Lean.Grind.NatModule Pos ≟ Lean.Grind.NatModule Pos
    [Meta.synthInstance] ✅️ new goal Lean.Grind.Semiring Pos
      [Meta.synthInstance.instances] #[@Lean.Grind.Ring.toSemiring, @Lean.Grind.CommSemiring.toSemiring]
  [Meta.synthInstance.apply] ✅️ apply @Lean.Grind.CommSemiring.toSemiring to Lean.Grind.Semiring Pos
    [Meta.synthInstance.tryResolve] ✅️ Lean.Grind.Semiring Pos ≟ Lean.Grind.Semiring Pos
    [Meta.synthInstance] ✅️ new goal Lean.Grind.CommSemiring Pos
      [Meta.synthInstance.instances] #[@Lean.Grind.CommRing.toCommSemiring]
  [Meta.synthInstance.apply] ✅️ apply @Lean.Grind.CommRing.toCommSemiring to Lean.Grind.CommSemiring Pos
    [Meta.synthInstance.tryResolve] ✅️ Lean.Grind.CommSemiring Pos ≟ Lean.Grind.CommSemiring Pos
    [Meta.synthInstance] ✅️ new goal Lean.Grind.CommRing Pos
      [Meta.synthInstance.instances] #[@Lean.Grind.Field.toCommRing]
  [Meta.synthInstance.apply] ✅️ apply @Lean.Grind.Field.toCommRing to Lean.Grind.CommRing Pos
    [Meta.synthInstance.tryResolve] ✅️ Lean.Grind.CommRing Pos ≟ Lean.Grind.CommRing Pos
    [Meta.synthInstance] ✅️ no instances for Lean.Grind.Field Pos
      [Meta.synthInstance.instances] #[]
  [Meta.synthInstance.apply] ✅️ apply @Lean.Grind.Ring.toSemiring to Lean.Grind.Semiring Pos
    [Meta.synthInstance.tryResolve] ✅️ Lean.Grind.Semiring Pos ≟ Lean.Grind.Semiring Pos
    [Meta.synthInstance] ✅️ new goal Lean.Grind.Ring Pos
      [Meta.synthInstance.instances] #[@Lean.Grind.CommRing.toRing]
  [Meta.synthInstance.apply] ✅️ apply @Lean.Grind.CommRing.toRing to Lean.Grind.Ring Pos
    [Meta.synthInstance.tryResolve] ✅️ Lean.Grind.Ring Pos ≟ Lean.Grind.Ring Pos
  [Meta.synthInstance.apply] ✅️ apply @Lean.Grind.IntModule.toNatModule to Lean.Grind.NatModule Pos
    [Meta.synthInstance.tryResolve] ✅️ Lean.Grind.NatModule Pos ≟ Lean.Grind.NatModule Pos
    [Meta.synthInstance] ✅️ new goal Lean.Grind.IntModule Pos
      [Meta.synthInstance.instances] #[@Lean.Grind.Ring.toIntModule]
  [Meta.synthInstance.apply] ✅️ apply @Lean.Grind.Ring.toIntModule to Lean.Grind.IntModule Pos
    [Meta.synthInstance.tryResolve] ✅️ Lean.Grind.IntModule Pos ≟ Lean.Grind.IntModule Pos
  [Meta.synthInstance.apply] ✅️ apply @Lean.Grind.AddCommGroup.toAddCommMonoid to Lean.Grind.AddCommMonoid Pos
    [Meta.synthInstance.tryResolve] ✅️ Lean.Grind.AddCommMonoid Pos ≟ Lean.Grind.AddCommMonoid Pos
    [Meta.synthInstance] ✅️ new goal Lean.Grind.AddCommGroup Pos
      [Meta.synthInstance.instances] #[@Lean.Grind.IntModule.toAddCommGroup, @Lean.Grind.Ring.toAddCommGroup]
  [Meta.synthInstance.apply] ✅️ apply @Lean.Grind.Ring.toAddCommGroup to Lean.Grind.AddCommGroup Pos
    [Meta.synthInstance.tryResolve] ✅️ Lean.Grind.AddCommGroup Pos ≟ Lean.Grind.AddCommGroup Pos
  [Meta.synthInstance.apply] ✅️ apply @Lean.Grind.IntModule.toAddCommGroup to Lean.Grind.AddCommGroup Pos
    [Meta.synthInstance.tryResolve] ✅️ Lean.Grind.AddCommGroup Pos ≟ Lean.Grind.AddCommGroup Pos
  [Meta.synthInstance.apply] ✅️ apply @Lean.Grind.Semiring.ofNat to OfNat Pos 0
    [Meta.synthInstance.tryResolve] ✅️ OfNat Pos 0 ≟ OfNat Pos 0
  [Meta.synthInstance] result <not-available>
-/
#guard_msgs in
#check_failure (0 : Pos)

/--
info: 1 : Pos
---
trace: [Meta.synthInstance] ✅️ OfNat Pos 1
  [Meta.synthInstance] ✅️ new goal OfNat Pos 1
    [Meta.synthInstance.instances] #[@Lean.Grind.Semiring.ofNat, @One.toOfNat1, @instOfNatPosHAddNatOfNat]
  [Meta.synthInstance.apply] ✅️ apply @instOfNatPosHAddNatOfNat to OfNat Pos 1
    [Meta.synthInstance.tryResolve] ✅️ OfNat Pos 1 ≟ OfNat Pos (0 + 1)
    [Meta.synthInstance.answer] ✅️ OfNat Pos 1
  [Meta.synthInstance] result instOfNatPosHAddNatOfNat
-/
#guard_msgs in
#check (1 : Pos)
end «trace meta synthInstance»

end Example
