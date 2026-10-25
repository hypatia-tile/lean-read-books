import Fpil.Ch04.MonadTypeClass.Basic
open «4.1. One API, Many Applications»
open «4.2. The Monad Type Class»
/-!
# 4.2. The Monad Type Class — Exercise 4.2.4.2: The Option Monad Contract

<https://lean-lang.org/functional_programming_in_lean/Monads/The-Monad-Type-Class/>

First, write a convincing argument that the `Monad` instance for `Option`
satisfies the monad contract. Then, consider the following instance:

```
instance : Monad Option where
  pure x := some x
  bind opt next := none
```

Both methods have the correct type. Why does this instance violate the monad
contract?
-/
namespace «4.2. The Monad Type Class».Exercises.OptionMonadContract

end «4.2. The Monad Type Class».Exercises.OptionMonadContract
