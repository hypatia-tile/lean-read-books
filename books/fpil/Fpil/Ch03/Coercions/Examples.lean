import Fpil.Ch03.Coercions.Basic
open «3.1. Positive Numbers»
open «3.2. Type Classes and Polymorphism»
open «3.3. Controlling Instance Search»
open «3.4. Arrays and Indexing»
open «3.5. Standard Classes»
/-!
# 3.6. Coercions — Examples

Examples and experiments around the definitions in `Basic`.
-/
namespace «3.6. Coercions».Example

inductive A where
  | a

inductive B where
  | b

instance : Coe A B where
  coe _ := B.b

instance : Coe B A where
  coe _ := A.a

instance : Coe Unit A where
  coe _ := A.a

def coercedToB : B := ()

/-- info: «3.6. Coercions».Example.B.b -/
#guard_msgs in
#eval coercedToB

def List.last? : List α → Option α
  | [] => none
  | [x] => x
  | _ :: x :: xs => last? (x :: xs)

def perhapsPerhapsPerhaps : Option (Option (Option String)) :=
  "Please don't tell me"

/-- info: some (some (some "Please don't tell me")) -/
#guard_msgs in
#eval perhapsPerhapsPerhaps

def perhapsPerhapsPerhapsNat : Option (Option (Option Nat)) :=
  ↑(392 : Nat)

end «3.6. Coercions».Example
