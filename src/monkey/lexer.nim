from token import nil

type Lexer* = object
  input: string
  position: int
  readPosition: int
  ch: char

proc peekChar(l: Lexer): char =
  if l.readPosition >= l.input.len:
    '\0'
  else:
    l.input[l.readPosition]

proc readChar(l: var Lexer) =
  l.ch = l.peekChar
  l.position = l.readPosition
  l.readPosition.inc

proc newLexer*(input: string): Lexer =
  result.input = input
  result.readChar()

proc newToken(kind: token.TokenKind, ch: char): token.Token =
  result.kind = kind
  result.literal = $ch

proc nextToken*(l: var Lexer): token.Token =
  case l.ch
  of '=':
    result = newToken(token.ASSIGN, l.ch)
  of ';':
    result = newToken(token.SEMICOLON, l.ch)
  of '(':
    result = newToken(token.LPAREN, l.ch)
  of ')':
    result = newToken(token.RPAREN, l.ch)
  of ',':
    result = newToken(token.COMMA, l.ch)
  of '+':
    result = newToken(token.PLUS, l.ch)
  of '{':
    result = newToken(token.LBRACE, l.ch)
  of '}':
    result = newToken(token.RBRACE, l.ch)
  of '\0':
    result.kind = token.EOF
  else: discard

  l.readChar()
