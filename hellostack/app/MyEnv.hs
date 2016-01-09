module MyEnv where

import Control.Comonad

data MyEnv e a = MyEnv e a

runMyEnv :: MyEnv e a -> (e, a)
runMyEnv (MyEnv e a) = (e, a)

instance Functor (MyEnv e) where
  fmap f (MyEnv e a) = MyEnv e (f a)

instance Comonad (MyEnv e) where
  extract (MyEnv e a) = a
  extend f (MyEnv e a) = MyEnv e (f (MyEnv e a))

instance Foldable (MyEnv e) where
  foldr f z (MyEnv e r) = f r z

myask :: MyEnv e a -> e
myask (MyEnv e _) = e


mainenv :: IO ()
mainenv = print "mainenv"
