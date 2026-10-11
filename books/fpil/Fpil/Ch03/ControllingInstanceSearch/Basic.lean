import Fpil.Ch03.TypeClassesAndPolymorphism.Basic
open «3.1. Positive Numbers»
open «3.2. Type Classes and Polymorphism»
/-!
# 3.3. Controlling Instance Search

<https://lean-lang.org/functional_programming_in_lean/Overloading-and-Type-Classes/Controlling-Instance-Search/>

The main definitions of the section.

- 3.3.1. Heterogeneous Overloadings
- 3.3.2. Output Parameters
- 3.3.3. Default Instances
- 3.3.4. Exercises
-/
namespace «3.3. Controlling Instance Search»

def addNatPos : Nat → Pos → Pos
  | 0, p => p
  | n + 1, p => Pos.succ <| addNatPos n p

def addPosNat : Pos → Nat → Pos
  | p, 0 => p
  | p, n + 1 => Pos.succ <| addPosNat p n

instance : HAdd Nat Pos Pos where
  hAdd := addNatPos

instance : HAdd Pos Nat Pos where
  hAdd := addPosNat

end «3.3. Controlling Instance Search»
