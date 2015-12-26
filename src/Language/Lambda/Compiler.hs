module Language.Lambda.Compiler where

import Control.Applicative ((<$>))
import Language.Haskell.Pretty (prettyPrint)
import Language.Haskell.Syntax

import Language.Lambda.Codegen
import Language.Lambda.Grammar
import Language.Lambda.Tokens

compile :: String -> String
compile = prettyPrint . genProg . parse . tokenize

main :: IO ()
main = getContents >>= putStrLn . compile
