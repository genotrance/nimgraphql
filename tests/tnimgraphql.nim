import os, unittest, nimgraphql

suite "GraphQL Parsing Tests":

  setup:
    var error: ptr cstring

  proc checkAST(astNode: ptr AstNode, error: ptr cstring) =
    if astNode.isNil:
      echo $error[]
      errorFree(error[])
      require(false)

  test "parsing without schema support":
    let ast = parseString(readFile(baseDir / "test/kitchen-sink.graphql").cstring, error)

    checkAST(ast, error)

    let json = astToJson(ast)
    require($json == $readFile(baseDir / "test/kitchen-sink.json"))

  test "parsing with schema support":
    let ast = parseStringWithExperimentalSchemaSupport(readFile(baseDir / "test/schema-kitchen-sink.graphql").cstring, error)

    checkAST(ast, error)

    let json = astToJson(ast)
    require($json == $readFile(baseDir / "test/schema-kitchen-sink.json"))
