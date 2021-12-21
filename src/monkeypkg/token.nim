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

  kComma*: Kind = ","
  kSemicolon*: Kind = ";"

  kLParen*: Kind = "("
  kRParen*: Kind = ")"
  kLBrace*: Kind = "{"
  kRBrace*: Kind = "}"

  kFunction*: Kind = "FUNCTION"
  kLet*: Kind = "LET"

  Keywords = toTable(@[
    ("fn", kFunction),
    ("let", kLet),
  ])

func lookupIdent*(ident: string): Kind =
  Keywords.getOrDefault(ident, kIdent)
