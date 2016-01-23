module Adder where

data AdderF k = Add Int k
data ClearF k = Clear k
data TotalF k = Total (Int -> k)


instance Functor AdderF where
  fmap f (Add n k) = Add n (f k)
instance Functor ClearF where
  fmap f (Clear k) = Clear (f k)
instance Functor TotalF where
  fmap f (Total g) = Total (f . g)

data CoAdderF k = CoAdd{runAdd :: Int -> k}
data CoClearF k = CoClear {runClear :: k}
data CoTotalF k = CoTotal {runTotal :: (Int , k)}

instance Functor CoAdderF where
  fmap f (CoAdd g)  = CoAdd (f . g)
instance Functor CoClearF where
  fmap f (CoClear k) = CoClear (f k)
instance Functor CoTotalF where
  fmap f (CoTotal (n, k)) = CoTotal (n, f k)

-- joined version
data AdF k = Ad Int k | Cl k | To (Int -> k)
data CoAdF k = CoAd { runCoAd :: Int -> k , runCoCl :: k, runCoTo :: (Int , k)}

instance Functor AdF where
  fmap f (Ad n k) = Ad n (f k)
  fmap f (Cl k) = Cl (f k)
  fmap f (To g) = To (f . g)

instance Functor CoAdF where
  fmap f (CoAd a c t) = CoAd
    (f . a)
    (f c)
    (fmap f t)
