import Fpil.Ch03.ControllingInstanceSearch.Basic
open «3.1. Positive Numbers»
open «3.2. Type Classes and Polymorphism»
/-!
# 3.3. Controlling Instance Search — Examples

Examples and experiments around the definitions in `Basic`.
-/
namespace «3.3. Controlling Instance Search».Example

namespace «without outparam»
class HPlus (α : Type) (β : Type) (γ : Type) where
  hPlus : α → β → γ

instance : HPlus Nat Pos Pos where
  hPlus := addNatPos

instance : HPlus Pos Nat Pos where
  hPlus := addPosNat

/--
info: typeclass instance problem is stuck
  HPlus Pos Nat ?m.3

Note: Lean will not try to resolve this typeclass instance problem because the third type argument to `HPlus` is a metavariable. This argument must be fully determined before Lean will try to resolve the typeclass.

Hint: Adding type annotations and supplying implicit arguments to functions can give Lean more information for typeclass resolution. For example, if you have a variable `x` that you intend to be a `Nat`, but Lean reports it as having an unresolved type like `?m`, replacing `x` with `(x : Nat)` can get typeclass resolution un-stuck.
-/
#guard_msgs in
#check_failure (HPlus.hPlus (3 : Pos) (5 : Nat))

/--
info: 8
-/
#guard_msgs in
#eval (HPlus.hPlus (3 : Pos) (5 : Nat) : Pos)

end «without outparam»



end «3.3. Controlling Instance Search».Example
