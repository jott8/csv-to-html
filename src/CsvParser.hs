module CsvParser where

import Combinators         ( char, int, sepBy, stringLit, token, word, Parser (parse) )
import Control.Applicative ( (<|>) )
import Data.Maybe          ( catMaybes )

data Structure 
    = CsvString String
    | CsvStringLit String
    | CsvInt Int
    deriving Show

type Line     = [Structure]
type Document = [Line]

handleFile :: String -> [Maybe ([Structure],String)]
handleFile file = map f lined
    where lined = lines file
          f = parse (sepBy (char ',') csvParser)

csvString :: Parser Structure
csvString = CsvString <$> token word

csvStringLit :: Parser Structure
csvStringLit = CsvStringLit <$> token stringLit

csvInt :: Parser Structure
csvInt = CsvInt <$> token int

csvParser :: Parser Structure
csvParser = csvString <|> csvStringLit <|> csvInt

parseCSV :: String -> IO Document
parseCSV fileName = do
    file <- readFile fileName
    let parsed = handleFile file
    return $ map fst . catMaybes $ parsed
