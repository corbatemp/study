{-# LANGUAGE MultiParamTypeClasses, TypeOperators #-}

module Pairing where

import Control.Monad.Free
import Control.Comonad.Trans.Cofree
import Control.Comonad.Identity
import Adder

class (Functor f, Functor g) => Pairing f g where
  pair :: (a -> b -> r) -> f a -> g b -> r

instance Pairing Identity Identity where
  pair f (Identity a) (Identity b) = f a b

data (f :+: g) x = LeftF (f x) | RightF (g x)
instance (Functor f, Functor g) => Functor (f :+: g) where
  fmap f (LeftF x) = LeftF (fmap f x)
  fmap f (RightF x) = RightF (fmap f x)

data (f :*: g) x = f x :*: g x
instance (Functor f, Functor g) => Functor (f :*: g) where
  fmap f (x :*: y) = fmap f x :*: fmap f y

instance (Pairing f f', Pairing g g') => Pairing (f :+: g) (f' :*: g') where
  pair p (LeftF a) (b :*: _) = pair p a b
  pair p (RightF a) (_ :*: c) = pair p a c

--instance Pairing f g => Pairing (Free f) (Cofree g) where
  --pair p (Pure r) (a :< _) = p r a
  --pair p (Free f) (_ :< as) = pair (pair p) f as

instance (Comonad w, Pairing f g) => Pairing (Free f) (CofreeT g w) where
  pair p (Pure r) w = p r (extract w)
  pair p (Free f) gs = pair (pair p) f (unwrap gs)

mainpair :: IO ()
mainpair = do
  print "mainpair"
  print "test"
