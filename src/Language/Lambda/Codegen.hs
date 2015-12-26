module Language.Lambda.Codegen (genProg) where

import Language.Lambda.AST
import Language.Haskell.Syntax

genProg :: Program -> HsModule
genProg = mkMain . genExp 0

mkMain :: HsExp -> HsModule
mkMain exp = HsModule emptySrcLoc (Module "Main") Nothing [] 
    $ [ HsFunBind $ [ HsMatch emptySrcLoc (HsIdent "main") [] body [] ] ]
    where 
        hsPutStrLn, hsShow :: HsExp
        hsPutStrLn = HsVar . UnQual . HsIdent $ "putStrLn"
        hsShow = HsVar . UnQual . HsIdent $ "show"

        hsCompose :: HsQOp 
        hsCompose = HsQVarOp . UnQual . HsSymbol $ "."

        body :: HsRhs
        body = HsUnGuardedRhs $
            HsApp (HsInfixApp hsPutStrLn hsCompose hsShow) (HsParen exp)

-- The depth is used for generating variable patterns in lambdas.
genExp :: Int -> Annotated a -> HsExp
genExp depth exp = case _expression exp of
    LambdaExp body -> genLambda depth body 
    AppExp fn arg -> HsApp (genExp depth fn) (genExp depth arg)
    VarExp (Var id) -> HsVar . UnQual . genVar $ id
    TupleExp components -> HsTuple $ map (genExp depth) components
    StringLiteral str -> HsLit $ HsString str
    BoolLiteral bool -> HsCon . UnQual . HsIdent $ show bool
    IntLiteral int -> HsLit . HsInt $ toInteger int

genLambda :: Int -> Annotated a -> HsExp
genLambda depth exp = HsLambda emptySrcLoc [HsPVar $ genVar depth]
    $ genExp (depth + 1) exp 

genVar :: Int -> HsName
genVar var = HsIdent $ "v" ++ show var

emptySrcLoc :: SrcLoc
emptySrcLoc = SrcLoc "" 0 0

