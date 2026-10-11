import Fpil.Ch03.ControllingInstanceSearch.Basic
open «3.1. Positive Numbers»
open «3.2. Type Classes and Polymorphism»
open «3.3. Controlling Instance Search»
/-!
# 3.3. Controlling Instance Search — Exercise 3.3.4

<https://lean-lang.org/functional_programming_in_lean/Overloading-and-Type-Classes/Controlling-Instance-Search/>

Define an instance of `HMul (PPoint α) α (PPoint α)` that multiplies both
projections by the scalar. It should work for any type `α` for which there is
a `Mul α` instance. For example,

```
#eval {x := 2.5, y := 3.7 : PPoint Float} * 2.0
```

should yield

```
{ x := 5.000000, y := 7.400000 }
```
-/
namespace «3.3. Controlling Instance Search».Exercises.ScalarMultiplication

end «3.3. Controlling Instance Search».Exercises.ScalarMultiplication
