module CsvParser where

import Combinators         ( char, endBy, noneOf, Parser (..), sepBy, stringLit )
import Control.Applicative ( (<|>), many )
import Data.Maybe          ( fromMaybe )

type Document = [Line]
type Line     = [Cell]
type Cell     = String

csvParser :: Parser Document
csvParser = line `endBy` eol

line :: Parser Line
line = cell `sepBy` char ','

cell :: Parser Cell
cell= stringLit <|> many (noneOf ",\n")

eol :: Parser Char
eol = char '\n'

parseCSV :: FilePath -> IO Document
parseCSV fileName = do
    file <- readFile fileName
    let parsed = parse csvParser file
    return $ maybe [] fst parsed
