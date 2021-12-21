from monkeypkg/ast import tokenLiteral
import std/strformat

func checkLetStatement*(s: ast.Statement, name: string) =
  if s.tokenLiteral() != "let":
    raiseAssert fmt"s.tokenLiteral() not 'let'. got='{s.tokenLiteral()}'"
  let letStmt = ast.LetStatement(s)
  if letStmt.name.value != name:
    raiseAssert fmt"s.name.value not '{name}'. got='{letStmt.name.value}'"
  if letStmt.name.tokenLiteral() != name:
    raiseAssert fmt"s.name.tokenLiteral() not '{name}'. got='{letStmt.name.tokenLiteral()}'"
