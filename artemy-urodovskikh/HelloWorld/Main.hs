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

toTree :: FilePath -> FilePath ->IO Tree
toTree context fp = doesDirectoryExist (context++fp) >>= \isDir ->
  case isDir of
  	True -> 
  	 -- putStrLn
  	 listDirectory (context++fp) >>= \list -> 
  	 toTrees (context++fp+"/") list >>= \x ->
  	 return (Directory fp x)
  	False -> return (File fp)

prettyPrint' :: Int -> Tree -> String
prettyPrint' i (File fp) = replicate i ' ' ++ fp
prettyPrint' i (Directory fp trees)
 = replicate i ' ' ++ fp ++ "/" ++ "/\n"
 ++ unlines (map (prettyPrint' (i+1)) trees) 

prettyPrint :: Tree -> String
prettyPrint = prettyPrint' 0

main :: IO ()
main = toTree "./" "." >>= putStrLn . prettyPrint