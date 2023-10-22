import System.Environment
import System.IO (openFile, hGetContents, IOMode(ReadMode))
import Lib ( latexToSixel, handleBullet, handleHeader)

main :: IO ()
main = do
    args <- getArgs
    if length args /= 1
        then putStrLn usageString
    else do
        let file = head args
        handle <- openFile file ReadMode
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

usageString :: String
usageString = "Usage: stack run <file.md>"
