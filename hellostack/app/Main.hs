module Main where

-- add some comment plus some other comment

import MyEnv

import Control.Comonad.Identity
import Control.Comonad.Trans.Store
import Control.Comonad.Trans.Coiter
import Control.Comonad.Env
import Data.Foldable

import Adder
import FreeAdder
import CoFreeAdder

testi :: CoiterT (Env Char) Int
testi = unfold ( extract . fmap (+1) ) (env 'a' 1)

tests :: CoiterT (MyEnv Char)  String
tests = unfold ( \ wd ->
  let smb = show ( myask wd )
  in extract ( fmap (++smb) wd) ) (MyEnv 'a' "test")

test :: CoiterT (MyEnv Char) (Int , String)
test = tests =>> (\ wd ->
  let smb = myask ( runCoiterT wd )
  in (length ( extract wd) , extract wd ++ show smb))


rs = find ((> 100) . fst) test

main :: IO ()
main = do
  print "hello world"
  mainfreeadder
  maincofreeadder
