module CoFreeAdder where

import Control.Comonad.Trans.Cofree


maincofreeadder :: IO ()
maincofreeadder = do
  print "main cofree adder"
