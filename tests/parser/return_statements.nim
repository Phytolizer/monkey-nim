from monkeypkg/ast import tokenLiteral
from monkeypkg/lexer import newLexer
from monkeypkg/parser import newParser, parseProgram
import common
import std/strformat

type
  Test = object
    input: string
    expectedValue: int

func newTest(input: string, expectedValue: int): Test =
  Test(input: input, expectedValue: expectedValue)

const tests = [
  newTest("return 5;", 5),
  newTest("return 10;", 10),
  newTest("return 993322;", 993322),
]

for tt in tests:
  let l = newLexer(tt.input)
  var p = newParser(l)
  let program = p.parseProgram()
  p.checkParserErrors()

  if program.statements.len != 1:
    raiseAssert fmt"program.statements.len not 1. got={program.statements.len}"

  let returnStmt = ast.ReturnStatement(program.statements[0])
  if returnStmt.tokenLiteral() != "return":
    raiseAssert fmt"returnStmt.tokenLiteral() not 'return'. got='{returnStmt.tokenLiteral()}'"
