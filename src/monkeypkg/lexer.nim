from token import Token

type
  Lexer = object
    input: string
    position: int
    readPosition: int
    ch: char

func peekChar(l: Lexer): char =
  if l.readPosition >= l.input.len:
    '\0'
  else:
    l.input[l.readPosition]

func readChar(l: var Lexer) =
  l.ch = l.peekChar()
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
    if l.peekChar() == '=':
      let ch = l.ch
      l.readChar()
      result = Token(kind: token.kEq, literal: $ch & $l.ch)
    else:
      result = newToken(token.kAssign, l.ch)
  of '!':
    if l.peekChar() == '=':
      let ch = l.ch
      l.readChar()
      result = Token(kind: token.kNotEq, literal: $ch & $l.ch)
    else:
      result = newToken(token.kBang, l.ch)
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
  of '-':
    result = newToken(token.kMinus, l.ch)
  of '/':
    result = newToken(token.kSlash, l.ch)
  of '*':
    result = newToken(token.kAsterisk, l.ch)
  of '<':
    result = newToken(token.kLt, l.ch)
  of '>':
    result = newToken(token.kGt, l.ch)
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
