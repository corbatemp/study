{-# LANGUAGE MultiParamTypeClasses, TypeOperators #-}

module Main where

import Adder
import Pairing
import FreeAdder
import CoFreeAdder

import Control.Monad.Free
import Control.Comonad.Cofree

type AdderH = AdderF :+: ClearF :+: TotalF
type CoAdderH = CoAdderF :*: CoClearF :*: CoTotalF

type FreeA a = Free AdderH a
type CofreeA a = Cofree CoAdderH a

add :: Int -> FreeA ()
add n = liftF (LeftF (LeftF (Add n ())))

total :: FreeA Int
total = liftF (RightF (Total id))

add3 :: FreeA Int
add3 = do
    add 1
    add 2
    add 3
    total

interpret :: FreeA Int -> CofreeA Int -> Int
interpret = undefined

main :: IO ()
main = do
  print "hello world"
  mainfreeadder
