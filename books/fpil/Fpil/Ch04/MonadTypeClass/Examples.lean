import Fpil.Ch04.MonadTypeClass.Basic
open «4.1. One API, Many Applications»
/-!
# 4.2. The Monad Type Class — Examples

Examples and experiments around the definitions in `Basic`.
-/
namespace «4.2. The Monad Type Class».Example

def firstThirdFifthSeventh {α : Type } [Monad m]
  (lookup : List α → Nat → m α) (xs : List α): m (α × α × α × α) :=
  lookup xs 0 >>= fun first =>
  lookup xs 2 >>= fun third =>
  lookup xs 4 >>= fun fifth =>
  lookup xs 6 >>= fun seventh =>
    pure (first, third, fifth, seventh)

def slowMammals : List String :=
  ["Three-toed sloth", "Slow loris"]

def fastBirds : List String := [
  "Peregrine falcon",
  "Saker falcon",
  "Golden eagle",
  "Gray-headed albatross",
  "Spur-winged goose",
  "Swift",
  "Anna's hummingbird"
]

#guard firstThirdFifthSeventh (fun xs i => xs[i]?) slowMammals = none
#guard firstThirdFifthSeventh (fun xs i => xs[i]?) fastBirds = (
  "Peregrine falcon",
  "Golden eagle",
  "Spur-winged goose",
  "Anna's hummingbird"
)

def getOrExcept (xs : List α) (i : Nat) : Except String α :=
  match xs[i]? with
  | none => .error s!"Index {i} not found (maximum is {xs.length - 1})"
  | some x => .ok x

example : Except String (String × String × String × String) := firstThirdFifthSeventh getOrExcept slowMammals
example : Except String (String × String × String × String) :=  firstThirdFifthSeventh getOrExcept fastBirds

end «4.2. The Monad Type Class».Example
