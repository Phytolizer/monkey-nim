from monkeypkg/token import nil
from monkeypkg/lexer import newLexer, nextToken
import std/strformat

const
  Input = "=+(){},;"

type
  Test = object
    expectedKind: token.Kind
    expectedLiteral: string

func newTest(expectedKind: token.Kind, expectedLiteral: string): Test =
  Test(expectedKind: expectedKind, expectedLiteral: expectedLiteral)

const
  Tests = @[
    newTest(token.kAssign, "="),
    newTest(token.kPlus, "+"),
    newTest(token.kLParen, "("),
    newTest(token.kRParen, ")"),
    newTest(token.kLBrace, "{"),
    newTest(token.kRBrace, "}"),
    newTest(token.kComma, ","),
    newTest(token.kSemicolon, ";"),
    newTest(token.kEof, "")
  ]

var l = newLexer(Input)

for i, tt in Tests:
  let tok = l.nextToken()

  if tok.kind != tt.expectedKind:
    raiseAssert fmt"tests[{i}] - tokentype wrong. expected='{tt.expectedKind}', got='{tok.kind}'"
  if tok.literal != tt.expectedLiteral:
    raiseAssert fmt"tests[{i}] - literal wrong. expected='{tt.expectedLiteral}', got='{tok.literal}'"
