import os, strutils, strformat

import nimterop/[build, cimport]

const
  baseDir* = getProjectCacheDir("nimgraphql")
  c = baseDir / "c"
  buildCache = baseDir / "buildcache"

  gastNode = c / "GraphQLAstNode.h"
  gParser = c / "GraphQLParser.h"
  gAstToJSON = c / "GraphQLAstToJSON.h"

proc GraphQLAstPreBuild(outdir, header: string) =
  let
    f = outdir / "CMakeLists.txt"
  writeFile(f, readFile(f).replace("ADD_SUBDIRECTORY", "#ADD_SUBDIRECTORY"))
  if execAction(&"cd {outdir} && git pull --depth=100 origin master").ret == 0:
    if execAction(&"cd {outdir} && git pull --tags origin master").ret != 0:
      echo "Error in preBuild()"
      quit(1)

getHeader(
  header = "GraphQLAst.h",
  giturl = "https://github.com/graphql/libgraphqlparser",
  outdir = baseDir,
  altNames =  "graphqlparser"
)

static:
  cDebug()

cOverride:
  type
    AstNode* {.importc: "struct GraphQLAstNode", bycopy.} = object

when defined(GraphQLCompile):
  cImport(GraphQLAstPath, flags = "-E=GraphQL")
  cImport(gastNode, flags = "-E=GraphQL")
  cImport(gParser, flags = "-E=graphql_ -E=GraphQL")
  cImport(gAstToJSON, flags = "-E=graphql_ -E=GraphQL")

  cIncludeDir(baseDir)
  cIncludeDir(c)
  cIncludeDir(buildCache)

  cCompile(baseDir / "*.cpp", exclude = "dump_json_ast")
  cCompile(c / "*.cpp")
  cCompile(buildCache / "*.cpp")
else:
  cImport(GraphQLAstPath, dynlib = "GraphQLAstLPath", flags = "-E=GraphQL")
  cImport(gastNode, dynlib = "GraphQLAstLPath", flags = "-E=GraphQL")
  cImport(gParser, dynlib = "GraphQLAstLPath", flags = "-E=graphql_ -E=GraphQL")
  cImport(gAstToJSON, dynlib = "GraphQLAstLPath", flags = "-E=graphql_ -E=GraphQL")