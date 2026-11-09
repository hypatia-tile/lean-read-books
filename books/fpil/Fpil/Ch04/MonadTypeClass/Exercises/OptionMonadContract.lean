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

theorem lid (x : α) (f : α → Option β) : pure x >>= f = f x := by rfl
theorem rid (m : Option α) (_ : α → Option β): m >>= pure = m :=
  match m with
  | .some x => by rfl
  | .none => by rfl
theorem assoc (m : Option α) (g : α → Option β) (h : β → Option γ) :
    (m >>= g) >>= h = m >>= fun x => g x >>= h :=
  match m with
  | .some x => by rfl
  | .none => by rfl

instance : Monad Option where
  pure x := some x
  bind _ _ := none

example (x : α) : pure x >>= pure = none := by rfl

end «4.2. The Monad Type Class».Exercises.OptionMonadContract
