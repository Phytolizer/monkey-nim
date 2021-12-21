from monkeypkg/token import nil
from monkeypkg/lexer import newLexer, nextToken
import std/strformat
import std/strutils

const
  Input = """
    let five = 5;
    let ten = 10;

    let add = fn(x, y) {
      x + y;
    };

    let result = add(five, ten);
""".strip

type
  Test = object
    expectedKind: token.Kind
    expectedLiteral: string

func newTest(expectedKind: token.Kind, expectedLiteral: string): Test =
  Test(expectedKind: expectedKind, expectedLiteral: expectedLiteral)

const
  Tests = @[
    newTest(token.kLet, "let"),
    newTest(token.kIdent, "five"),
    newTest(token.kAssign, "="),
    newTest(token.kInt, "5"),
    newTest(token.kSemicolon, ";"),
    newTest(token.kLet, "let"),
    newTest(token.kIdent, "ten"),
    newTest(token.kAssign, "="),
    newTest(token.kInt, "10"),
    newTest(token.kSemicolon, ";"),
    newTest(token.kLet, "let"),
    newTest(token.kIdent, "add"),
    newTest(token.kAssign, "="),
    newTest(token.kFunction, "fn"),
    newTest(token.kLParen, "("),
    newTest(token.kIdent, "x"),
    newTest(token.kComma, ","),
    newTest(token.kIdent, "y"),
    newTest(token.kRParen, ")"),
    newTest(token.kLBrace, "{"),
    newTest(token.kIdent, "x"),
    newTest(token.kPlus, "+"),
    newTest(token.kIdent, "y"),
    newTest(token.kSemicolon, ";"),
    newTest(token.kRBrace, "}"),
    newTest(token.kSemicolon, ";"),
    newTest(token.kLet, "let"),
    newTest(token.kIdent, "result"),
    newTest(token.kAssign, "="),
    newTest(token.kIdent, "add"),
    newTest(token.kLParen, "("),
    newTest(token.kIdent, "five"),
    newTest(token.kComma, ","),
    newTest(token.kIdent, "ten"),
    newTest(token.kRParen, ")"),
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
