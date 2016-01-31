module Paths_hellolens (
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

bindir     = "C:\\Users\\petr\\Work\\Haskell\\repo\\study\\hellolens\\.stack-work\\install\\d4203e17\\bin"
libdir     = "C:\\Users\\petr\\Work\\Haskell\\repo\\study\\hellolens\\.stack-work\\install\\d4203e17\\lib\\x86_64-windows-ghc-7.10.2\\hellolens-0.1.0.0-AxF8Po1HJ5J4bEgy8AiLWg"
datadir    = "C:\\Users\\petr\\Work\\Haskell\\repo\\study\\hellolens\\.stack-work\\install\\d4203e17\\share\\x86_64-windows-ghc-7.10.2\\hellolens-0.1.0.0"
libexecdir = "C:\\Users\\petr\\Work\\Haskell\\repo\\study\\hellolens\\.stack-work\\install\\d4203e17\\libexec"
sysconfdir = "C:\\Users\\petr\\Work\\Haskell\\repo\\study\\hellolens\\.stack-work\\install\\d4203e17\\etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "hellolens_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "hellolens_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "hellolens_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "hellolens_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "hellolens_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "\\" ++ name)
