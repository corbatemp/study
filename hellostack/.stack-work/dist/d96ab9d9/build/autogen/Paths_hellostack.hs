module Paths_hellostack (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "C:\\Users\\petr\\Work\\Haskell\\repo\\study\\hellostack\\.stack-work\\install\\d4203e17\\bin"
libdir     = "C:\\Users\\petr\\Work\\Haskell\\repo\\study\\hellostack\\.stack-work\\install\\d4203e17\\lib\\x86_64-windows-ghc-7.10.2\\hellostack-0.1.0.0-DpO6QLemaln1SI9nzNf3KH"
datadir    = "C:\\Users\\petr\\Work\\Haskell\\repo\\study\\hellostack\\.stack-work\\install\\d4203e17\\share\\x86_64-windows-ghc-7.10.2\\hellostack-0.1.0.0"
libexecdir = "C:\\Users\\petr\\Work\\Haskell\\repo\\study\\hellostack\\.stack-work\\install\\d4203e17\\libexec"
sysconfdir = "C:\\Users\\petr\\Work\\Haskell\\repo\\study\\hellostack\\.stack-work\\install\\d4203e17\\etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "hellostack_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "hellostack_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "hellostack_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "hellostack_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "hellostack_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "\\" ++ name)
