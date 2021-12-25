from monkeypkg/token import Token
from monkeypkg/ast import toString
import std/strformat

let program = ast.Program(
  statements: @[
    ast.Statement(
      ast.LetStatement(
        token: Token(kind: token.kLet, literal: "let"),
        name: ast.Identifier(
          token: Token(kind: token.kIdent, literal: "myVar"),
          value: "myVar",
        ),
        value: ast.Identifier(
          token: Token(kind: token.kIdent, literal: "anotherVar"),
          value: "anotherVar",
        ),
      )
    ),
  ],
)

if program.toString() != "let myVar = anotherVar;":
  raiseAssert fmt"program.toString() wrong. got='{program.toString()}'"
