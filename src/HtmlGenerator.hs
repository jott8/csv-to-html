module HtmlGenerator where

type HTML    = String
type CSS     = String
type HTMLTag = String

wrapTag :: HTMLTag -> String -> HTML
wrapTag tag value = mconcat ["<",tag,">",value,"</",tag,">"]

row :: String -> HTML
row = wrapTag "tr"

table :: HTML -> HTML
table = wrapTag "table"

finishWith :: CSS -> HTML ->  HTML
finishWith css content = mconcat ["<!DOCTYPE HTML>\n",cssTagged,"\n",content] 
    where cssTagged = wrapTag "style" css

