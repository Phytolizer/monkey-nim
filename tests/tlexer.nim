import std/[
  strformat,
  strutils,
  unittest,
]

from monkey/token import `==`, `$`
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
      newCase(token.LET, "let"),
      newCase(token.IDENT, "five"),
      newCase(token.ASSIGN, "="),
      newCase(token.INT, "5"),
      newCase(token.SEMICOLON, ";"),
      newCase(token.LET, "let"),
      newCase(token.IDENT, "ten"),
      newCase(token.ASSIGN, "="),
      newCase(token.INT, "10"),
      newCase(token.SEMICOLON, ";"),
      newCase(token.LET, "let"),
      newCase(token.IDENT, "add"),
      newCase(token.ASSIGN, "="),
      newCase(token.FUNCTION, "fn"),
      newCase(token.LPAREN, "("),
      newCase(token.IDENT, "x"),
      newCase(token.COMMA, ","),
      newCase(token.IDENT, "y"),
      newCase(token.RPAREN, ")"),
      newCase(token.LBRACE, "{"),
      newCase(token.IDENT, "x"),
      newCase(token.PLUS, "+"),
      newCase(token.IDENT, "y"),
      newCase(token.SEMICOLON, ";"),
      newCase(token.RBRACE, "}"),
      newCase(token.SEMICOLON, ";"),
      newCase(token.LET, "let"),
      newCase(token.IDENT, "result"),
      newCase(token.ASSIGN, "="),
      newCase(token.IDENT, "add"),
      newCase(token.LPAREN, "("),
      newCase(token.IDENT, "five"),
      newCase(token.COMMA, ","),
      newCase(token.IDENT, "ten"),
      newCase(token.RPAREN, ")"),
      newCase(token.SEMICOLON, ";"),
      newCase(token.EOF, ""),
    ]

    var l = newLexer(input)

    for (i, tt) in tests.pairs:
      let tok = l.nextToken()
      checkpoint(fmt"tests[{i}]")
      require:
        tok.kind == tt.expectedKind
        tok.literal == tt.expectedLiteral
