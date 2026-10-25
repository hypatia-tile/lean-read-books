import Fpil.Ch04.ArithmeticInMonads.Basic
open «4.1. One API, Many Applications»
open «4.2. The Monad Type Class»
open «4.3. Example: Arithmetic in Monads»
/-!
# 4.3. Example: Arithmetic in Monads — Exercise 4.3.3.4.2: Readers with Failure

<https://lean-lang.org/functional_programming_in_lean/Monads/Example___-Arithmetic-in-Monads/>

Adapt the reader monad example so that it can also indicate failure when the
custom operator is not defined, rather than just returning zero. In other
words, given these definitions:

```
def ReaderOption (ρ : Type) (α : Type) : Type := ρ → Option α

def ReaderExcept (ε : Type) (ρ : Type) (α : Type) : Type := ρ → Except ε α
```

do the following:

- Write suitable `pure` and `bind` functions
- Check that these functions satisfy the `Monad` contract
- Write `Monad` instances for `ReaderOption` and `ReaderExcept`
- Define suitable `applyPrim` operators and test them with `evaluateM` on some
  example expressions
-/
namespace «4.3. Example: Arithmetic in Monads».Exercises.ReadersWithFailure

end «4.3. Example: Arithmetic in Monads».Exercises.ReadersWithFailure
