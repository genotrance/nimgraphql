import unittest, nimgraphql/[GraphQLAstNode, GraphQLParser, GraphQLAstToJSON, GraphQLAstVisitor]

suite "GraphQL Parsing Tests":

  setup:
    var error = allocCStringArray([""])

  teardown:
    deallocCStringArray(error)

  proc checkAST(astNode: ptr AstNode, error: cstringArray) =
    if astNode.isNil:
      let errorMsg = $error[0]
      errorFree(error[0])
      require(false)

  test "parsing without schema support":
    let ast = parseString(readFile("nimgraphql/test/kitchen-sink.graphql").cstring, error)

    checkAST(ast, error)

    let json = astToJson(ast)
    require($json == $readFile("nimgraphql/test/kitchen-sink.json"))

  test "parsing with schema support":
    let ast = parseStringWithExperimentalSchemaSupport(readFile("nimgraphql/test/schema-kitchen-sink.graphql").cstring, error)

    checkAST(ast, error)

    let json = astToJson(ast)
    require($json == $readFile("nimgraphql/test/schema-kitchen-sink.json"))
