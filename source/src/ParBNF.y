-- This Happy file was machine-generated by the BNF converter
{
{-# OPTIONS_GHC -fno-warn-incomplete-patterns -fno-warn-overlapping-patterns #-}
module ParBNF where
import qualified AbsBNF
import LexBNF
}

%name pLGrammar LGrammar
%name pLDef LDef
%name pListLDef ListLDef
%name pListIdentifier ListIdentifier
%name pGrammar Grammar
%name pListDef ListDef
%name pDef Def
%name pItem Item
%name pListItem ListItem
%name pCat Cat
%name pLabel Label
%name pLabelId LabelId
%name pProfItem ProfItem
%name pIntList IntList
%name pListInteger ListInteger
%name pListIntList ListIntList
%name pListProfItem ListProfItem
%name pArg Arg
%name pListArg ListArg
%name pSeparation Separation
%name pListString ListString
%name pExp Exp
%name pExp1 Exp1
%name pExp2 Exp2
%name pListExp ListExp
%name pListExp2 ListExp2
%name pRHS RHS
%name pListRHS ListRHS
%name pMinimumSize MinimumSize
%name pReg Reg
%name pReg1 Reg1
%name pReg2 Reg2
%name pReg3 Reg3
-- no lexer declaration
%monad { Either String } { (>>=) } { return }
%tokentype {Token}
%token
  '(' { PT _ (TS _ 1) }
  ')' { PT _ (TS _ 2) }
  '*' { PT _ (TS _ 3) }
  '+' { PT _ (TS _ 4) }
  ',' { PT _ (TS _ 5) }
  '-' { PT _ (TS _ 6) }
  '.' { PT _ (TS _ 7) }
  ':' { PT _ (TS _ 8) }
  '::=' { PT _ (TS _ 9) }
  ';' { PT _ (TS _ 10) }
  '=' { PT _ (TS _ 11) }
  '?' { PT _ (TS _ 12) }
  '[' { PT _ (TS _ 13) }
  ']' { PT _ (TS _ 14) }
  '_' { PT _ (TS _ 15) }
  'char' { PT _ (TS _ 16) }
  'coercions' { PT _ (TS _ 17) }
  'comment' { PT _ (TS _ 18) }
  'define' { PT _ (TS _ 19) }
  'delimiters' { PT _ (TS _ 20) }
  'digit' { PT _ (TS _ 21) }
  'entrypoints' { PT _ (TS _ 22) }
  'eps' { PT _ (TS _ 23) }
  'internal' { PT _ (TS _ 24) }
  'layout' { PT _ (TS _ 25) }
  'letter' { PT _ (TS _ 26) }
  'lower' { PT _ (TS _ 27) }
  'nonempty' { PT _ (TS _ 28) }
  'position' { PT _ (TS _ 29) }
  'rules' { PT _ (TS _ 30) }
  'separator' { PT _ (TS _ 31) }
  'stop' { PT _ (TS _ 32) }
  'terminator' { PT _ (TS _ 33) }
  'token' { PT _ (TS _ 34) }
  'toplevel' { PT _ (TS _ 35) }
  'upper' { PT _ (TS _ 36) }
  'views' { PT _ (TS _ 37) }
  '{' { PT _ (TS _ 38) }
  '|' { PT _ (TS _ 39) }
  '}' { PT _ (TS _ 40) }
  L_quoted { PT _ (TL $$) }
  L_integ  { PT _ (TI $$) }
  L_charac { PT _ (TC $$) }
  L_doubl  { PT _ (TD $$) }
  L_Identifier { PT _ (T_Identifier $$) }

%%

String  :: { String }
String   : L_quoted { $1 }

Integer :: { Integer }
Integer  : L_integ  { (read ($1)) :: Integer }

Char    :: { Char }
Char     : L_charac { (read ($1)) :: Char }

Double  :: { Double }
Double   : L_doubl  { (read ($1)) :: Double }

Identifier :: { AbsBNF.Identifier}
Identifier  : L_Identifier { AbsBNF.Identifier $1 }

LGrammar :: { AbsBNF.LGrammar }
LGrammar : ListLDef { AbsBNF.LGr $1 }
LDef :: { AbsBNF.LDef }
LDef : Def { AbsBNF.DefAll $1 }
     | ListIdentifier ':' Def { AbsBNF.DefSome $1 $3 }
     | 'views' ListIdentifier { AbsBNF.LDefView $2 }
ListLDef :: { [AbsBNF.LDef] }
ListLDef : {- empty -} { [] }
         | LDef { (:[]) $1 }
         | LDef ';' ListLDef { (:) $1 $3 }
         | ';' ListLDef { $2 }
ListIdentifier :: { [AbsBNF.Identifier] }
ListIdentifier : Identifier { (:[]) $1 }
               | Identifier ',' ListIdentifier { (:) $1 $3 }
Grammar :: { AbsBNF.Grammar }
Grammar : ListDef { AbsBNF.Grammar $1 }
ListDef :: { [AbsBNF.Def] }
ListDef : {- empty -} { [] }
        | Def { (:[]) $1 }
        | Def ';' ListDef { (:) $1 $3 }
        | ';' ListDef { $2 }
Def :: { AbsBNF.Def }
Def : Label '.' Cat '::=' ListItem { AbsBNF.Rule $1 $3 $5 }
    | 'comment' String { AbsBNF.Comment $2 }
    | 'comment' String String { AbsBNF.Comments $2 $3 }
    | 'internal' Label '.' Cat '::=' ListItem { AbsBNF.Internal $2 $4 $6 }
    | 'token' Identifier Reg { AbsBNF.Token $2 $3 }
    | 'position' 'token' Identifier Reg { AbsBNF.PosToken $3 $4 }
    | 'entrypoints' ListIdentifier { AbsBNF.Entryp $2 }
    | 'separator' MinimumSize Cat String { AbsBNF.Separator $2 $3 $4 }
    | 'terminator' MinimumSize Cat String { AbsBNF.Terminator $2 $3 $4 }
    | 'delimiters' Cat String String Separation MinimumSize { AbsBNF.Delimiters $2 $3 $4 $5 $6 }
    | 'coercions' Identifier Integer { AbsBNF.Coercions $2 $3 }
    | 'rules' Identifier '::=' ListRHS { AbsBNF.Rules $2 $4 }
    | 'define' Identifier ListArg '=' Exp { AbsBNF.Function $2 $3 $5 }
    | 'layout' ListString { AbsBNF.Layout $2 }
    | 'layout' 'stop' ListString { AbsBNF.LayoutStop $3 }
    | 'layout' 'toplevel' { AbsBNF.LayoutTop }
Item :: { AbsBNF.Item }
Item : String { AbsBNF.Terminal $1 } | Cat { AbsBNF.NTerminal $1 }
ListItem :: { [AbsBNF.Item] }
ListItem : {- empty -} { [] } | Item ListItem { (:) $1 $2 }
Cat :: { AbsBNF.Cat }
Cat : '[' Cat ']' { AbsBNF.ListCat $2 }
    | Identifier { AbsBNF.IdCat $1 }
Label :: { AbsBNF.Label }
Label : LabelId { AbsBNF.LabNoP $1 }
      | LabelId ListProfItem { AbsBNF.LabP $1 $2 }
      | LabelId LabelId ListProfItem { AbsBNF.LabPF $1 $2 $3 }
      | LabelId LabelId { AbsBNF.LabF $1 $2 }
LabelId :: { AbsBNF.LabelId }
LabelId : Identifier { AbsBNF.Id $1 }
        | '_' { AbsBNF.Wild }
        | '[' ']' { AbsBNF.ListE }
        | '(' ':' ')' { AbsBNF.ListCons }
        | '(' ':' '[' ']' ')' { AbsBNF.ListOne }
ProfItem :: { AbsBNF.ProfItem }
ProfItem : '(' '[' ListIntList ']' ',' '[' ListInteger ']' ')' { AbsBNF.ProfIt $3 $7 }
IntList :: { AbsBNF.IntList }
IntList : '[' ListInteger ']' { AbsBNF.Ints $2 }
ListInteger :: { [Integer] }
ListInteger : {- empty -} { [] }
            | Integer { (:[]) $1 }
            | Integer ',' ListInteger { (:) $1 $3 }
ListIntList :: { [AbsBNF.IntList] }
ListIntList : {- empty -} { [] }
            | IntList { (:[]) $1 }
            | IntList ',' ListIntList { (:) $1 $3 }
ListProfItem :: { [AbsBNF.ProfItem] }
ListProfItem : ProfItem { (:[]) $1 }
             | ProfItem ListProfItem { (:) $1 $2 }
Arg :: { AbsBNF.Arg }
Arg : Identifier { AbsBNF.Arg $1 }
ListArg :: { [AbsBNF.Arg] }
ListArg : {- empty -} { [] } | Arg ListArg { (:) $1 $2 }
Separation :: { AbsBNF.Separation }
Separation : {- empty -} { AbsBNF.SepNone }
           | 'terminator' String { AbsBNF.SepTerm $2 }
           | 'separator' String { AbsBNF.SepSepar $2 }
ListString :: { [String] }
ListString : String { (:[]) $1 }
           | String ',' ListString { (:) $1 $3 }
Exp :: { AbsBNF.Exp }
Exp : Exp1 ':' Exp { AbsBNF.Cons $1 $3 } | Exp1 { $1 }
Exp1 :: { AbsBNF.Exp }
Exp1 : Identifier ListExp2 { AbsBNF.App $1 $2 } | Exp2 { $1 }
Exp2 :: { AbsBNF.Exp }
Exp2 : Identifier { AbsBNF.Var $1 }
     | Integer { AbsBNF.LitInt $1 }
     | Char { AbsBNF.LitChar $1 }
     | String { AbsBNF.LitString $1 }
     | Double { AbsBNF.LitDouble $1 }
     | '[' ListExp ']' { AbsBNF.List $2 }
     | '(' Exp ')' { $2 }
ListExp :: { [AbsBNF.Exp] }
ListExp : {- empty -} { [] }
        | Exp { (:[]) $1 }
        | Exp ',' ListExp { (:) $1 $3 }
ListExp2 :: { [AbsBNF.Exp] }
ListExp2 : Exp2 { (:[]) $1 } | Exp2 ListExp2 { (:) $1 $2 }
RHS :: { AbsBNF.RHS }
RHS : ListItem { AbsBNF.RHS $1 }
ListRHS :: { [AbsBNF.RHS] }
ListRHS : RHS { (:[]) $1 } | RHS '|' ListRHS { (:) $1 $3 }
MinimumSize :: { AbsBNF.MinimumSize }
MinimumSize : 'nonempty' { AbsBNF.MNonempty }
            | {- empty -} { AbsBNF.MEmpty }
Reg :: { AbsBNF.Reg }
Reg : Reg '|' Reg1 { AbsBNF.RAlt $1 $3 } | Reg1 { $1 }
Reg1 :: { AbsBNF.Reg }
Reg1 : Reg1 '-' Reg2 { AbsBNF.RMinus $1 $3 } | Reg2 { $1 }
Reg2 :: { AbsBNF.Reg }
Reg2 : Reg2 Reg3 { AbsBNF.RSeq $1 $2 } | Reg3 { $1 }
Reg3 :: { AbsBNF.Reg }
Reg3 : Reg3 '*' { AbsBNF.RStar $1 }
     | Reg3 '+' { AbsBNF.RPlus $1 }
     | Reg3 '?' { AbsBNF.ROpt $1 }
     | 'eps' { AbsBNF.REps }
     | Char { AbsBNF.RChar $1 }
     | '[' String ']' { AbsBNF.RAlts $2 }
     | '{' String '}' { AbsBNF.RSeqs $2 }
     | 'digit' { AbsBNF.RDigit }
     | 'letter' { AbsBNF.RLetter }
     | 'upper' { AbsBNF.RUpper }
     | 'lower' { AbsBNF.RLower }
     | 'char' { AbsBNF.RAny }
     | '(' Reg ')' { $2 }
{

happyError :: [Token] -> Either String a
happyError ts = Left $
  "syntax error at " ++ tokenPos ts ++
  case ts of
    []      -> []
    [Err _] -> " due to lexer error"
    t:_     -> " before `" ++ (prToken t) ++ "'"

myLexer = tokens
}

