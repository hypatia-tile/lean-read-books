import Fpil.Ch03.ArraysAndIndexing.Basic
open «3.1. Positive Numbers»
open «3.2. Type Classes and Polymorphism»
open «3.3. Controlling Instance Search»
open «3.4. Arrays and Indexing»
/-!
# 3.4. Arrays and Indexing — Checks

`#guard` checks of the definitions in `Basic`, using derived `DecidableEq`
instances.
-/

#guard northernTrees[2] = "elm"

/--
info: failed to prove index is valid, possible solutions:
  - Use `have`-expressions to prove the index is valid
  - Use `a[i]!` notation instead, runtime check is performed, and 'Panic' error message is produced if index is not valid
  - Use `a[i]?` notation instead, result is an `Option` type
  - Use `a[i]'h` notation instead, where `h` is a proof that index is valid
⊢ 8 < northernTrees.size
---
info: northernTrees[8] : String
-/
#guard_msgs in
#check_failure northernTrees[8]

#guard idahoSpiders[2] = "Wolf Spider"

/--
info: failed to prove index is valid, possible solutions:
  - Use `have`-expressions to prove the index is valid
  - Use `a[i]!` notation instead, runtime check is performed, and 'Panic' error message is produced if index is not valid
  - Use `a[i]?` notation instead, result is an `Option` type
  - Use `a[i]'h` notation instead, where `h` is a proof that index is valid
⊢ idahoSpiders.inBounds 9
---
info: idahoSpiders[9] : String
-/
#guard_msgs in
#check_failure idahoSpiders[9]
