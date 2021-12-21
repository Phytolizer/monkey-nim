import std/tables

type
  Kind* = string
  Token* = object
    kind*: Kind
    literal*: string

const
  kIllegal*: Kind = "ILLEGAL"
  kEof*: Kind = "EOF"

  kIdent*: Kind = "IDENT"
  kInt*: Kind = "INT"

  kAssign*: Kind = "="
  kPlus*: Kind = "+"
  kMinus*: Kind = "-"
  kBang*: Kind = "!"
  kSlash*: Kind = "/"
  kAsterisk*: Kind = "*"
  kLt*: Kind = "<"
  kGt*: Kind = ">"

  kEq*: Kind = "=="
  kNotEq*: Kind = "!="

  kComma*: Kind = ","
  kSemicolon*: Kind = ";"

  kLParen*: Kind = "("
  kRParen*: Kind = ")"
  kLBrace*: Kind = "{"
  kRBrace*: Kind = "}"

  kFunction*: Kind = "FUNCTION"
  kLet*: Kind = "LET"
  kIf*: Kind = "IF"
  kElse*: Kind = "ELSE"
  kReturn*: Kind = "RETURN"
  kTrue*: Kind = "TRUE"
  kFalse*: Kind = "FALSE"

  Keywords = toTable(@[
    ("fn", kFunction),
    ("let", kLet),
    ("if", kIf),
    ("else", kElse),
    ("return", kReturn),
    ("true", kTrue),
    ("false", kFalse),
  ])

func lookupIdent*(ident: string): Kind =
  Keywords.getOrDefault(ident, kIdent)
