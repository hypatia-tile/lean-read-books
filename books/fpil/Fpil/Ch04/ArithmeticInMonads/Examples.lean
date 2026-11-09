import Fpil.Ch04.ArithmeticInMonads.Basic
open «4.1. One API, Many Applications»
open «4.2. The Monad Type Class»
/-!
# 4.3. Example: Arithmetic in Monads — Examples

Examples and experiments around the definitions in `Basic`.
-/
namespace «4.3. Example: Arithmetic in Monads».Example

open Expr in
open Arith in
def twoPlusThree : Expr Arith :=
  prim plus (const 2) (const 3)


open Expr in
open Arith in
/--
14 / (45 - (5 * 9))
-/
def fourteenDivided : Expr Arith :=
  prim div (const 14)
    (prim minus (const 45)
      (prim times (const 5)
        (const 9)))

def evaluateOption : Expr Arith → Option Int
  | .const i => pure i
  | .prim p lhs rhs =>
    evaluateOption lhs >>= fun lhs =>
    evaluateOption rhs >>= fun rhs =>
    match p with
    | .plus => pure (lhs + rhs)
    | .minus => pure (lhs - rhs)
    | .times => pure (lhs * rhs)
    | .div => if rhs == 0 then none else pure (lhs / rhs)

def evaluatePrim : Arith → Int → Int → Except String Int
  | .plus, lhs, rhs => pure (lhs + rhs)
  | .minus, lhs, rhs => pure (lhs - rhs)
  | .times, lhs, rhs => pure (lhs * rhs)
  | .div, lhs, 0 => .error s!"Tried to divide {lhs} by zero"
  | .div, lhs, rhs => pure (lhs / rhs)

def evaluateExcept : Expr Arith → Except String Int
  | .const i => pure i
  | .prim p lhs rhs =>
    evaluateExcept lhs >>= fun lhs =>
    evaluateExcept rhs >>= fun rhs =>
    evaluatePrim p lhs rhs

#guard evaluateOption twoPlusThree = some 5
#guard evaluateOption fourteenDivided = none

/-- info: some 5 -/
#guard_msgs in
#eval evaluateOption twoPlusThree

/-- info: none -/
#guard_msgs in
#eval evaluateOption fourteenDivided

end «4.3. Example: Arithmetic in Monads».Example
