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

section

def p1 : PPoint Pos := ⟨2, 3⟩
def p2 : PPoint Pos := ⟨4, 5⟩

set_option trace.Meta.synthInstance true

/--
info: p1 + p2 : PPoint Pos
---
trace: [Meta.synthInstance] ✅️ HAdd (PPoint Pos) (PPoint Pos) (PPoint Pos)
  [Meta.synthInstance] ✅️ new goal HAdd (PPoint Pos) (PPoint Pos) _tc.1
    [Meta.synthInstance.instances] #[@instHAdd]
  [Meta.synthInstance.apply] ✅️ apply @instHAdd to HAdd (PPoint Pos) (PPoint Pos) (PPoint Pos)
    [Meta.synthInstance.tryResolve] ✅️ HAdd (PPoint Pos) (PPoint Pos)
          (PPoint Pos) ≟ HAdd (PPoint Pos) (PPoint Pos) (PPoint Pos)
    [Meta.synthInstance] ✅️ new goal Add (PPoint Pos)
      [Meta.synthInstance.instances] #[@Lean.Grind.AddCommMonoid.toAdd, @Lean.Grind.Semiring.toAdd, @instAddPPoint]
  [Meta.synthInstance.apply] ✅️ apply @instAddPPoint to Add (PPoint Pos)
    [Meta.synthInstance.tryResolve] ✅️ Add (PPoint Pos) ≟ Add (PPoint Pos)
    [Meta.synthInstance] ✅️ new goal Add Pos
      [Meta.synthInstance.instances] #[@Lean.Grind.AddCommMonoid.toAdd, @Lean.Grind.Semiring.toAdd, instAddPos]
  [Meta.synthInstance.apply] ✅️ apply instAddPos to Add Pos
    [Meta.synthInstance.tryResolve] ✅️ Add Pos ≟ Add Pos
    [Meta.synthInstance.answer] ✅️ Add Pos
  [Meta.synthInstance.resume] ✅️ propagating Add Pos to subgoal Add Pos of Add (PPoint Pos)
    [Meta.synthInstance.resume] size: 1
    [Meta.synthInstance.answer] ✅️ Add (PPoint Pos)
  [Meta.synthInstance.resume] ✅️ propagating Add
        (PPoint Pos) to subgoal Add (PPoint Pos) of HAdd (PPoint Pos) (PPoint Pos) (PPoint Pos)
    [Meta.synthInstance.resume] size: 2
    [Meta.synthInstance.answer] ✅️ HAdd (PPoint Pos) (PPoint Pos) (PPoint Pos)
  [Meta.synthInstance] result instHAdd
[Meta.synthInstance] ✅️ HAdd (PPoint Pos) (PPoint Pos) (PPoint Pos)
  [Meta.synthInstance] ✅️ new goal HAdd (PPoint Pos) (PPoint Pos) _tc.1
    [Meta.synthInstance.instances] #[@instHAdd]
  [Meta.synthInstance.apply] ✅️ apply @instHAdd to HAdd (PPoint Pos) (PPoint Pos) (PPoint Pos)
    [Meta.synthInstance.tryResolve] ✅️ HAdd (PPoint Pos) (PPoint Pos)
          (PPoint Pos) ≟ HAdd (PPoint Pos) (PPoint Pos) (PPoint Pos)
    [Meta.synthInstance] ✅️ new goal Add (PPoint Pos)
      [Meta.synthInstance.instances] #[@Lean.Grind.AddCommMonoid.toAdd, @Lean.Grind.Semiring.toAdd, @instAddPPoint]
  [Meta.synthInstance.apply] ✅️ apply @instAddPPoint to Add (PPoint Pos)
    [Meta.synthInstance.tryResolve] ✅️ Add (PPoint Pos) ≟ Add (PPoint Pos)
    [Meta.synthInstance] ✅️ new goal Add Pos
      [Meta.synthInstance.instances] #[@Lean.Grind.AddCommMonoid.toAdd, @Lean.Grind.Semiring.toAdd, instAddPos]
  [Meta.synthInstance.apply] ✅️ apply instAddPos to Add Pos
    [Meta.synthInstance.tryResolve] ✅️ Add Pos ≟ Add Pos
    [Meta.synthInstance.answer] ✅️ Add Pos
  [Meta.synthInstance.resume] ✅️ propagating Add Pos to subgoal Add Pos of Add (PPoint Pos)
    [Meta.synthInstance.resume] size: 1
    [Meta.synthInstance.answer] ✅️ Add (PPoint Pos)
  [Meta.synthInstance.resume] ✅️ propagating Add
        (PPoint Pos) to subgoal Add (PPoint Pos) of HAdd (PPoint Pos) (PPoint Pos) (PPoint Pos)
    [Meta.synthInstance.resume] size: 2
    [Meta.synthInstance.answer] ✅️ HAdd (PPoint Pos) (PPoint Pos) (PPoint Pos)
  [Meta.synthInstance] result instHAdd
-/
#guard_msgs in
#check p1 + p2
end

end «3.2. Type Classes and Polymorphism».Example
