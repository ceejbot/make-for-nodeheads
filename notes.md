


Tasks:

- build all the .less files into .css files
- minify the CSS files
- browserify all the JS files
- minify the browserified file
- crunch all asset sources & copy them into the output directory

Each of these tasks breaks down into

- a list of desired output files
- lists of source files that the outputs depend on
- rules for transforming the source file format into the output file format

Concepts:

- dependencies
- transformations
- simple shell commands executed to transform files
- rules can chain
- you read backwards: output back to intermediate back to source


## Make


## Fez

### Tup

maybe some discussion of tup as inspiration for fez


## Examples

Show examples with Make & Fez. The repo itself should serve as a set of examples for the talk. Write a makefile & a fez thingie, each of which produces a built read-to-project version of the slides in this talk.
