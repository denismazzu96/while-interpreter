module Fixpoint
  ( fix
  ) where

import DataStructure
import UtilityFunctions
import State.State

fix ::
  ((State -> PartialState) -> State -> PartialState) -> -- f
  State -> PartialState
fix f = lub [ fnth f n bottom | n <- [0..] ] -- Theorem 4.37

-- nth application of functional F
fnth :: -- definition of f^n, Theorem 4.37
  ((State -> PartialState) -> (State -> PartialState)) -> -- f
  Integer -> -- n
  (State -> PartialState) ->
  State -> PartialState
fnth f 0 = id
fnth f n = f . (fnth f (n-1))

lub :: [(State -> PartialState)] -> State -> PartialState
-- lub [] s = bottom s -- Fact 4.24
lub (g:gs) s -- Lemma 4.25
  | g s /= Undef = g s -- if exist g (and g s) is unique, also g is the least
  | otherwise = lub gs s
