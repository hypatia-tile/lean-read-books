import Fpil.Ch03.Coercions.Basic
open «3.1. Positive Numbers»
open «3.2. Type Classes and Polymorphism»
open «3.3. Controlling Instance Search»
open «3.4. Arrays and Indexing»
open «3.5. Standard Classes»
open «3.6. Coercions»
/-!
# 3.7. Additional Conveniences

<https://lean-lang.org/functional_programming_in_lean/Overloading-and-Type-Classes/Additional-Conveniences/>

The main definitions of the section.

- 3.7.1. Constructor Syntax for Instances
- 3.7.2. Examples
-/
namespace «3.7. Additional Conveniences»

structure Tree : Type where
  latinName : String
  commonNames : List String

def oak : Tree :=
  ⟨"Quercus robur", ["common oak", "European oak"]⟩

def birch : Tree :=
  { latinName := "Betula pendula",
    commonNames := ["silver birch", "warty birch"]
  }

def sloe : Tree where
  latinName := "Prunus spinosa"
  commonNames := ["sloe", "blackthorn"]

class Display (α : Type) where
  displayName : α → String

instance : Display Tree :=
  ⟨Tree.latinName⟩

instance : Display Tree :=
  { displayName := Tree.latinName }

instance : Display Tree where
  displayName t := t.latinName

example : NonEmptyList String :=
  { head := "Sparrow",
    tail := ["Duck", "Swan", "Magpie", "Eurasian coot", "Crow"]
  }

example (n : Nat) (k : Nat) : Bool :=
  n + k == k + n

end «3.7. Additional Conveniences»
