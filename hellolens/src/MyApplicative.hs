--{-# LANGUAGE DeriveFunctor #-}

module MyApplicative where

import Control.Monad.Writer

data ThreeArg a = ThreeArg a a a deriving Show

tj = ThreeArg <$> Just 1

tw :: Writer String (Int -> Int)
tw = writer ( ( \n ->  n), "one")

tt :: Writer String Int
tt = writer ( 2 , "two")

mainapp :: IO ()
mainapp = do
  print "hello applicative"
  print  $ tj <*> (Just 2) <*> (Just 3)
  print $ runWriter (tw <*> tt)
