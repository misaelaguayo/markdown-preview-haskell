module Lib
    ( latexStr,
      latexToSixel,
      prettify,
      handleHeader,
      headerSize
    ) where

import System.Directory (getCurrentDirectory)
import System.Process (readProcessWithExitCode, readCreateProcessWithExitCode, shell)
import Data.List.Split (splitOn)
import Data.ByteString as BS

latexStr :: String -> String
latexStr str = 
    "\\documentclass[14pt]{extreport}\n"
    ++ "\\usepackage[a3paper]{geometry}\n"
    ++ "\\usepackage{titlesec}\n"
    ++ "\\titleformat*{\\section}{\\Huge\\bfseries}\n"
    ++ "\\titleformat*{\\subsection}{\\LARGE\\bfseries}\n"
    ++ "\\titleformat*{\\subsubsection}{\\Large\\bfseries}\n"
    ++ "\\titleformat*{\\paragraph}{\\large\\bfseries}\n"
    ++ "\\titleformat*{\\subparagraph}{\\large\\bfseries}\n"
    ++ "\\oddsidemargin=0pt\n"
    ++ "\\headsep=0pt\n"
    ++ "\\headheight=0pt\n"
    ++ "\\topmargin=0pt\n"
    ++ "\\topmargin=-1in\n"
    ++ "\\begin{document}\n"
    ++ str
    ++ "\\end{document}\n"

latexToSixel :: String -> IO ()
latexToSixel str = do
    dir <- getCurrentDirectory
    let sixelDir = dir ++ "/sixel"
    Prelude.writeFile (sixelDir ++ "/sixel.tex") (latexStr str)
    (_, _, _) <- readProcessWithExitCode "pdflatex" ["-output-directory=" ++ sixelDir, sixelDir ++ "/sixel.tex"] ""
    (_, _, _) <- readProcessWithExitCode "convert" [sixelDir ++ "/sixel.pdf", sixelDir ++ "/sixel.png"] ""
    let createSixelCommand = "convert " ++ sixelDir ++ "/sixel.png ppm:- | ppmtosixel > " ++ sixelDir ++ "/sixel.sixel"
    (_, _, _ ) <- readCreateProcessWithExitCode (shell createSixelCommand) ""
    contents <- BS.readFile (sixelDir ++ "/sixel.sixel")
    BS.putStr contents

prettify :: String -> (Float, String)
prettify contents
    | headerSize splitSentence > 0 = (headerSize splitSentence, unwords (Prelude.drop 1 splitSentence))
    | otherwise = (0, contents)
    where splitSentence = splitOn " " contents

headerSize :: [String] -> Float
headerSize splitSentence
    | Prelude.head splitSentence == "#" = 4
    | Prelude.head splitSentence == "##" = 2.5
    | Prelude.head splitSentence == "##" = 2
    | otherwise = 0

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
          headerSize = case Prelude.head splitHeader of
              "#" -> (1 :: Integer)
              "##" -> 2
              "###" -> 3
              "####" -> 4
              "#####" -> 5
              "######" -> 6
              _ -> 0
          parsedHeader = unwords (Prelude.drop 1 splitHeader)
