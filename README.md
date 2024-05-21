# markdown-preview-haskell

Convert a markdown file and display in terminal using sixels

## Use

`stack run [name-of-markdown]`

## Setup

- `stack build` to compile program
- `stack build --file-watch --exec 'markdown-preview-haskell-exe README.md'` to build and hot reload changes
- `stack ghci` to load and debug single functions

## How mark down is converted

- Scan markdown from file
- Convert scanned markdown into latex string
- Output latex string into temporary file
- Run `pdflatex` program with latex file input to convert to pdf
- run ImageMagic `convert` to convert pdf into jpeg
- Run chafa to convert to either sixel or kitty

## Requirements

- A [terminal](https://www.arewesixelyet.com/) which supports sixel
- Install [chafa](https://github.com/hpjansson/chafa) for displaying graphics in terminal
- Latex
- Stack
- ImageMagick
- GhostScript
