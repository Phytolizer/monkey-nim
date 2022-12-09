# Package

version       = "0.1.0"
author        = "Kyle Coffey"
description   = "Monkey in Nim"
license       = "MIT"
srcDir        = "src"
binDir        = "bin"

# Dependencies

task test, "Run tests":
  exec "nim c --outDir:bin -r tests/runTests.nim"

requires "nim >= 1.6.10"
