import Fpil.Ch03.ArraysAndIndexing.Basic
open «3.1. Positive Numbers»
open «3.2. Type Classes and Polymorphism»
open «3.3. Controlling Instance Search»
/-!
# 3.4. Arrays and Indexing — Examples

Examples and experiments around the definitions in `Basic`.
-/
namespace «3.4. Arrays and Indexing».Example

def NonEmptyList.get? : NonEmptyList α → Nat → Option α
  | xs, 0 => some xs.head
  | { head := _, tail := []}, _ + 1 => none
  | { head := _, tail := h :: t}, n + 1 => get? {head := h, tail := t} n

#guard idahoSpiders.get? 0 = some "Banded Garden Spider"
#guard idahoSpiders.get? 2 = some "Wolf Spider"
#guard idahoSpiders.get? 8 = none

 /--
info: class GetElem.{u, v, w} (coll : Type u) (idx : Type v) (elem : outParam (Type w))
  (valid : outParam (coll → idx → Prop)) : Type (max (max u v) w)
number of parameters: 4
fields:
  GetElem.getElem : (xs : coll) → (i : idx) → valid xs i → elem
constructor:
  GetElem.mk.{u, v, w} {coll : Type u} {idx : Type v} {elem : outParam (Type w)} {valid : outParam (coll → idx → Prop)}
    (getElem : (xs : coll) → (i : idx) → valid xs i → elem) : GetElem coll idx elem valid
 -/
 #guard_msgs in
 #print GetElem 

end «3.4. Arrays and Indexing».Example
