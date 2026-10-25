import Fpil.Ch04.ArithmeticInMonads.Basic
open «4.1. One API, Many Applications»
open «4.2. The Monad Type Class»
open «4.3. Example: Arithmetic in Monads»
/-!
# 4.3. Example: Arithmetic in Monads — Exercise 4.3.3.4.3: A Tracing Evaluator

<https://lean-lang.org/functional_programming_in_lean/Monads/Example___-Arithmetic-in-Monads/>

The `WithLog` type can be used with the evaluator to add optional tracing of
some operations. In particular, the type `ToTrace` can serve as a signal to
trace a given operator:

```
inductive ToTrace (α : Type) : Type where
  | trace : α → ToTrace α
```

For the tracing evaluator, expressions should have type
`Expr (Prim (ToTrace (Prim Empty)))`. This says that the operators in the
expression consist of addition, subtraction, and multiplication, augmented
with traced versions of each. The innermost argument is `Empty` to signal that
there are no further special operators inside of `trace`, only the three basic
ones.

Do the following:

- Implement a `Monad (WithLog logged)` instance
- Write an `applyTraced` function to apply traced operators to their
  arguments, logging both the operator and the arguments, with type
  `ToTrace (Prim Empty) → Int → Int → WithLog (Prim Empty × Int × Int) Int`

If the exercise has been completed correctly, then

```
open Expr Prim ToTrace in
#eval
  evaluateM applyTraced
    (prim (other (trace times))
      (prim (other (trace plus)) (const 1)
        (const 2))
      (prim (other (trace minus)) (const 3)
        (const 4)))
```

should result in

```
{ log := [(Prim.plus, 1, 2), (Prim.minus, 3, 4), (Prim.times, 3, -1)], val := -3 }
```

Hint: values of type `Prim Empty` will appear in the resulting log. In order
to display them as a result of `#eval`, the following instances are required:

```
deriving instance Repr for WithLog
deriving instance Repr for Empty
deriving instance Repr for Prim
```
-/
namespace «4.3. Example: Arithmetic in Monads».Exercises.TracingEvaluator

end «4.3. Example: Arithmetic in Monads».Exercises.TracingEvaluator
