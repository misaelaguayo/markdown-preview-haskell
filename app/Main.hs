module Main (main) where
import Data.ByteString as BS
import Data.Char (ord)

import System.IO
-- import Lib

main :: IO ()
main = do
    -- handle <- openFile "../src/assets/TEST.md" ReadMode
    -- contents <- hGetContents handle
    let sixelString = "q\
        \#0;2;0;0;0#1;2;100;100;0#2;2;0;100;0\
        \#1~~@@vv@@~~$\
        \#2??}}GG}}??}-\
        \#1!14@"
    BS.putStr (generateSixel sixelString)

generateSixel :: String -> ByteString
generateSixel bitmap = BS.concat [header, body, footer]
    where header = BS.pack [0x1b, 0x50] -- ESC P
          body = BS.pack (Prelude.map (fromIntegral . ord) bitmap) -- convert bitmap to bytestring
          footer = BS.pack [0x1b, 0x5c] -- ESC \
