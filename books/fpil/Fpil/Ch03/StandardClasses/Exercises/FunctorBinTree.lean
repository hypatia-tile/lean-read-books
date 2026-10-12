import Fpil.Ch03.StandardClasses.Basic
open «3.1. Positive Numbers»
open «3.2. Type Classes and Polymorphism»
open «3.3. Controlling Instance Search»
open «3.4. Arrays and Indexing»
open «3.5. Standard Classes»
/-!
# 3.5. Standard Classes — Exercise 3.5.9 (2)

<https://lean-lang.org/functional_programming_in_lean/Overloading-and-Type-Classes/Standard-Classes/>

Implement a `Functor` instance for the binary tree datatype.
-/
namespace «3.5. Standard Classes».Exercises.FunctorBinTree

def BinTree.map (f : α → β) : BinTree α → BinTree β
  | .leaf => .leaf
  | .branch l x r => .branch (map f l) (f x) (map f r)

instance : Functor BinTree where
  map := BinTree.map

end «3.5. Standard Classes».Exercises.FunctorBinTree
