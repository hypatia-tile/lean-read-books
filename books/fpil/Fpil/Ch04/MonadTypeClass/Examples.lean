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

def mapM [Monad m] (f : α → m β) : List α → m (List β)
  | [] => pure []
  | x :: xs =>
    f x >>= fun hd =>
    mapM f xs >>= fun tl =>
    pure (hd :: tl)

def State σ α := σ → σ × α

def get : State σ σ := fun s => (s, s)
def set (s : σ) : State σ Unit := fun _ => (s, ())

instance : Monad (State σ) where
  pure x := fun s => (s, x)
  bind x f :=
    fun s =>
      let (s', x') := x s
      f x' s'

def increment (howMuch : Int) : State Int Int :=
  get >>= fun i =>
  set (i + howMuch) >>= fun () =>
  pure i

#guard mapM increment [1, 2, 3, 4, 5] 0 = (15, [0, 1, 3, 6, 10])
end «4.2. The Monad Type Class».Example
