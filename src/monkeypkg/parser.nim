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

func curTokenIs(p: Parser, kind: token.Kind): bool =
  p.curToken.kind == kind

func peekTokenIs(p: Parser, kind: token.Kind): bool =
  p.peekToken.kind == kind

func expectPeek(p: var Parser, kind: token.Kind): bool =
  if p.peekTokenIs(kind):
    p.nextToken()
    true
  else:
    false

func parseLetStatement(p: var Parser): ast.LetStatement =
  result = ast.LetStatement(token: p.curToken)

  if not p.expectPeek(token.kIdent):
    return nil

  result.name = ast.Identifier(token: p.curToken, value: p.curToken.literal)

  if not p.expectPeek(token.kAssign):
    return nil

  # TODO: skip expressions until ;
  while not p.curTokenIs(token.kSemicolon):
    p.nextToken()

func parseStatement(p: var Parser): ast.Statement =
  case p.curToken.kind:
  of token.kLet:
    return p.parseLetStatement()
  else:
    return nil

func parseProgram*(p: var Parser): ast.Program =
  result = ast.Program()
  result.statements = @[]

  while p.curToken.kind != token.kEof:
    let stmt = p.parseStatement()
    if stmt != nil:
      result.statements.add(stmt)
    p.nextToken()
