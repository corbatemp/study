module  MyTraversal where

import Control.Monad.Writer
import Data.Traversable
import Data.Foldable

data Tree a = Empty | Leaf a | Node (Tree a) (Tree a) deriving Show

testtree = Node (Node (Leaf 11) (Leaf 12)) (Node (Leaf 21) (Leaf 22))

instance Functor Tree where
  fmap f (Leaf n) = Leaf (f n)
  fmap f (Node l r) = Node (fmap f l) (fmap f r)
  fmap f Empty = Empty

instance Foldable Tree where
  foldr f a Empty = a
  foldr f a (Leaf r) = f r a
  foldr f a (Node l r) = foldr f (foldr f a l) r

--  traverse :: Applicative f => (a -> f b) -> t a -> f (t b)

instance Traversable Tree where
  traverse f Empty = pure Empty
  traverse f (Leaf x) = Leaf <$> f x
  traverse f (Node l r) = Node <$> traverse f l <*> traverse f r

tl = Leaf <$> ( \ n -> Just (n +32)) 3
tlj = Leaf <$> Just 33
tlf = fmap Leaf (( \ n -> Just (n +32)) 3)
tn = Node <$> tlj <*> tlj

tt :: Writer String (Tree Int)
tt = traverse ( \ n -> (writer (1, "+"))) testtree

maintr :: IO ()
maintr = do
  print "hello traversal"
  print $ runWriter tt 

  --print $ traverse id [Just 1 , Just 2]
  --print $ fmap ( \ n -> show n ++ " fmap ")testtree
