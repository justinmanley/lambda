module Language.Lambda.AST where

import Language.Lambda.Types

type Program = Expression

-- Variables are identified by their de Bruin indices.
data Var = Var Int

data Expression
    = LambdaExp Expression
    | AppExp Expression Expression
    | VarExp Var
    | TupleExp [Expression]
    | StringLiteral String
    | BoolLiteral Bool
    | IntLiteral Int

