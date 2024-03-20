import System.Environment ( getArgs )

import CsvParser          ( Document, Structure (..), parseCSV )
import HtmlGenerator      ( HTML, wrapTag, row, table, finishWith )

customTd :: Structure -> HTML
customTd (CsvStringLit s) = wrapTag "td" s
customTd (CsvString s)    = wrapTag "td" s
customTd (CsvInt i)       = wrapTag "td" (show i)

customTable :: Document -> HTML
customTable = table . unlines . map (row . concatMap customTd)

main :: IO ()
main = do
    (csvPath:cssPath:outputPath:_) <- getArgs
    parsed                         <- parseCSV csvPath
    css                            <- readFile cssPath

    writeFile outputPath (finishWith css . customTable $ parsed)

    putStrLn $ "\n Done! Output has been written to '" <> outputPath <> "'"
