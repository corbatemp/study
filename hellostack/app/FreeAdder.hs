{-# LANGUAGE MultiParamTypeClasses, TypeOperators #-}

module FreeAdder where

import Adder
import Pairing

import Control.Comonad.Trans.Cofree
import Control.Monad.Free
import Control.Comonad.Store

coAd :: String -> Int -> String
coAd s n = s ++ show n

coCl :: String -> String
coCl _ = "clear"

coTo :: String -> (Int, String)
coTo s = (length s, s)

mkCoAd :: CofreeT CoAdF (Store String) ()
mkCoAd = coiterT next start where
  next s = undefined --CoAd (coAd s) (coCl s) (coTo s)
  start = undefined --"start"

instance  Pairing AdF CoAdF where
  pair p (Ad n k) (CoAd a _ _) = p k (a n)
  pair p (Cl k) (CoAd _ c _) = p k c
  pair p (To f) (CoAd _ _ t) = p ( f (fst t)) (snd t)


add3 :: Free AdF Int
add3 = do
  liftF (Ad 1 ())
  liftF (Ad 2 ())
  liftF (Cl ())
  liftF (Ad 3 ())
  v <- liftF (To id)
  liftF (Ad v ())
  liftF (Ad v ())
  liftF (To id)
--  liftF (Cl)

testp = pair ( \ _ b -> b ) add3 mkCoAd

mainfreeadder :: IO ()
mainfreeadder = do
  print "hello freeadder"
  print "test free adder"
  print testp
