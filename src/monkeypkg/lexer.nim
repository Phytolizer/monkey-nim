from token import Token

type
  Lexer = object
    input: string
    position: int
    readPosition: int
    ch: char

func newLexer*(input: string): Lexer =
  Lexer(input: input)

func nextToken*(l: var Lexer): Token =
  Token()
