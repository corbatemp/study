module MyState where

data MyState s a = MyState {runMyState :: s -> (a, s)}

instance Functor (MyState s) where
  fmap f (MyState m) = MyState $ \ s -> let (a, s') = m s
                                        in (f a, s')

instance Applicative (MyState s) where
  pure r = MyState $ \ s -> (r, s)
  (MyState mab) <*> (MyState ma) = MyState $ \ s -> let (fab, s') = mab s
                                                        (fa, s'') = ma s'
                                                    in (fab fa, s'')

instance Monad (MyState s) where
  return r = MyState $ \ s -> (r,s)
  (MyState m) >>= f = MyState $ \ s -> let (a, s') = m s
                                       in runMyState (f a) s'
