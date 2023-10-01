import System.IO (openFile, hGetContents, IOMode(ReadMode))
import Data.List.Split (splitOn)
import Lib ( latexToSixel, handleHeader)

main :: IO ()
main = do
    handle <- openFile "README.md" ReadMode
    contents <- hGetContents handle
    latexToSixel (convertMarkdownToLatex contents)

convertMarkdownToLatex :: String -> String
convertMarkdownToLatex contents =
    convertMarkdownToLatex' (lines contents)

convertMarkdownToLatex' :: [String] -> String
convertMarkdownToLatex' [] = ""
convertMarkdownToLatex' (x:xs)
    | x == "" = convertMarkdownToLatex' xs
    | head x == '#' = handleHeader x ++ convertMarkdownToLatex' xs
    | head x == '-' = handleBullet x ++ convertMarkdownToLatex' xs
    | otherwise = x ++ "\n" ++ convertMarkdownToLatex' xs

handleBullet :: String -> String
handleBullet str = 
    "\\begin{itemize}\n\\item " ++ unwords (drop 1 (splitOn " " str)) ++ "\n\\end{itemize}\n"
