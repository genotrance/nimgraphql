# Package

version       = "0.2.0"
author        = "genotrance"
description   = "libgraphqlparser wrapper for Nim"
license       = "MIT"

skipDirs = @["tests"]

# Dependencies

requires "nimterop >= 0.4.4"

task test, "Run tests":
  exec "nim cpp -d:GraphQLAstGit -p:.. -r tests/tnimgraphql.nim"
  exec "nim cpp -d:GraphQLAstGit -d:GraphQLAstCompile -p:.. -r tests/tnimgraphql.nim"
