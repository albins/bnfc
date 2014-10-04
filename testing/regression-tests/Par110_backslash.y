-- This Happy file was machine-generated by the BNF converter
{
{-# OPTIONS_GHC -fno-warn-incomplete-patterns -fno-warn-overlapping-patterns #-}
module Par110_backslash where
import Abs110_backslash
import Lex110_backslash
import ErrM

}

%name pS S

-- no lexer declaration
%monad { Err } { thenM } { returnM }
%tokentype { Token }

%token 
 "/\\" { PT _ (TS _ 1) }

L_err    { _ }


%%


S :: { S }
S : "/\\" { S } 



{

returnM :: a -> Err a
returnM = return

thenM :: Err a -> (a -> Err b) -> Err b
thenM = (>>=)

happyError :: [Token] -> Err a
happyError ts =
  Bad $ "syntax error at " ++ tokenPos ts ++ 
  case ts of
    [] -> []
    [Err _] -> " due to lexer error"
    _ -> " before " ++ unwords (map (id . prToken) (take 4 ts))

myLexer = tokens
}

