import Fpil.Ch03.PositiveNumbers.Basic

open «3.1. Positive Numbers»

deriving instance DecidableEq for Pos

def seven : Pos :=
  Pos.succ (Pos.succ (Pos.succ (Pos.succ (Pos.succ (Pos.succ Pos.one)))))

#guard s!"There are {seven}" = "There are 7"

#guard (seven + seven).toNat = 14
#guard (seven * Pos.one).toNat = 7
#guard (seven * seven).toNat = 49
#guard (Pos.one.succ * seven).toNat = 14


