import std/[
  strformat,
  strutils,
  unittest,
]

from monkey/token import `==`
import monkey/lexer

suite "lexer":
  test "next token":
    const input = dedent"""
      let five = 5;
      let ten = 10;

      let add = fn(x, y) {
        x + y;
      };

      let result = add(five, ten);
    """

    type Case = object
      expectedKind: token.TokenKind
      expectedLiteral: string

    proc newCase(kind: token.TokenKind, literal: string): Case {.inline.} =
      Case(expectedKind: kind, expectedLiteral: literal)

    const tests = [
      newCase(token.ASSIGN, "="),
      newCase(token.PLUS, "+"),
      newCase(token.LPAREN, "("),
      newCase(token.RPAREN, ")"),
      newCase(token.LBRACE, "{"),
      newCase(token.RBRACE, "}"),
      newCase(token.COMMA, ","),
      newCase(token.SEMICOLON, ";"),
      newCase(token.EOF, ""),
    ]

    var l = newLexer(input)

    for (i, tt) in tests.pairs:
      let tok = l.nextToken()
      checkpoint(fmt"tests[{i}]")
      check:
        tok.kind == tt.expectedKind
        tok.literal == tt.expectedLiteral
