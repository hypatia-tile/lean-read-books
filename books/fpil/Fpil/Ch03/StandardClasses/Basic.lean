import Fpil.Ch03.ArraysAndIndexing.Basic
open «3.1. Positive Numbers»
open «3.2. Type Classes and Polymorphism»
open «3.3. Controlling Instance Search»
open «3.4. Arrays and Indexing»
/-!
# 3.5. Standard Classes

<https://lean-lang.org/functional_programming_in_lean/Overloading-and-Type-Classes/Standard-Classes/>

The main definitions of the section.

- 3.5.1. Arithmetic
- 3.5.2. Bitwise Operators
- 3.5.3. Equality and Ordering
- 3.5.4. Hashing
- 3.5.5. Deriving Standard Classes
- 3.5.6. Appending
- 3.5.7. Functors
- 3.5.8. Messages You May Meet
- 3.5.9. Exercises
-/
namespace «3.5. Standard Classes»

def Pos.comp : Pos → Pos → Ordering
  | .one, .one => Ordering.eq
  | .one, .succ _ => Ordering.lt
  | .succ _, .one => Ordering.gt
  | .succ n, .succ k => comp n k

instance : Ord Pos where
  compare := Pos.comp

instance : LT Pos where
  lt x y := LT.lt x.toNat y.toNat
instance : LE Pos where
  le x y := LE.le x.toNat y.toNat

instance {x : Pos} {y : Pos} : Decidable (x < y) :=
  (inferInstance : Decidable (x.toNat < y.toNat))

instance {x : Pos} {y : Pos} : Decidable (x ≤ y) :=
  (inferInstance : Decidable (x.toNat ≤ y.toNat))

#guard (3 : Pos) ≤ (5 : Pos)
#guard compare (3 : Pos) (5 : Pos) = .lt

def Pos.hashPos : Pos → UInt64
  | .one => 0
  | Pos.succ n => mixHash 1 (hashPos n)

instance : Hashable Pos where
  hash := Pos.hashPos

instance [Hashable α] : Hashable (NonEmptyList α) where
  hash xs := mixHash (hash xs.head) (hash xs.tail)

inductive BinTree (α : Type) where
  | leaf : BinTree α
  | branch : BinTree α → α → BinTree α → BinTree α
  deriving DecidableEq

-- def eqBinTree [BEq α] : BinTree α → BinTree α → Bool
--   | BinTree.leaf, BinTree.leaf => true
--   | BinTree.branch l x r, BinTree.branch l2 x2 r2 =>
--     x == x2 && eqBinTree l l2 && eqBinTree r r2

def eqBinTree [BEq α] : BinTree α → BinTree α → Bool
  | BinTree.leaf, BinTree.leaf =>
    true
  | BinTree.branch l x r, BinTree.branch l2 x2 r2 =>
    x == x2 && eqBinTree l l2 && eqBinTree r r2
  | _, _ =>
    false

end «3.5. Standard Classes»
