{parse, relative, join} = require "path"
{flow, map, glob,
async, promise,
read, write, include,
curry, binary,
mkdirp} = require "fairmont"
_write = write
_jade = require "jade"
_coffee = require "coffee-script"
_stylus = require "stylus"
_sass = require "node-sass"

_parse = parse
parse = (path) ->
  {dir, name, ext} = _parse path
  path: path
  directory: dir
  name: name
  extension: ext

context = curry (_directory, _path) ->
  {path, directory, name, extension} = parse _path
  path: relative _directory, (join directory, name)
  name: name
  source: {path, directory, name, extension}
  target: {}
  data: {}

jade = async ({source, target, data}) ->
  source.content ?= yield read source.path
  render = _jade.compile source.content, filename: source.path
  target.content = render data

sass = async ({source, target}) ->
  source.content ?= yield read source.path
  target.content = yield promise (resolve, reject) ->
    _sass.render data: source.content, file: source.path, (error, result) ->
      unless error? then resolve result.css.toString() else reject error


stylus = async ({source, target}) ->
  source.content ?= yield read source.path
  target.content = yield promise (resolve, reject) ->
    _stylus.render source.content, filename: source.path,
      (error, css) -> unless error? then resolve css else reject error

coffee = async ({source, target}) ->
  source.content ?= yield read source.path
  target.content = _coffee.compile source.content

write = curry binary async (directory, {path, target, source}) ->
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
    yield _write target.path, target.content

module.exports = {context, jade, stylus, coffee, write, sass}
