Nimgraphql is a [Nim](https://nim-lang.org/) wrapper for the [libgraphqlparser](https://github.com/graphql/libgraphqlparser) library.

Nimgraphql is distributed as a [Nimble](https://github.com/nim-lang/nimble) package and depends on [nimgen](https://github.com/genotrance/nimgen) and [c2nim](https://github.com/nim-lang/c2nim/) to generate the wrappers. Python v2 is also required to generate some header files so ensure `python2` is in the path. The libgraphqlparser source code is downloaded using Git so having ```git``` in the path is required.

__Installation__

Nimgraphql can be installed via [Nimble](https://github.com/nim-lang/nimble):

```
> nimble install https://github.com/genotrance/nimgraphql
```

This will download, wrap and install nimgraphql in the standard Nimble package location, typically ~/.nimble. Once installed, it can be imported into any Nim program.

__Usage__

Refer to the ```tests``` directory for examples on how the library can be used.

__Credits__

Nimgraphql wraps the graphql source code and all licensing terms of [graphql](https://github.com/graphql/libgraphqlparser/blob/master/LICENSE) apply to the usage of this package.

Credits go out to [c2nim](https://github.com/nim-lang/c2nim/) as well without which this package would be greatly limited in its abilities.

__Feedback__

Nimgraphql is a work in progress and any feedback or suggestions are welcome. It is hosted on [GitHub](https://github.com/genotrance/nimgraphql) with an MIT license so issues, forks and PRs are most appreciated.
