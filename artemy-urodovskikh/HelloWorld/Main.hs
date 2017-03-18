module Main where
import System.Directory

-- main :: IO () -- последовательность команд с результатом ничего
-- return :: a -> IO a
-- a1 >> a2 выполняет сначала a1, затем a2

f :: Int -> [Char] -> IO ()
f n s = 
 case n of
  0 -> return ()
  n -> putStrLn s >> f (n-1) s

data Tree = File FilePath | Directory FilePath [Tree]
 deriving Show

exampleTree = Directory "." [Directory "src" [File "Hello.hs"], File "hello.cabal"]

toTrees :: [FilePath] -> IO [Tree]
toTrees [] = return []
toTrees (path:paths) = toTree path >>= \x ->
 toTrees paths >>= \xs ->
  return(x:xs)

toTree :: FilePath -> IO Tree
toTree fp = doesDirectoryExist fp >>= \isDir ->
  case isDir of
  	True -> 
  	 listDirectory fp >>= \list -> 
  	 toTrees list >>= \x ->
  	 return (Directory fp x)
  	False -> return (File fp)

main :: IO ()
main = listDirectory "." >>= print