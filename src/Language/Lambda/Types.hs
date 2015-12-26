module Language.Lambda.Types where

-- Primitive types (String, Int, Bool), and composite (union) types.
data Type
    = StringType
    | IntType
    | BoolType
    | TupleType [Type]
    | FunctionType 
        { _from :: Type
        , _to :: Type
        }


