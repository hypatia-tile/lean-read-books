import Fpil.Ch03.Coercions.Basic
import Lean
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

/--
info: class CoeFun.{u, v} (α : Sort u) (γ : outParam (α → Sort v)) : Sort (max (max 1 u) v)
number of parameters: 2
fields:
  CoeFun.coe : (f : α) → γ f
constructor:
  CoeFun.mk.{u, v} {α : Sort u} {γ : outParam (α → Sort v)} (coe : (f : α) → γ f) : CoeFun α γ
-/
#guard_msgs in
#print CoeFun

/--
info: @CoeFun.coe : {α : Sort u_1} → {γ : outParam (α → Sort u_2)} → [self : CoeFun α γ] → (f : α) → γ f
-/
#guard_msgs in
#check @CoeFun.coe

def foldMap (M : Monoid) (f : α → M) (xs : List α) : M :=
  let rec go (soFar : M) : List α → M
    | [] => soFar
    | y :: ys => go (M.op soFar (f y)) ys
  go M.neutral xs

-- 3.6.6. Coercing to Function

structure Adder where
  howMuch : Nat

def add5 : Adder := ⟨5⟩

/--
info: Function expected at
  add5
but this term has type
  Adder

Note: Expected a function because this term is being applied to the argument
  3
-/
#guard_msgs in
#check_failure add5 3

instance : CoeFun Adder (fun _ => Nat → Nat) where
  coe a := (· + a.howMuch)

/-- info: 8 -/
#guard_msgs in
#eval add5 3

inductive JSON where
  | true
  | false
  | null
  | string (str : String)
  | number (num : Float)
  | object (l : List (String × JSON))
  | array (arr : List JSON)

structure Serializer : Type 1 where
  Contents : Type
  serialize : Contents → JSON

def Str : Serializer :=
  { Contents := String,
    serialize := JSON.string
  }

instance : CoeFun Serializer (fun s => s.Contents → JSON) where
  coe s := s.serialize

def buildResponse (title : String) (R : Serializer) (record : R.Contents) : JSON :=
  JSON.object [
    ("title", JSON.string title),
    ("status", JSON.number 200),
    ("record", R record)
  ]

/--
info: «3.6. Coercions».Example.JSON.object
  [("title", «3.6. Coercions».Example.JSON.string "Functional Programming in Lean"),
   ("status", «3.6. Coercions».Example.JSON.number 200.000000),
   ("record", «3.6. Coercions».Example.JSON.string "Programming is fun!")]
-/
#guard_msgs in
#eval buildResponse "Functional Programming in Lean" Str "Programming is fun!"

-- 3.6.6.1. Aside: JSON as a String

def dropDecimals (numString : String) : String :=
  if numString.contains '.' then
    let noTrailingZeros := numString.dropEndWhile (· == '0')
    (noTrailingZeros.dropEndWhile (· == '.')).copy
  else numString

def _root_.String.separate (sep : String) (strings : List String) : String :=
  match strings with
  | [] => ""
  | x :: xs => String.join (x :: xs.map (sep ++ ·))

#guard ",".separate  ["aa", "bb", "cc"] = "aa,bb,cc"

partial def JSON.asString (val : JSON) : String :=
  match val with
  | true => "true"
  | false => "false"
  | null => "null"
  | string s => "\"" ++ Lean.Json.escape s ++ "\""
  | number n => dropDecimals n.toString
  | object members =>
    let memberToString mem :=
      "\"" ++ Lean.Json.escape mem.fst ++ "\": " ++ asString mem.snd
    "{" ++ ", ".separate (members.map memberToString) ++ "}"
  | array elements =>
    "[" ++ ", ".separate (elements.map asString) ++ "]"

end «3.6. Coercions».Example
