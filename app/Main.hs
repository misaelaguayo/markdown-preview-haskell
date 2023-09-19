module Main (main) where

import System.IO
-- import Lib

main :: IO ()
main = do
    handle <- openFile "../src/assets/TEST.md" ReadMode
    contents <- hGetContents handle
    writeFile "../src/assets/TEST.sixel" (generateSixel contents)

generateSixel :: String -> String
generateSixel s = s
