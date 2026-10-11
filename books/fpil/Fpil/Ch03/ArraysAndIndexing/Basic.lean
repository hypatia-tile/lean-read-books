import Fpil.Ch03.ControllingInstanceSearch.Basic
open «3.1. Positive Numbers»
open «3.2. Type Classes and Polymorphism»
open «3.3. Controlling Instance Search»
/-!
# 3.4. Arrays and Indexing

<https://lean-lang.org/functional_programming_in_lean/Overloading-and-Type-Classes/Arrays-and-Indexing/>

The main definitions of the section.

- 3.4.1. Arrays
- 3.4.2. Non-Empty Lists
- 3.4.3. Overloading Indexing
-/
namespace «3.4. Arrays and Indexing»

def northernTrees : Array String :=
  #["sloe", "birch", "elm", "oak"]

structure NonEmptyList (α : Type) : Type where
  head : α
  tail : List α

def idahoSpiders : NonEmptyList String := {
  head := "Banded Garden Spider",
  tail := [
    "Long-legged Sac Spider",
    "Wolf Spider",
    "Hobo Spider",
    "Cat-faced Spider"
  ]
}

def NonEmptyList.get? : NonEmptyList α → Nat → Option α
  | xs, 0 => some xs.head
  | xs, n + 1 => xs.tail[n]?

abbrev NonEmptyList.inBounds (xs : NonEmptyList α) (i : Nat) : Prop :=
  i ≤ xs.tail.length

theorem atLeastThreeSpiders : idahoSpiders.inBounds 2 := by decide
theorem notSixSpiders : ¬idahoSpiders.inBounds 5 := by decide

def NonEmptyList.get (xs : NonEmptyList α) (i : Nat) (ok : xs.inBounds i) : α :=
  match i with
  | 0 => xs.head
  | n + 1 => xs.tail[n]

instance : GetElem (NonEmptyList α) Nat α NonEmptyList.inBounds where
  getElem := NonEmptyList.get

end «3.4. Arrays and Indexing»
