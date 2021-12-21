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

func readIdentifier(l: var Lexer): string =
  let position = l.position
  while l.ch in 'a'..'z':
    l.readChar()
  l.input[position..<l.position]

func readNumber(l: var Lexer): string =
  let position = l.position
  while l.ch in '0'..'9':
    l.readChar()
  l.input[position..<l.position]

func skipWhitespace(l: var Lexer) =
  while l.ch in {' ', '\t', '\n', '\r'}:
    l.readChar()

func nextToken*(l: var Lexer): Token =
  result = Token()

  l.skipWhitespace()

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
  of 'a'..'z':
    result.literal = l.readIdentifier()
    result.kind = token.lookupIdent(result.literal)
    return result
  of '0'..'9':
    result.literal = l.readNumber()
    result.kind = token.kInt
    return result
  else:
    result = newToken(token.kIllegal, l.ch)

  l.readChar()
