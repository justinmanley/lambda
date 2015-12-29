Lambda
======

This is a demo compiler for a super-simple functional expression language based on the lambda calculus. It's very limited, and is meant as a jumping-off point for further language-based experiments and projects.

This is a useful demo project showing how [Alex](https://www.haskell.org/alex/) (Haskell-based [lexer](https://en.wikipedia.org/wiki/Lexical_analysis)) and [Happy](https://www.haskell.org/happy/) (Haskell-based parser) can work together.

### Running the compiler

You must have [`GHC`](https://www.haskell.org/ghc/) and [`cabal`](https://www.haskell.org/cabal/) installed in order to build and run the compiler. You can build the compiler by running the following at the command line, in the same directory as this repository:


```bash
cabal sandbox init
cabal install alex happy # cabal doesn't automatically install build tools
cabal install --only-dependencies
cabal build lambda-compiler
```

You can run the compiler on the example file provided with:

```bash
cabal run --verbose=0 lambda-compiler < examples/Example.lambda | runhaskell
``` 
