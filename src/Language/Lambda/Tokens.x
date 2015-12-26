{ 
module Language.Lambda.Tokens ( tokenize, Token(..)) where 
}

%wrapper "basic"

tokens :-
    $white+             ;
    "--".*              ;
    "T|F"               { \s -> case s of
                            "T" -> BoolToken True
                            "F" -> BoolToken False
                            _   -> error "Unreachable" 
                        }
    "\"(\\.|[^\"])*\""  { \s -> StringToken s }
    [0-9]+              { \s -> IntToken (read s) } 
    "λ."                { \s -> LambdaToken }
    "("                 { \s -> OpenParenToken }
    ")"                 { \s -> CloseParenToken }
    ","                 { \s -> CommaToken }
    "$"[0-9]+           { \s -> VarToken (read $ tail s) }

{

data Token 
    = LambdaToken
    | OpenParenToken
    | CloseParenToken
    | CommaToken
    | StringToken String
    | IntToken Int
    | BoolToken Bool
    | VarToken Int
    deriving Show

tokenize = alexScanTokens
}

    
