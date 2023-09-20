module Main (main) where
import Data.ByteString as BS
import Data.Char (ord)

import System.IO
-- import Lib

main :: IO ()
main = do
    -- handle <- openFile "../src/assets/TEST.md" ReadMode
    -- contents <- hGetContents handle
    let sixelDataHead = "1;2;3q#0;2;0;0;0#1;2;100;100;0#2;2;0;100;0"
    let sixelString = sixelDataHead ++ convertAlphabetToSixel alphabetBitMap
    BS.putStr (generateSixel sixelString)

generateSixel :: String -> ByteString
generateSixel bitmap = BS.concat [header, body, footer]
    where header = BS.pack [0x1b, 0x50] -- ESC P
          body = BS.pack (Prelude.map (fromIntegral . ord) bitmap) -- convert bitmap to bytestring
          footer = BS.pack [0x1b, 0x5c] -- ESC \

alphabetBitMap :: [[[Bool]]]
alphabetBitMap = [a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z]
                    where 
                        a = [[False, False, True, False, False],
                             [False, True, False, True, False],
                             [True, False, False, False, True],
                             [True, True, False, True, True],
                             [True, False, False, False, True]]
                        b = [[True, True, True, True, False],
                             [True, False, False, False, True],
                             [True, False, False, True, False],
                             [True, False, False, False, True],
                             [True, True, True, True, False]]
                        c = [[False, True, True, True, False],
                             [True, False, False, False, True],
                             [True, False, False, False, False],
                             [True, False, False, False, True],
                             [False, True, True, True, False]]
                        d = [[True, True, True, True, False],
                             [True, False, False, False, True],
                             [True, False, False, False, True],
                             [True, False, False, False, True],
                             [True, True, True, True, False]]
                        e = [[True, True, True, True, True],
                             [True, False, False, False, False],
                             [True, True, True, True, False],
                             [True, False, False, False, False],
                             [True, True, True, True, True]]
                        f = [[True, True, True, True, True],
                             [True, False, False, False, False],
                             [True, True, True, True, False],
                             [True, False, False, False, False],
                             [True, False, False, False, False]]
                        g = [[False, True, True, True, False],
                             [True, False, False, False, True],
                             [True, False, False, False, False],
                             [True, False, False, True, False],
                             [False, True, True, True, False]]
                        h = [[True, False, False, False, True],
                             [True, False, False, False, True],
                             [True, True, True, True, True],
                             [True, False, False, False, True],
                             [True, False, False, False, True]]
                        i = [[True, True, True, True, True],
                             [False, True, False, True, False],
                             [False, True, False, True, False],
                             [False, True, False, True, False],
                             [True, True, True, True, True]]
                        j = [[False, False, False, False, True],
                             [False, False, False, False, True],
                             [False, False, False, False, True],
                             [True, False, False, False, True],
                             [False, True, True, True, False]]
                        k = [[True, False, False, False, True],
                             [True, False, False, True, False],
                             [True, True, True, False, False],
                             [True, False, False, True, False],
                             [True, False, False, False, True]]
                        l = [[True, False, False, False, False],
                             [True, False, False, False, False],
                             [True, False, False, False, False],
                             [True, False, False, False, False],
                             [True, True, True, True, True]]
                        m = [[True, False, False, False, True],
                             [True, True, False, True, True],
                             [True, False, True, False, True],
                             [True, False, False, False, True],
                             [True, False, False, False, True]]
                        n = [[True, False, False, False, True],
                             [True, True, False, False, True],
                             [True, False, True, False, True],
                             [True, False, False, True, True],
                             [True, False, False, False, True]]
                        o = [[False, True, True, True, False],
                             [True, False, False, False, True],
                             [True, False, False, False, True],
                             [True, False, False, False, True],
                             [False, True, True, True, False]]
                        p = [[True, True, True, True, False],
                             [True, False, False, False, True],
                             [True, True, True, True, False],
                             [True, False, False, False, False],
                             [True, False, False, False, False]]
                        q = [[False, True, True, True, False],
                             [True, False, False, False, True],
                             [True, False, False, False, True],
                             [True, False, True, False, True],
                             [False, True, True, True, True]]
                        r = [[True, True, True, True, False],
                             [True, False, False, False, True],
                             [True, True, True, True, False],
                             [True, False, False, True, False],
                             [True, False, False, False, True]]
                        s = [[False, True, True, True, True],
                             [True, False, False, False, False],
                             [False, True, True, True, False],
                             [False, False, False, False, True],
                             [True, True, True, True, False]]
                        t = [[True, True, True, True, True],
                             [False, True, False, True, False],
                             [False, True, False, True, False],
                             [False, True, False, True, False],
                             [False, True, False, True, False]]
                        u = [[True, False, False, False, True],
                             [True, False, False, False, True],
                             [True, False, False, False, True],
                             [True, False, False, False, True],
                             [False, True, True, True, False]]
                        v = [[True, False, False, False, True],
                             [True, False, False, False, True],
                             [True, False, False, False, True],
                             [False, True, False, True, False],
                             [False, False, True, False, False]]
                        w = [[True, False, False, False, True],
                             [True, False, False, False, True],
                             [True, False, True, False, True],
                             [True, True, False, True, True],
                             [True, False, False, False, True]]
                        x = [[True, False, False, False, True],
                             [False, True, False, True, False],
                             [False, False, True, False, False],
                             [False, True, False, True, False],
                             [True, False, False, False, True]]
                        y = [[True, False, False, False, True],
                             [False, True, False, True, False],
                             [False, False, True, False, False],
                             [False, False, True, False, False],
                             [False, False, True, False, False]]
                        z = [[True, True, True, True, True],
                             [False, False, False, True, False],
                             [False, False, True, False, False],
                             [False, True, False, False, False],
                             [True, True, True, True, True]]

convertLetterToSixel :: [[Bool]] -> String
convertLetterToSixel letter = Prelude.concat (Prelude.map convertRowToSixel letter)
    where convertRowToSixel row = "#1" ++ Prelude.concat (Prelude.map convertPixelToSixel row) ++ "$-"
          convertPixelToSixel pixel = if pixel then "~" else "?"

convertAlphabetToSixel :: [[[Bool]]] -> String
convertAlphabetToSixel alphabet = Prelude.concat (Prelude.map convertLetterToSixel alphabet)
