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

-- 4.1.2. Propagating Error Messages

inductive Except (ε : Type) (α : Type) where
  | error (e : ε)
  | ok (r : α)
  deriving DecidableEq , BEq, Hashable, Repr

instance : Coe α (Except ε α) where
  coe x := .ok x

def get (xs : List α) (i : Nat) : Except String α :=
  match xs[i]? with
  | none => Except.error s!"Index {i} not found (maximum is {xs.length - 1})"
  | some x => x

/--
Fit, safe and non-poisonous plants to be eaten.
-/
def ediblePlants : List String :=
  ["ransons", "sea plantain", "sea buckthorn", "garden nasturtium"]

#guard get ediblePlants 2 = .ok "sea buckthorn"
#guard get ediblePlants 4 = .error "Index 4 not found (maximum is 3)"
#guard get ediblePlants 6 = .error "Index 6 not found (maximum is 3)"

def andThen (attempt : Except ε α) (next : α → Except ε β) : Except ε β :=
  match attempt with
  | .error e => .error e
  | .ok x => next x

def ok (x : α) : Except ε α := Except.ok x
def failure (err : ε) : Except ε α := Except.error err

infixl:55 " ~~~> " => andThen

def firstThird (xs : List α) : Except String (α × α) :=
  get xs 0 ~~~> fun first =>
  get xs 2 ~~~> fun third =>
  (first, third)

#guard firstThird ediblePlants = ("ransons", "sea buckthorn")

end «Except Monad»

namespace «Writer Monad»
--- 4.1.3. Logging

def isEven (i : Int) : Bool := i % 2 == 0

inductive BinTree (α : Type) where
  | leaf
  | branch (l : BinTree α) (x : α) (l : BinTree α)
  deriving DecidableEq , BEq, Hashable, Repr

structure WithLog (logged : Type) (α : Type) where
  log : List logged
  val : α
  deriving DecidableEq , BEq, Hashable, Repr

instance : Coe (List α × β) (WithLog α β) where
  coe x := ⟨x.1, x.2⟩

def andThen (result : WithLog α β) (next : β → WithLog α γ) : WithLog α γ :=
  let ⟨log1, val⟩ := result
  let ⟨log2, val⟩ := next val
  ⟨log1 ++ log2, val⟩

def ok (x : β) : WithLog α β := ⟨[], x⟩
def save (x : α) : WithLog α Unit := ⟨[x], ()⟩

infixl:55 " ~~> " => andThen

/--
Writer monad example:
Underlying type of `Writer m a` is `m × α`.
`sumAndFindEvens : List Int → Writer (List Int) Int`
-/
def sumAndFindEvens : List Int → WithLog Int Int
  | [] => ok 0
  | x :: xs =>
    (if isEven x then save x else ok ()) ~~> fun () =>
    sumAndFindEvens xs ~~> fun sum =>
    ok (x + sum)

def inorderSum : BinTree Int → WithLog Int Int
  | .leaf => ok 0
  | .branch l x r =>
    inorderSum l ~~> fun leftSum =>
    save x ~~> fun () =>
    inorderSum r ~~> fun rightSum =>
    ok (leftSum + x + rightSum)

#guard sumAndFindEvens ([1, 2, 3, 4, 5, 6, 7, 8, 9, 10] : List Int)
  = ([(2 : Int), 4, 6, 8, 10], (55 : Int))

end «Writer Monad»

namespace «State Monad»

inductive BinTree (α : Type) where
  | leaf
  | branch (l : BinTree α) (x : α) (l : BinTree α)
  deriving DecidableEq , BEq, Hashable, Repr


open BinTree in
def aTree :=
  branch
    (branch
       (branch leaf "a" (branch leaf "b" leaf))
       "c"
       leaf)
    "d"
    (branch leaf "e" leaf)

def number (t : BinTree α) : BinTree (Nat × α) :=
  let rec helper (n : Nat) : BinTree α → (Nat × BinTree (Nat × α))
    | .leaf => (n, .leaf)
    | .branch left x right =>
      let (k, numberedLeft) := helper n left
      let (i, numberedRight) := helper (k + 1) right
      (i, .branch numberedLeft (k, x) numberedRight)
    (helper 0 t).snd

end «State Monad»

end «4.1. One API, Many Applications».Example
