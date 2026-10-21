import Fpil.Ch03.Coercions.Basic
open «3.1. Positive Numbers»
open «3.2. Type Classes and Polymorphism»
open «3.3. Controlling Instance Search»
open «3.4. Arrays and Indexing»
open «3.5. Standard Classes»
/-!
# 3.6. Coercions — Examples

Examples and experiments around the definitions in `Basic`.
-/
namespace «3.6. Coercions».Example

/--
In this example, the type of `f` is `String`, and the function
`IO.FS.readFile` expects a `System.FilePath`, so the coercion from
`String` to `System.FilePath` is applied automatically.
-/
def fileDumper : IO Unit := do
  let stdin ← IO.getStdin
  let stdout ← IO.getStdout
  stdout.putStr "Which file? "
  stdout.flush
  let f := (← stdin.getLine).trimAscii.copy
  stdout.putStrLn s!"'The file {f}' contains:"
  stdout.putStrLn (← IO.FS.readFile f)

section

/-- info: instCoePosNat -/
#guard_msgs in
#synth Coe Pos Nat
attribute [-instance] instCoePosNat

/--
info: Application type mismatch: The argument
  2
has type
  Pos
but is expected to have type
  Nat
in the application
  List.drop 2
---
info: List.drop sorry [1, 2, 3, 4] : List Nat
-/
#guard_msgs in
#check_failure [1, 2, 3, 4].drop (2 : Pos)

end

/-- info: @Coe.coe : {α : semiOutParam (Sort u_1)} → {β : Sort u_2} → [self : Coe α β] → α → β -/
#guard_msgs in
#check @Coe.coe

section
variable (α β : Type)

/-- info: fun [Coe α β] x => Coe.coe x : [Coe α β] → α → β -/
#guard_msgs in
#check ((↑ ·) : [Coe α β] → α → β)
end

inductive A where
  | a

inductive B where
  | b

instance : Coe A B where
  coe _ := B.b

instance : Coe B A where
  coe _ := A.a

instance : Coe Unit A where
  coe _ := A.a

def coercedToB : B := ()

/-- info: «3.6. Coercions».Example.B.b -/
#guard_msgs in
#eval coercedToB

def _root_.List.last? : List α → Option α
  | [] => none
  | [x] => x
  | _ :: x :: xs => last? (x :: xs)

def perhapsPerhapsPerhaps : Option (Option (Option String)) :=
  "Please don't tell me"

/-- info: some (some (some "Please don't tell me")) -/
#guard_msgs in
#eval perhapsPerhapsPerhaps

def perhapsPerhapsPerhapsNat : Option (Option (Option Nat)) :=
  ↑(392 : Nat)

instance : Coe (NonEmptyList α) (List α) where
  coe
    | { head := x, tail := xs } => x :: xs

instance : CoeDep (List α) (x :: xs) (NonEmptyList α) where
  coe := { head := x, tail := xs }

structure Monoid where
  Carrier : Type
  neutral : Carrier
  op : Carrier → Carrier → Carrier

def natMulMonoid : Monoid :=
  { Carrier := Nat, neutral := 1, op := (· * ·) }

def natAddMonoid : Monoid :=
  { Carrier := Nat, neutral := 0, op := (· + ·) }

def stringMonoid : Monoid :=
  { Carrier := String, neutral := "", op := String.append }

def listMonoid (α : Type) : Monoid :=
  { Carrier := List α, neutral := [], op := List.append }

instance : CoeSort Monoid Type where
  coe m := m.Carrier

def foldMap (M : Monoid) (f : α → M) (xs : List α) : M :=
  let rec go (soFar : M) : List α → M
    | [] => soFar
    | y :: ys => go (M.op soFar (f y)) ys
  go M.neutral xs

inductive JSON where
  | true : JSON
  | false : JSON
  | null : JSON
  | string : String → JSON
  | number : Float → JSON
  | object : List (String × JSON) → JSON
  | array : List JSON → JSON

structure Serializer : Type 1 where
  Contents : Type
  serialize : Contents → JSON

def Str : Serializer :=
  { Contents := String,
    serialize := JSON.string
  }

end «3.6. Coercions».Example
