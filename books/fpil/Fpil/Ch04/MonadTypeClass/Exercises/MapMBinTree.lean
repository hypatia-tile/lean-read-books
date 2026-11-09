import Fpil.Ch04.MonadTypeClass.Basic
open «4.1. One API, Many Applications»
open «4.2. The Monad Type Class»
/-!
# 4.2. The Monad Type Class — Exercise 4.2.4.1: Mapping on a Tree

<https://lean-lang.org/functional_programming_in_lean/Monads/The-Monad-Type-Class/>

Define a function `BinTree.mapM`. By analogy to `mapM` for lists, this
function should apply a monadic function to each data entry in a tree, as a
preorder traversal. The type signature should be:

```
def BinTree.mapM [Monad m] (f : α → m β) : BinTree α → m (BinTree β)
```
-/
namespace «4.2. The Monad Type Class».Exercises.MapMBinTree

inductive BinTree (α : Type) where
  | leaf
  | branch (l : BinTree α) (x : α) (r : BinTree α)
  deriving DecidableEq

def BinTree.mapM [Monad m] (f : α → m β) : BinTree α → m (BinTree β)
  | leaf => pure leaf
  | branch l x r => f x >>= fun x =>
    mapM f l >>= fun l =>
    mapM f r >>= fun r =>
      pure <| branch l x r

end «4.2. The Monad Type Class».Exercises.MapMBinTree
