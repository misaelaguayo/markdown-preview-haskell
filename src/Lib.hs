module Lib
    ( someFunc,
      latexStr,
      latexToSixel,
      prettify,
      headerSize
    ) where

import System.Directory (getCurrentDirectory)
import System.Process (readProcessWithExitCode, readCreateProcessWithExitCode, shell)
import Data.List.Split (splitOn)

latexStr :: String -> String
latexStr str = 
    "\\documentclass[a4paper]{article}\n"
    ++ "\\usepackage{titlesec}\n"
    ++ "\\titleformat*{\\section}{\\LARGE\\bfseries}\n"
    ++ "\\titleformat*{\\subsection}{\\Large\\bfseries}\n"
    ++ "\\titleformat*{\\subsubsection}{\\large\\bfseries}\n"
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
    writeFile (sixelDir ++ "/sixel.tex") (latexStr str)
    (_, _, _) <- readProcessWithExitCode "pdflatex" ["-output-directory=" ++ sixelDir, sixelDir ++ "/sixel.tex"] ""
    (_, _, _) <- readProcessWithExitCode "convert" [sixelDir ++ "/sixel.pdf", sixelDir ++ "/sixel.png"] ""
    let createSixelCommand = "convert " ++ sixelDir ++ "/sixel.png ppm:- | ppmtosixel > " ++ sixelDir ++ "/sixel.sixel"
    readCreateProcessWithExitCode (shell createSixelCommand) ""
    >>= \(_, _, _) -> return ()

prettify :: String -> (Float, String)
prettify contents
    | headerSize splitSentence > 0 = (headerSize splitSentence, unwords (drop 1 splitSentence))
    | otherwise = (0, contents)
    where splitSentence = splitOn " " contents

headerSize :: [String] -> Float
headerSize splitSentence
    | head splitSentence == "#" = 4
    | head splitSentence == "##" = 2.5
    | head splitSentence == "##" = 2
    | otherwise = 0

someFunc :: IO ()
someFunc = putStrLn "someFunc"
