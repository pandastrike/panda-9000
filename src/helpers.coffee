{path, join} = require "path"
{glob, read, write, async, curry, mkdirp} = require "fairmont"
jade = require "jade"
coffee = require "coffee-script"
stylus = require "stylus"
fs = require "fs"
{promise} = require "when"

_parse = parse
parse = (path) ->
  {dir, name, ext} = _parse path
  path: path
  directory: dir
  name: name
  extension: ext

_glob = glob
glob = curry (directory, pattern) ->
  go [
    _glob pattern, directory
    map (path) ->
      {path, directory, name, extension} = parse path
      path: join directory, name
      source: {path, directory, name, extension}
      target: {}
      data: {}

compileJade = ({source, target, data}) ->
  render = jade.compileFile source.path, cache: false
  target.content = render data

compileStylus = async ({source, target}) ->
  code = yield read source.path
  target.content = yield promise (resolve, reject) ->
    stylus.render code,
      filename: source.path
      (error, css) -> unless error? then resolve css else reject error

compileCoffeeScript = async ({source, target}) ->
  target.content = coffee.compile yield read source.path

writeFile = curry binary async (directory, {path, target}) ->
  target.path ?= do ->
    target = parse (join directory, "#{path}#{extension}")
  yield mkdirp "0777", (target.directory)
  yield write target.path, target.content

module.exports = {glob, compileJade, compileStylus, compileCoffeeScript,
  writeFile}
