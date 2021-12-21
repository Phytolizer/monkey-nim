from token import Token

type
  Lexer = object
    input: string
    position: int
    readPosition: int
    ch: char

func readChar(l: var Lexer) =
  if l.readPosition >= l.input.len:
    l.ch = '\0'
  else:
    l.ch = l.input[l.readPosition]
  l.position = l.readPosition
  l.readPosition += 1

func newLexer*(input: string): Lexer =
  result = Lexer(input: input)
  result.readChar()

func newToken(kind: token.Kind, literal: char): Token =
  Token(kind: kind, literal: $literal)

func nextToken*(l: var Lexer): Token =
  result = Token()

  case l.ch:
  of '=':
    result = newToken(token.kAssign, l.ch)
  of ';':
    result = newToken(token.kSemicolon, l.ch)
  of '(':
    result = newToken(token.kLParen, l.ch)
  of ')':
    result = newToken(token.kRParen, l.ch)
  of '{':
    result = newToken(token.kLBrace, l.ch)
  of '}':
    result = newToken(token.kRBrace, l.ch)
  of ',':
    result = newToken(token.kComma, l.ch)
  of '+':
    result = newToken(token.kPlus, l.ch)
  of '\0':
    result.kind = token.kEof
    result.literal = ""
  else:
    result = newToken(token.kIllegal, l.ch)

  l.readChar()
