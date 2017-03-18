{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -fno-warn-implicit-prelude #-}
module Paths_helloworld (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,0,1] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "C:\\Users\\Artemy\\Documents\\mirea-haskell-lectures\\artemy-urodovskikh\\HelloWorld\\.stack-work\\install\\65995373\\bin"
libdir     = "C:\\Users\\Artemy\\Documents\\mirea-haskell-lectures\\artemy-urodovskikh\\HelloWorld\\.stack-work\\install\\65995373\\lib\\x86_64-windows-ghc-8.0.2\\helloworld-0.0.1-iyEAkzEHv4COHJm8vXNp5"
dynlibdir  = "C:\\Users\\Artemy\\Documents\\mirea-haskell-lectures\\artemy-urodovskikh\\HelloWorld\\.stack-work\\install\\65995373\\lib\\x86_64-windows-ghc-8.0.2"
datadir    = "C:\\Users\\Artemy\\Documents\\mirea-haskell-lectures\\artemy-urodovskikh\\HelloWorld\\.stack-work\\install\\65995373\\share\\x86_64-windows-ghc-8.0.2\\helloworld-0.0.1"
libexecdir = "C:\\Users\\Artemy\\Documents\\mirea-haskell-lectures\\artemy-urodovskikh\\HelloWorld\\.stack-work\\install\\65995373\\libexec"
sysconfdir = "C:\\Users\\Artemy\\Documents\\mirea-haskell-lectures\\artemy-urodovskikh\\HelloWorld\\.stack-work\\install\\65995373\\etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "helloworld_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "helloworld_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "helloworld_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "helloworld_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "helloworld_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "helloworld_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "\\" ++ name)
