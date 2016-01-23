module CoFreeAdder where

import Control.Monad.Free
import Control.Comonad.Trans.Cofree
import Control.Comonad.Identity
import Control.Comonad.Store
import Data.Foldable

data F a = A a | B a
data CoF a = CoA a | CoB a | CoDone

type FreeAdder a = Free F a
type CoFreeAdder a = CofreeT CoF (Store Int)  a

st :: Store String Int
st = store length "test" =>> peek "dd"

cf :: CoFreeAdder ()
cf = undefined

icf :: FreeAdder () -> CoFreeAdder ()
icf (Pure _) = undefined --CofreeT $ Identity ( () :< CoDone)

maincofreeadder :: IO ()
maincofreeadder = do
  print "main cofree adder"
  print "test"
  print $ peeks id st
