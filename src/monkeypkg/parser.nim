from ast import nil
from lexer import Lexer, newLexer, nextToken
from token import Token

type Parser* = object
  l: Lexer
  curToken: Token
  peekToken: Token

func newParser*(l: Lexer): Parser =
  Parser(l: l)

func nextToken(p: var Parser) =
  p.curToken = p.peekToken
  p.peekToken = p.l.nextToken()

func parseProgram*(p: var Parser): ast.Program =
  nil
