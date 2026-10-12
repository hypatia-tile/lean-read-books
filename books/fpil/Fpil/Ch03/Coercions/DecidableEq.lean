import Fpil.Ch03.Coercions.Basic
open «3.1. Positive Numbers»
open «3.2. Type Classes and Polymorphism»
open «3.3. Controlling Instance Search»
open «3.4. Arrays and Indexing»
open «3.5. Standard Classes»
open «3.6. Coercions»
/-!
# 3.6. Coercions — Checks

`#guard` checks of the definitions in `Basic`, using derived `DecidableEq`
instances.
-/

#guard [1, 2, 3, 4].drop (2 : Pos) = [3, 4]

/-- info: List.drop (Pos.toNat 2) [1, 2, 3, 4] : List Nat -/
#guard_msgs in
#check [1, 2, 3, 4].drop (2 : Pos)

/--
info: def «3.6. Coercions».oneInt : Int :=
↑Pos.one.toNat
-/
#guard_msgs in
#print oneInt

