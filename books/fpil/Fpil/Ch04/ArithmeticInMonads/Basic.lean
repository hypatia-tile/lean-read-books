import Fpil.Ch04.MonadTypeClass.Basic
open «4.1. One API, Many Applications»
open «4.2. The Monad Type Class»
/-!
# 4.3. Example: Arithmetic in Monads

<https://lean-lang.org/functional_programming_in_lean/Monads/Example___-Arithmetic-in-Monads/>

The main definitions of the section.

- 4.3.1. Arithmetic Expressions
- 4.3.2. Evaluating Expressions
- 4.3.3. Further Effects
  - 4.3.3.1. No Effects
  - 4.3.3.2. Nondeterministic Search
  - 4.3.3.3. Custom Environments
  - 4.3.3.4. Exercises
-/
namespace «4.3. Example: Arithmetic in Monads»

inductive Expr (op : Type) where
  | const (n : Int)
  | prim (o : op) (lhs : Expr op) (rhs : Expr op)
  deriving DecidableEq

/--
Basic arithmetic operations.
-/
inductive Arith where
  /-- Addition -/
  | plus
  /-- Subtraction -/
  | minus
  /-- Multiplication -/
  | times
  /-- Division -/
  | div
  deriving DecidableEq

end «4.3. Example: Arithmetic in Monads»
