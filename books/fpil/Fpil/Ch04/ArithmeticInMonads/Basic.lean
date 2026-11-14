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

/--
Arithmetic operations with a special operation defined by the user.
-/
inductive Prim (special : Type) where
  /-- Addition -/
  | plus
  /-- Subtraction -/
  | minus
  /-- Multiplication -/
  | times
  /-- User defined operation -/
  | other (s : special)
  deriving DecidableEq

inductive CanFail where
  | div
  deriving DecidableEq

def divOption : CanFail → Int → Int → Option Int
  | .div, _, 0 => none
  | .div, x, y => pure (x / y)

def divExcept : CanFail → Int → Int → Except String Int
  | .div, x, 0 => .error s!"Tried to divide {x} by zero"
  | .div, x, y => pure (x / y)

def applyPrim [Monad m]
    (applySpecial : special → Int → Int → m Int) :
    Prim special → Int → Int → m Int
  | .plus, lhs, rhs => pure (lhs + rhs)
  | .minus, lhs, rhs => pure (lhs - rhs)
  | .times, lhs, rhs => pure (lhs * rhs)
  | .other op, lhs, rhs => applySpecial op lhs rhs

def applyEmpty [Monad m] (op : Empty) (_ : Int) (_ : Int) : m Int :=
  nomatch op

def evaluateM [Monad m]
    (applySpecial : special → Int → Int → m Int) :
    Expr (Prim special) → m Int
  | .const i => pure i
  | .prim p lhs rhs =>
    evaluateM applySpecial lhs >>= fun lhs =>
    evaluateM applySpecial rhs >>= fun rhs =>
    applyPrim applySpecial p lhs rhs

end «4.3. Example: Arithmetic in Monads»
