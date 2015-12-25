{
module Language.Lambda.Grammar (parse) where

import Language.Lambda.Tokens
import Language.Lambda.AST
}

%name parse
%tokentype  { Token }
%error      { parseError }

%token 
    lambda      { LambdaToken }
    '('         { OpenParenToken }
    ')'         { CloseParenToken }
    ','         { CommaToken }
    string      { StringToken $$ }
    int         { IntToken $$ }
    bool        { BoolToken $$ }
    var         { VarToken $$ } 

%%

Expression  : lambda Expression         { LambdaExp $2 }
            | ApplicandExp Expression   { AppExp $1 $2 } 
            | '(' Expression ')'        { $2 }
            | '(' TupleExp ')'          { TupleExp $2 } 
            | var                       { VarExp (Var $1) }
            | int                       { IntLiteral $1 } 
            | bool                      { BoolLiteral $1 }
            | string                    { StringLiteral $1 }

ApplicandExp    : var                   { VarExp (Var $1) }
                | '(' Expression ')'    { $2 }

TupleExp    : Expression ',' Expression { [$3, $1] }
            | TupleExp ',' Expression   { $3 : $1 }

{
parseError :: [Token] -> a
parseError _ = error "Parse error"
}
