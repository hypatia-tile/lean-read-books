import Fpil.Ch03.PositiveNumbers.Basic

open «3.1. Positive Numbers»

deriving instance DecidableEq for Pos

/--
info: instDecidableEqPos
-/
#guard_msgs in
#synth DecidableEq Pos

