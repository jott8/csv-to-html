module Main where

import Converter

import System.Environment (getArgs)
import qualified Data.Text.IO as TIO

main :: IO ()
main = do
    (csvFileName:cssFileName:outputFileName:_) <- getArgs
    csvFile                                    <- TIO.readFile csvFileName
    cssFile                                    <- TIO.readFile cssFileName
    
    let htmlTable = csvToHTMLTable csvFile
    let html      = getHTML htmlTable cssFile

    TIO.writeFile outputFileName html
    putStrLn ("Converting done. Output has been written to '" <> outputFileName <> "'") 
