import Fpil.Ch03.StandardClasses.Basic
open «3.1. Positive Numbers»
open «3.2. Type Classes and Polymorphism»
open «3.3. Controlling Instance Search»
open «3.4. Arrays and Indexing»
open «3.5. Standard Classes»
/-!
# 3.5. Standard Classes — Exercise 3.5.9 (1)

<https://lean-lang.org/functional_programming_in_lean/Overloading-and-Type-Classes/Standard-Classes/>

Write an instance of `HAppend (List α) (NonEmptyList α) (NonEmptyList α)` and
test it.
-/
namespace «3.5. Standard Classes».Exercises.HAppendNonEmptyList

instance : HAppend (List α) (NonEmptyList α) (NonEmptyList α) where
  hAppend xs ys :=
    match xs with
    | [] => ys
    | x :: xs => ⟨x, xs ++ ys.head :: ys.tail⟩

#guard ([] : List String) ++ (⟨"one", ["two", "three"]⟩ : NonEmptyList String) = (⟨"one", ["two", "three"]⟩: NonEmptyList String)
#guard (["1", "2", "3"] : List String) ++ (⟨"one", ["two", "three"]⟩ : NonEmptyList String) = (⟨"1", ["2", "3", "one", "two", "three"]⟩: NonEmptyList String)

end «3.5. Standard Classes».Exercises.HAppendNonEmptyList
