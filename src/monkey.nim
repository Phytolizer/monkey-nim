from monkeypkg/repl import nil
from posix import getlogin_r
import std/strutils
import std/strformat

when isMainModule:
  var user = "\0".repeat(32)
  var buffer = user.cstring()
  discard getlogin_r(buffer, 32)
  echo fmt"Hello {user}! This is the Monkey programming language!"
  echo "Feel free to type in commands"
  repl.start(stdin, stdout)
