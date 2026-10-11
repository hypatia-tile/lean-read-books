/-!
# 3.1. Positive Numbers — Exercise: Another Representation

<https://lean-lang.org/functional_programming_in_lean/Overloading-and-Type-Classes/Positive-Numbers/>

Represent a positive number as the successor of some `Nat`:

```
structure Pos where
  succ ::
  pred : Nat
```

Define instances of `Add`, `Mul`, `ToString`, and `OfNat` that allow this
version of `Pos` to be used conveniently.
-/
namespace «3.1. Positive Numbers».Exercises.AnotherRepresentation

end «3.1. Positive Numbers».Exercises.AnotherRepresentation
