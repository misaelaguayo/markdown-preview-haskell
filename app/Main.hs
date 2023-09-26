module Main (main) where
import Data.List.Split (splitOn)
import System.IO (openFile, hGetContents, IOMode(ReadMode))
import Lib ( latexToSixel)

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
    | otherwise = x ++ "\n" ++ convertMarkdownToLatex' xs

handleHeader :: String -> String
handleHeader str = 
    case headerSize of
        1 -> "\\section*{" ++ parsedHeader ++ "}\n"
        2 -> "\\subsection*{" ++ parsedHeader ++ "}\n"
        3 -> "\\subsubsection*{" ++ parsedHeader ++ "}\n"
        4 -> "\\paragraph*{" ++ parsedHeader ++ "}\n"
        5 -> "\\subparagraph*{" ++ parsedHeader ++ "}\n"
        _ -> str ++ "\n"
    where splitHeader = splitOn " " str
          headerSize = case head splitHeader of
              "#" -> (1 :: Integer)
              "##" -> 2
              "###" -> 3
              "####" -> 4
              "#####" -> 5
              "######" -> 6
              _ -> 0
          parsedHeader = unwords (drop 1 splitHeader)
