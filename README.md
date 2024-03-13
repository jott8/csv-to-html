# csv-to-html

This is my first program in Haskell!

It takes a CSV file and converts it to a HTML table. You can even provide a custom CSS file.

## Usage

1. Compile it with ghc (no external libaries are needed)
2. Run the program with the input, css and output paths provided as command line arguments

Example: 
```
./main example.csv styles.css example_output.html
```

## Disclaimer

At this point, neither error handling nor string escaping is implemented, which means that the program expects ...

1. three (valid!) command-line-arguments as shown above.
3. a header line containing M elements (&rarr; M-1 commas).
4. each line of the body to have M-1 commas as well (empty entries are possible but the right amount of commas is important!).
5. entries without additional commas.
