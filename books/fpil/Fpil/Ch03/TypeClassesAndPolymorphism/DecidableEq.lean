import Fpil.Ch03.TypeClassesAndPolymorphism.Basic
open «3.1. Positive Numbers»
open «3.2. Type Classes and Polymorphism»
/-!
# 3.2. Type Classes and Polymorphism — Checks

`#guard` checks of the definitions in `Basic`, using derived `DecidableEq`
instances.
-/

def fourNats : List Nat := [1, 2, 3, 4]

#guard fourNats.sumOfContents = 10

def fourPos : List Pos := [1, 2, 3, 4]

/--
info: failed to synthesize instance of type class
  OfNat Pos 0

Hint: Type class instance resolution failures can be inspected with the `set_option trace.Meta.synthInstance true` command.
-/
#guard_msgs in
#check_failure fourPos.sumOfContents
