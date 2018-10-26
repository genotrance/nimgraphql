# Package

version       = "0.1.0"
author        = "genotrance"
description   = "libgraphqlparser wrapper for Nim"
license       = "MIT"

skipDirs = @["tests"]

# Dependencies

requires "nimgen >= 0.4.0"

import distros

var cmd = ""
if detectOs(Windows):
  cmd = "cmd /c "

task setup, "Checkout and generate":
  exec cmd & "nimgen nimgraphql.cfg"

before install:
  setupTask()

task test, "Run tests":
  exec "nim cpp -r tests/testgql"
