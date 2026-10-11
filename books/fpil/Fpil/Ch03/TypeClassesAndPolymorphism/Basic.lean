import Fpil.Ch03.PositiveNumbers.Basic
open «3.1. Positive Numbers»
/-!
# 3.2. Type Classes and Polymorphism

<https://lean-lang.org/functional_programming_in_lean/Overloading-and-Type-Classes/Type-Classes-and-Polymorphism/>

The main definitions of the section.

- 3.2.1. Checking Polymorphic Functions' Types
- 3.2.2. Defining Polymorphic Functions with Instance Implicits
- 3.2.3. Methods and Implicit Arguments
- 3.2.4. Exercises
-/
namespace «3.2. Type Classes and Polymorphism»

def List.sumOfContents [Add α] [OfNat α 0] : List α → α
  | [] => 0
  | x :: xs => x + sumOfContents xs

structure PPoint (α : Type) where
  x : α
  y : α

instance [Add α] : Add (PPoint α) where
  add p1 p2 := { x := p1.x + p2.x, y := p1.y + p2.y }

end «3.2. Type Classes and Polymorphism»
