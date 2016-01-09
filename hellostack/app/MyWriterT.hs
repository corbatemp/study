module MyWriterT where

import Control.Monad
import Control.Arrow
import Control.Applicative

newtype MyWriterT w m a = MyWriterT {runMuWriterT:: m (a,w)}

instance (Functor m) => Functor (MyWriterT w m) where
  fmap f (MyWriterT ma) = MyWriterT (fmap (first f) ma)

instance (Applicative m, Monoid w) => Applicative (MyWriterT w m) where
  pure r = MyWriterT $ pure (r, mempty)
  (MyWriterT mfab) <*> (MyWriterT mfa) = MyWriterT $ liftA2 k mfab mfa where
                                                    k ~(fab, s') ~(fa, s'') = (fab fa, s' `mappend` s'')

--nstance (Monad m, Monoid w) =>
