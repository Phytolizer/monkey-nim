from lexer import newLexer, nextToken
from token import nil
import std/strformat

const
  Prompt = ">> "

proc start*(i: File, o: File) =
  while true:
    o.write(Prompt)
    o.flushFile()
    var line = ""
    if not i.readLine(line):
      break
    var l = newLexer(line)
    var tok = l.nextToken()
    while tok.kind != token.kEof:
      echo fmt"{{Kind:{tok.kind} Literal:{tok.literal}}}"
      tok = l.nextToken()
