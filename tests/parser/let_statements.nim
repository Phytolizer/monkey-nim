from monkeypkg/lexer import newLexer
from monkeypkg/parser import newParser, parseProgram

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
  if program.isNil:
    raiseAssert "parseProgram() returned nil"
