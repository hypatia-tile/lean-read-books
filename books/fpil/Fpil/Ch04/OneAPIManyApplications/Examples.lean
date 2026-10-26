import Fpil.Ch04.OneAPIManyApplications.Basic
/-!
# 4.1. One API, Many Applications — Examples

Examples and experiments around the definitions in `Basic`.
-/
namespace «4.1. One API, Many Applications».Example

namespace «Option Monad»
def first (xs : List α) : Option α :=
  xs[0]?

def firstThird (xs : List α) : Option (α × α) :=
  match xs[0]?, xs[2]? with
  | none, _ | _, none => none
  | some fst, some thd => (fst, thd)

#guard firstThird [1] = none
#guard firstThird [1, 2, 3] = some (1, 3)

def firstThirdFifth {α : Type} (xs : List α) : Option (α × α × α) :=
  match xs[0]? with
  | none => none
  | some first =>
    match xs[2]? with
    | none => none
    | some third =>
      match xs[4]? with
      | none => none
      | some fifth => (first, third, fifth)
  
#guard firstThirdFifth [1, 2, 3, 4] = none
#guard firstThirdFifth [1, 2, 3, 4, 5] = ↑(1, 3, 5)


namespace «with andThen»

def andThen (opt : Option α) (next : α → Option β) : Option β :=
  match opt with
  | none => none
  | some x => next x

def firstThird (xs : List α) : Option (α × α) :=
  andThen xs[0]? fun first =>
    andThen xs[2]? fun third =>
      some (first, third)

namespace «with infixop»

infixl:55 "~~~> " => andThen

def firstThird (xs : List α) : Option (α × α) :=
  xs[0]? ~~~> fun first =>
    xs[2]? ~~~> fun third =>
      some (first, third)

end «with infixop»

end «with andThen»

end «Option Monad»

namespace «Except Monad»

end «Except Monad»

end «4.1. One API, Many Applications».Example
