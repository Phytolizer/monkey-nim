from monkeypkg/lexer import newLexer
from monkeypkg/parser import newParser, parseProgram
import common
import std/strformat

type
  Test = object
    input: string
    expectedIdentifier: string

func newTest(input: string, expectedIdentifier: string): Test =
  Test(input: input, expectedIdentifier: expectedIdentifier)

const
  Tests = [
    newTest("let x = 5;", "x"),
    newTest("let y = 10;", "y"),
    newTest("let foobar = 838383;", "foobar"),
  ]

for i, tt in Tests:
  let l = newLexer(tt.input)
  var p = newParser(l)
  let program = p.parseProgram()
  p.checkParserErrors()
  if program.isNil:
    raiseAssert fmt"tests[{i}] - parseProgram() returned nil"
  if program.statements.len != 1:
    raiseAssert fmt"tests[{i}] - program.statements.length is not 1. got={program.statements.len}"
  checkLetStatement(program.statements[0], tt.expectedIdentifier)
