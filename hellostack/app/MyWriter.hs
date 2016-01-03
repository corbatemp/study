module MyWriter where

data MyWriter m a = MyWriter { runMyWriter::(a, m) }

instance Functor (MyWriter m) where
  fmap f m = let (a, s) = runMyWriter m
             in MyWriter (f a, s)

instance (Monoid m) => Applicative (MyWriter m) where
  pure r = MyWriter (r, mempty)
  (MyWriter (fa, s)) <*> (MyWriter (a, s')) = MyWriter (fa a, s `mappend` s')

instance (Monoid m) => Monad (MyWriter m) where
  return r = MyWriter (r, mempty)
  (MyWriter (r, s)) >>= f = let (r', s') = runMyWriter (f r)
                            in MyWriter (r', s `mappend` s')

mainwriter :: IO ()
mainwriter = do
  print "hello mywriter"
  print ""
