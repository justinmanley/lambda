module Language.Lambda.AST where

import Language.Lambda.Types

type Program = UntypedExpression

-- Variables are identified by their de Bruin indices.
data Var = Var { _index :: Int }
    deriving Show

data Annotated a = Annotated
    { _annotation :: a
    , _expression :: Expression a
    } deriving Show

type TypedExpression = Annotated Type
type UntypedExpression = Annotated () 

untyped :: Expression () -> Program
untyped = Annotated ()

data Expression a
    = LambdaExp (Annotated a)
    | AppExp (Annotated a) (Annotated a)
    | VarExp Var
    | TupleExp [Annotated a]
    | StringLiteral String
    | BoolLiteral Bool
    | IntLiteral Int
    deriving Show

