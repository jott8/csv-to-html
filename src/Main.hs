import System.Environment ( getArgs )

import CsvParser          ( Document, parseCSV )
import HtmlGenerator      ( finishWith, HTML, row, wrapTag, table, td )

customTable :: Document -> HTML
customTable = table . unlines . map (row . concatMap td)

main :: IO ()
main = do
    (csvPath:cssPath:outputPath:_) <- getArgs
    parsed                         <- parseCSV csvPath
    css                            <- readFile cssPath

    writeFile outputPath (finishWith css . customTable $ parsed)

    putStrLn $ "\n Done! Output has been written to '" <> outputPath <> "'"
