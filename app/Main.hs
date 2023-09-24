module Main (main) where
import System.IO (openFile, hGetContents, IOMode(ReadMode))
import Lib (latexStr, latexToSixel)

main :: IO ()
main = do
    handle <- openFile "README.md" ReadMode
    contents <- hGetContents handle
    latexToSixel contents
