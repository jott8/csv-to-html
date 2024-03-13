{-# LANGUAGE OverloadedStrings #-}
import System.Environment
import qualified Data.Text as T
import qualified Data.Text.IO as TIO

type HTML    = T.Text
type HTMLTag = T.Text
type CSVRaw  = T.Text
type CSV     = (T.Text,[T.Text])

wrapTag :: HTMLTag -> T.Text -> HTML
wrapTag tag value = mconcat ["<",tag,">",value,"</",tag,">"]

toRow :: HTMLTag -> T.Text -> HTML
toRow tag = wrapTag "tr" . mconcat . map (wrapTag tag) . lineElements 

csvToHTMLTable :: CSVRaw -> HTML
csvToHTMLTable csvRaw = wrapTag "table" combined
    where (headerCSV,bodyCSV) = separateContent csvRaw
          headerHTML          = toRow "th" headerCSV
          bodyHTML            = T.unlines . map (toRow "td") $ bodyCSV
          combined            = T.unlines [headerHTML,bodyHTML]

getHTML :: HTML -> T.Text -> HTML
getHTML content css = mconcat ["<!DOCTYPE HTML>\n",body] 
    where cssTag = wrapTag "style" css
          body   = wrapTag "body" $ mconcat [cssTag,content]
    
separateContent :: CSVRaw -> CSV
separateContent content = (header,body)
    where asLines = T.lines content
          header  = head asLines
          body    = tail asLines

lineElements :: T.Text -> [T.Text]
lineElements = T.splitOn ","

main :: IO ()
main = do
    (csvFileName:cssFileName:outputFileName:_) <- getArgs
    csvFile                                    <- TIO.readFile csvFileName
    cssFile                                    <- TIO.readFile cssFileName
    
    let htmlTable = csvToHTMLTable csvFile
    let html      = getHTML htmlTable cssFile

    TIO.writeFile outputFileName html
