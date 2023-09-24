# markdown-preview-haskell

## Setup

- `stack build` to compile program
- `stack build --file-watch --exec markdown-preview-haskell-exe` to build and hot reload changes
- `stack ghci` to load and debug single functions

## How mark down is converted

- Scan markdown from file
- Convert scanned markdown into latex string
- Output latex string into temporary file
- Run `pdflatex` program with latex file input to convert to pdf
- run ImageMagic `convert` to convert pdf into png
- Run ImageMagic `convert` to convert png into sixel

## Requirements

- latex
- ImageMagick
- Stack
- netpbm

