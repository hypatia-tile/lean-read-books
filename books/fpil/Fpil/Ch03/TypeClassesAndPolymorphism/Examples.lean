import Fpil.Ch03.TypeClassesAndPolymorphism.Basic
open «3.1. Positive Numbers»
/-!
# 3.2. Type Classes and Polymorphism — Examples

Examples and experiments around the definitions in `Basic`.
-/
namespace «3.2. Type Classes and Polymorphism».Example

-- From the signature of the function `IO.println`, we know that it must accept
-- any type with a `ToString` instance and work for all such types.
/--
info: def IO.println.{u_1} : {α : Type u_1} → [ToString α] → α → IO Unit :=
fun {α} [ToString α] s => IO.print ((toString s).push '\n')
-/
#guard_msgs in
#print IO.println

/--
info: IO.println.{u_1} {α : Type u_1} [ToString α] (s : α) : IO Unit
-/
#guard_msgs in
#check IO.println

/--
info: @IO.println : {α : Type u_1} → [ToString α] → α → IO Unit
-/
#guard_msgs in
#check @IO.println

/-- info: @List.sum : {α : Type u_1} → [Add α] → [Zero α] → List α → α -/
#guard_msgs in
#check @List.sum

end «3.2. Type Classes and Polymorphism».Example
