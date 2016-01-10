module Adder where

data AdderF k = Add Int k
                | Clear k
                | Total (Int -> k)

instance (Show k) => Show (AdderF k) where
  show (Add n k) = " Add " ++ show n ++ show  k
  show (Clear k) = " Clear " ++ show k
  show (Total g) = " Total " ++ show (g 0)


instance Functor AdderF where
  fmap f (Add n k) = Add n (f k)
  fmap f (Clear k) = Clear (f k)
  fmap f (Total g) = Total (f . g)

data CoAdderF k = CoAdderF {runAdd :: Int -> k,
                            runClear :: k,
                            runTotal :: (Int , k)}

instance Functor CoAdderF where
  fmap f (CoAdderF a c t) = undefined
