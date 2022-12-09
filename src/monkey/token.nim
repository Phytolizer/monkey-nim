import std/macros

type TokenKind* = distinct string

proc `==`*(a, b: TokenKind): bool {.borrow.}

type Token* = object
  kind*: TokenKind
  literal*: string

macro defineTokenTypes(body: untyped): untyped =
  result = nnkStmtList.newTree()
  doAssert body.kind == nnkStmtList
  for line in body:
    doAssert line.kind == nnkConstSection
    for cval in line:
      doAssert cval.kind == nnkConstDef
      doAssert cval[0].kind == nnkPostfix
      doAssert cval[0][0] == ident"*"
      doAssert cval[0][1].kind == nnkIdent
      doAssert cval[1].kind == nnkEmpty
      doAssert cval[2].kind == nnkStrLit
      let name = cval[0][1]
      let value = cval[2]

      result.add quote do:
        const `name`* = `value`.TokenKind

defineTokenTypes:
  const
    ILLEGAL* = "ILLEGAL"
    EOF* = "EOF"
    IDENT* = "IDENT"
    INT* = "INT"
    ASSIGN* = "="
    PLUS* = "+"
    COMMA* = ","
    SEMICOLON* = ";"
    LPAREN* = "("
    RPAREN* = ")"
    LBRACE* = "{"
    RBRACE* = "}"
    FUNCTION* = "FUNCTION"
    LET* = "LET"
