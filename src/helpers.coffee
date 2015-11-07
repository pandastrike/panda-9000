{parse, relative, join} = require "path"
{flow, map, glob,
read, write, async, include,
curry, binary,
mkdirp} = require "fairmont"
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

createContext = curry (_directory, _path) ->
  {path, directory, name, extension} = parse _path
  path: relative _directory, (join directory, name)
  name: name
  source: {path, directory, name, extension}
  target: {}
  data: {}

compileJade = async ({source, target, data}) ->
  source.content ?= yield read source.path
  render = jade.compile source.content, filename: source.path
  target.content = render data

compileStylus = async ({source, target}) ->
  source.content ?= yield read source.path
  target.content = yield promise (resolve, reject) ->
    stylus.render source.content, filename: source.path,
      (error, css) -> unless error? then resolve css else reject error

compileCoffee = async ({source, target}) ->
  source.content ?= yield read source.path
  target.content = coffee.compile source.content

writeFile = curry binary async (directory, {path, target, source}) ->
  if target.content?
    if !target.path?
      extension = if target.extension?
        target.extension
      else if source.extension?
        source.extension
      else ""
      include target,
        parse (join directory, "#{path}#{extension}")
    yield mkdirp "0777", (target.directory)
    yield write target.path, target.content

module.exports = {createContext,
  compileJade, compileStylus, compileCoffee,
  writeFile}
