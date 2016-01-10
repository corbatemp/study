module FreeAdder where

import Control.Monad.Trans.Free
import Control.Monad.State.Lazy


import Adder

type Adder a = FreeT AdderF Maybe a

add3 :: Adder Int
add3 = do
  liftF (Add 1 ())
---  liftF (Clear ())
  liftF (Add 2 ())
  liftF (Add 3 ())
  liftF (Total id)

freeinter :: Adder Int -> State Int Int
freeinter m = case runFreeT m of
      Just (Pure n) -> return n
      Just (Free (Add n k)) -> do
        v <- get
        put (v + n)
        freeinter k
      Just (Free (Total g)) -> do
        v <- get
        put v
        freeinter (g (v + 3))

mainfreeadder :: IO ()
mainfreeadder = do
  print "hello freeadder"
  print $ execState ( freeinter add3 ) 0
  print $ evalState ( freeinter add3 ) 0

  -- print add3
